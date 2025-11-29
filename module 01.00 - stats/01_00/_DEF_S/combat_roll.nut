// Defines functions to help calculate graze band and ranged modifiers
//  - This is necessary because we smooshed melee and ranged attack into a single stat called skill
//  - Units can only used ranged attacks if they have the correct prerequistes

// =================================================================================================
// Associated tmp variables and managers
// =================================================================================================


// =================================================================================================
// Main
// =================================================================================================

::Z.S.calc_graze_band <- function(x)
{
    local hit = ::Math.max(0, ::Math.min(100, x));
    local miss = 100 - hit;

    local hit_d = ::Math.max(0, hit - 10);
    local miss_d = ::Math.max(0, miss - 10);
    local graze = 100 - hit_d - miss_d;

    return [miss_d, miss_d + graze, miss_d + graze + hit];
}

::Z.S.get_hit_result <- function(band, roll)
{
    if (roll <= band[0]) return HIT_RESULT.MISS; //roll <= miss
    if (roll <= band[1]) return HIT_RESULT.GRAZE; //roll <= miss + graze
    return HIT_RESULT.HIT;
}

::Z.S.get_ranged_mult <- function(_actor)
{
    local is_ranged = ::has_skill(_actor, "trait._ranged_focus") 
        || (!_actor.isPlayerControlled() && _actor.getAIAgent().getProperties().IsRangedUnit);
    
    if (!is_ranged) return 0;
    
    local mult = 1.0;
    local _properties = _actor.getCurrentProperties();

    // permanent injury, missing eye
    if (::has_skill(_actor, "injury.missing_eye")) 
        mult *= ::has_skill(_actor, "perk.legend_specialist_cult_armor") ? 0.9 : 0.5;
    
    // check properties if actor is affected by stuff
    // temp injury
    if (_properties.IsAffectedByInjuries && ::Z.S.is_injury_applied(_actor, _properties, "injury.grazed_eye_socket"))
        mult *= 0.5;

    // night and night owl
    if (_properties.IsAffectedByNight && ::has_skill(_actor, "special.night"))
        mult *= ::has_skill(_actor, "trait.night_owl") ? 0.85 : 0.7;

    // rain
    if (_properties.IsAffectedByRain && ::has_skill(_actor, "special.legend_rain")) 
        mult *= 0.9;

    // smoke    
    if (::has_skill(_actor, "effects.smoke"))
        mult *= 0.5;

    return mult;
}

// =================================================================================================
// Helper
// =================================================================================================

::Z.S.is_injury_applied <- function(_actor, _properties, _id)
{
    local injury = _actor.getSkills().getSkillByID(_id);
    if (injury == null) return false;

    if (!_properties.IsAffectedByFreshInjuries && injury.m.IsFresh) return false;
    return true;
}