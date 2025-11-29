local ids = [
    "EMPTY_AGILE",
    "EMPTY_FIT",
    "EMPTY_STURDY",
    "EMPTY_TENACIOUS",
];
local pt = [];

foreach( id in ids )
{
    ::Const.Strings.PerkName[id] <- "EMPTY";
    ::Const.Strings.PerkDescription[id] <- "";

    ::Legends.Perk[id] <- null;
    pt.push({
        ID = "perk." + id,
        Script = id,
        Name = id,
        Tooltip = id,
        Icon = "ui/perks/null.png",
        IconDisabled = "ui/perks/null.png",
        Const = id
    });
}

::Const.Perks.addPerkDefObjects(pt);