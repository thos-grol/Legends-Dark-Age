local pt = [];

// =================================================================================================
// 2
// =================================================================================================
    
::Legends.Perk.Tempi <- null;
pt.push({
    ID = "perk.tempi",
    Script = "scripts/skills/perks/perk_tempi",
    Name = ::Const.Strings.PerkName.Tempi,
    Tooltip = ::Const.Strings.PerkDescription.Tempi,
    Icon = "ui/perks/tempi.png",
    IconDisabled = "ui/perks/tempi_sw.png",
    Const = "Tempi"
});
        
// =================================================================================================
// 4
// =================================================================================================
    
::Legends.Perk.SpecSword2 <- null;
pt.push({
    ID = "perk.specsword2",
    Script = "scripts/skills/perks/perk_specsword2",
    Name = ::Const.Strings.PerkName.SpecSword2,
    Tooltip = ::Const.Strings.PerkDescription.SpecSword2,
    Icon = "ui/perks/specsword2.png",
    IconDisabled = "ui/perks/specsword2_sw.png",
    Const = "SpecSword2"
});
        
// =================================================================================================
// 6
// =================================================================================================
    
::Legends.Perk.TheStrongest <- null;
pt.push({
    ID = "perk.the_strongest",
    Script = "scripts/skills/perks/perk_the_strongest",
    Name = ::Const.Strings.PerkName.TheStrongest,
    Tooltip = ::Const.Strings.PerkDescription.TheStrongest,
    Icon = "ui/perks/the_strongest.png",
    IconDisabled = "ui/perks/the_strongest_sw.png",
    Const = "TheStrongest"
});
        
::Const.Perks.addPerkDefObjects(pt);