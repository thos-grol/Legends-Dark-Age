::Const.Factions.RelationDecayPerDay <- 0;

::m.rawHook("scripts/factions/faction", function(p) {
    // add new fields
    p.m.Contribution <- 0;
    p.m.Strength <- 0;

    p.m.ForceLevel <- 0;
    p.m.Researchers <- 0;

    // boilerplate
    p.get_contribution <- function()
    {
        return this.m.Contribution;
    }
    p.add_contribution <- function(x)
    {
        this.m.Contribution += x;
        this.m.Contribution = ::Math.max(this.m.Contribution, 0);
    }

    p.get_force_level <- function()
    {
        return this.m.ForceLevel;
    }
    p.add_force_level <- function(x)
    {
        this.m.ForceLevel += x;
        this.m.ForceLevel = ::Math.max(this.m.ForceLevel, 0);
    }

    p.get_strength <- function()
    {
        return this.m.Strength;
    }
    p.add_strength <- function(x)
    {
        this.m.Strength += x;
        this.m.Strength = ::Math.max(this.m.Strength, 0);
    }
});

// m = {
//     ID = 0,
//     Name = "",
//     Description = "",
//     Motto = "",
//     BannerPrefix = "",
//     Banner = 1,
//     Base = "",
//     TacticalBase = "",
//     Traits = [],
//     CombatMusic = [],
//     Footprints = this.Const.GenericFootprints,
//     Type = this.Const.FactionType.None,
//     PlayerRelation = 50.0, -> Contribution
//     PlayerRelationChanges = [],
//     RelationDecayPerDay = this.Const.Factions.RelationDecayPerDay,
//     Flags = null,
//     Settlements = [],
//     Units = [],
//     Allies = [],
//     Deck = [],
//     Contracts = [],
//     LastActionTime = 0,
//     LastActionHour = 0,
//     LastContractTime = 0,
//     MaxUnits = 0,
//     IsDiscovered = false,
//     IsHiddenIfNeutral = false,
//     IsHidden = false,
//     IsRelationDecaying = true,
//     IsTemporaryEnemy = false,
//     IsActive = true
// },