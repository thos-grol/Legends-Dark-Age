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

::Z.S.get_hit_result <- function(band, attacker_properties, defenderProperties)
{
    local attacker_advantage = ::Z.S.get_advantage(attacker_properties);
    local defender_advantage = ::Z.S.get_advantage(defenderProperties, false);

    if (defenderProperties.Alert_Defense && attacker_advantage >= 1) attacker_advantage = 0;

    local result = attacker_advantage - defender_advantage;
    local r1 = ::Math.rand(1, 100);
    local r2 = ::Math.rand(1, 100);

    local r;
    if (result == 0) r = r1;
    else if (result > 0) r = ::Math.max(r1, r2);
    else if (result < 0) r = ::Math.min(r1, r2);

    local hit_result = HIT_RESULT.HIT;
    if (r <= band[0]) hit_result = HIT_RESULT.MISS; //r <= miss
    else if (r <= band[1]) hit_result = HIT_RESULT.GRAZE; //r <= miss + graze

    return {
        R = r,
        R1 = r1,
        R2 = r2,
        Advantage = result,
        HitResult = hit_result,
    };
}

::Z.S.get_advantage <- function(p, attack=true)
{
    local advantage = 0;
    if (attack)
    {
        if (p.Disadvantage_Attack) advantage--;
        if (p.Advantage_Attack) advantage++;
    }
    else
    {
        if (p.Disadvantage_Defense) advantage--;
        if (p.Advantage_Defense) advantage++;
    }
    return advantage;
}

// =================================================================================================
// Helper
// =================================================================================================

::Z.S.degrade_result <- function(_result)
{
    switch (_result) {
        case HIT_RESULT.HIT:
            return HIT_RESULT.GRAZE;
        case HIT_RESULT.GRAZE:
            return HIT_RESULT.MEGA_GRAZE;
        case HIT_RESULT.MEGA_GRAZE:
            return HIT_RESULT.MISS;
        case HIT_RESULT.MISS:
            return HIT_RESULT.MISS;
    }
}

::Z.S.upgrade_result <- function(_result)
{
    switch (_result) {
        case HIT_RESULT.MISS:
            return HIT_RESULT.MEGA_GRAZE;
        case HIT_RESULT.MEGA_GRAZE:
                return HIT_RESULT.GRAZE;
        case HIT_RESULT.GRAZE:
            return HIT_RESULT.HIT;
        case HIT_RESULT.HIT:
            return HIT_RESULT.HIT;
    }
}

::Z.S.is_injury_applied <- function(_actor, _properties, _id)
{
    local injury = _actor.getSkills().getSkillByID(_id);
    if (injury == null) return false;

    if (!_properties.IsAffectedByFreshInjuries && injury.m.IsFresh) return false;
    return true;
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