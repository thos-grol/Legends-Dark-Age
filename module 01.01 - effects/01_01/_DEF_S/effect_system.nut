// Defines functions and variables involving effects and their management

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

// ::Z.T.CONTRACT_INFO_BUFFER <- 

// =========================================================================================
// Main
// =========================================================================================

::Z.S.add_effect_lite <- function( actor, target, effect_def )
{
    local ef = ::Legends.Effects.grant(target, effect_def);
    ::Z.S.do_log_logic(target, ef);
}

::Z.S.add_effect <- function( actor, target, effect_def, tier ) 
{
    local effect_id = ::Legends.Effects.getID(effect_def);
    local effect_type = ::DEF.C.EffectsType[effect_id];
    local effect_tiers = ::DEF.C.Effects[effect_id];

    local resistance_tier = ::Z.S.get_effect_resistance_tier( effect_type, target );
    local calculated_tier = ::Math.max(0, ::Math.min(tier - resistance_tier, ::DEF.C.Effects[effect_id].len()));

    local tier_data = effect_tiers[calculated_tier];
    switch (tier_data["result"])
    {
        case "REMOVED":
            ::Z.S.log_resisted(target, effect_def);
            break;
        
        case "REPLACED": // replace this effect with another
            ::Z.S.add_effect( actor, target, tier_data["effect"], tier_data["tier"]);
            break;

        case "REDUCED": // add the effect with reduced magnitude
            local duration = tier_data["duration"];
            local ef = ::Legends.Effects.grant(target, effect_def, function(_effect) {
                _effect.set_turns(duration);
                _effect.set_reduced();
                if ("setActor" in _effect && actor.getFaction() == ::Const.Faction.Player)
                    _effect.setActor(actor);
            }.bindenv(this));
            ::Z.S.do_log_logic(target, ef);
            break;

        case "ADD": // add the effect with normal logic
            local duration = tier_data["duration"];
            local ef = ::Legends.Effects.grant(target, effect_def, function(_effect) {
                _effect.set_turns(duration);
                if ("setActor" in _effect && actor.getFaction() == ::Const.Faction.Player)
                    _effect.setActor(actor);
            }.bindenv(this));
            ::Z.S.do_log_logic(target, ef);
            break;
    }
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.do_log_logic <- function(target, effect) 
{
    if (target == null) return;
    if (target.isHiddenToPlayer()) return;
    ::Z.S.log_effect(target, effect);
}

::Z.S.get_effect_resistance_tier <- function( effect_type, actor ) 
{
    local p = actor.getCurrentProperties();
    switch (effect_type)
    {
        case null:
            return 0;
        case "Physical":
            return p.PhysicalResistance;
        case "Technique":
            return p.TechniqueResistance;

        case "Bleed":
            return p.BleedResistance;
        case "Poison":
            return p.PoisonResistance;

        case "Fire":
            return p.FireResistance;
        case "Ice":
            return p.IceResistance;
        case "Negative":
            return p.NegativeResistance;
    }
}
