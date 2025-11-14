::mods_hookExactClass("entity/tactical/actor", function(o)
{
    // function decode_add(_array)
    // Entries appear in these forms:
    //      ["scripts/skills/perks/perk_pathfinder"], // perk
    //      ["D", 2], // tree coordinate
    o.add_perk <- function(_entry, _trees)
    {
        // _defense, _weapon=null, t1=null, t2=null
        local is_perk = _entry.len() == 1;
        if (is_perk) 
        {
            ::Legends.Perks.grant(this, _entry[0]);
        }
        else // is tree coordinate
        {
            local perk_def = null;
            local idx = _entry[1] - 1;
            switch(_entry[0])
            {
                case "D":
                local d = _trees.armor;
                perk_def = d[idx][0];
                break;

                case "W":
                local w = _trees.weapon;
                perk_def = w[idx][0];
                break;

                case "T":
                    local t1 = _trees.trait_1;
                    local t2 = _trees.trait_2;
                    local b = ::Math.rand(1,100) <= 50;
                    perk_def = b ? t1[idx][0] : t2[idx][0];
                    if (!::Legends.Perks.has(this, perk_def)) break;

                    b = !b;
                    perk_def = b ? t1[idx][0] : t2[idx][0];
                break;
            }

            if (perk_def != null) ::Legends.Perks.grant(this, perk_def);
        }
    }

    //==============================================================================================
    // level up functions
    // simulates player levelling for enemies.
    //==============================================================================================

    o.level_health <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 2;
        local upper = 4;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local h = ::Math.rand(lower, upper);
            this.m.BaseProperties.Hitpoints += h;
            this.m.CurrentProperties.Hitpoints += h;
            this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
            this.setHitpoints(this.getHitpointsMax());
        }
    }

    o.level_endurance <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 2;
        local upper = 4;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.Stamina += b;
            this.m.CurrentProperties.Stamina += b;
        }
    }

    o.level_mettle <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 2;
        local upper = 4;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.Bravery += b;
            this.m.CurrentProperties.Bravery += b;
        }
    }

    o.level_agility <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 3;
        local upper = 5;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.Initiative += b;
            this.m.CurrentProperties.Initiative += b;
        }
    }

    o.level_attack <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 1;
        local upper = 3;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.MeleeSkill += b;
            this.m.CurrentProperties.MeleeSkill += b;
        }
    }

    o.level_defense <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 1;
        local upper = 3;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.MeleeDefense += b;
            this.m.CurrentProperties.MeleeDefense += b;
        }
    }

    o.level_strength <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 2;
        local upper = 4;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.RangedSkill += b;
            this.m.CurrentProperties.RangedSkill += b;
        }
    }

    o.level_instinct <- function(_times, _stars_min, _stars_max)
    {
        local _stars = ::Math.rand(_stars_min, _stars_max);
        local lower = 2;
        local upper = 4;
        if (_stars > 0) lower += 1;
        if (_stars > 1) lower += 1;
        if (_stars > 2) upper += 1;

        for (local i = 0; i < _times; i++)
        {
            local b = ::Math.rand(lower, upper);
            this.m.BaseProperties.RangedDefense += b;
            this.m.CurrentProperties.RangedDefense += b;
        }
    }
});