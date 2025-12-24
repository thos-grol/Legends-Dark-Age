// Defines functions to help calculate damage

// =================================================================================================
// Associated tmp variables and managers
// =================================================================================================


// =================================================================================================
// Main
// =================================================================================================

::Z.S.get_strike_roll <- function(attacker_properties, defenderProperties)
{
    local attacker_strike = ::Z.S.get_strike(attacker_properties);
    local defender_strike = ::Z.S.get_strike(defenderProperties, false);
    local result = attacker_strike - defender_strike;

    local r1 = ::Math.rand(attacker_properties.DamageRegularMin, attacker_properties.DamageRegularMax);
    local r2 = ::Math.rand(attacker_properties.DamageRegularMin, attacker_properties.DamageRegularMax);

    local r;
    if (result == 0) r = r1;
    else if (result > 0) r = ::Math.max(r1, r2);
    else if (result < 0) r = ::Math.min(r1, r2);
    return r;
}

// =================================================================================================
// Helper
// =================================================================================================

::Z.S.get_strike <- function(p, attack=true)
{
    local advantage = 0;
    if (attack)
    {
        if (p.Disstrike_Attack) advantage--;
        if (p.Strike_Attack) advantage++;
    }
    else
    {
        if (p.Disstrike_Defense) advantage--;
        if (p.Strike_Defense) advantage++;
    }
    return advantage;
}