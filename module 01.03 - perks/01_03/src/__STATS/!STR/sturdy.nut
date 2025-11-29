// Colossus

::Const.Strings.PerkName.Colossus <- "Colossus";
::Const.Strings.PerkDescription.Colossus <- "This character looms over their enemies..."
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+2") + " Health";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Colossus].Name <- ::Const.Strings.PerkName.Colossus;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Colossus].Tooltip <- ::Const.Strings.PerkDescription.Colossus;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Colossus].Icon <- "ui/perks/colossus.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Colossus].IconDisabled <- "ui/perks/colossus_sw.png";

// HoldOut

::Const.Strings.PerkName.HoldOut <- "Resilient";
::Const.Strings.PerkDescription.HoldOut <- "Resist what ails the common man..."
+ "\n\n" + ::blue("« Passive »")
+ "\n"+::green("– 1 Status Duration (Negative)")
+ "\n"+::green("+10") + " Health"
+ "\n"+::green("+33%") + " Survival Chance (Base: 33%)";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Name <- ::Const.Strings.PerkName.HoldOut;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Tooltip <- ::Const.Strings.PerkDescription.HoldOut;

// NineLives

::Const.Strings.PerkName.NineLives <- "Nine Lives";
::Const.Strings.PerkDescription.NineLives <- "Like a cat..."
+ "\n\n" + ::blue("Upon taking fatal damage:")
+ "\n"+::green("+Death immunity") + " till turn start"
+ "\n"+::green("+Remove DOT effects")
+ "\n"+::red("Effect occurs once per battle");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.NineLives].Name <- ::Const.Strings.PerkName.NineLives;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.NineLives].Tooltip <- ::Const.Strings.PerkDescription.NineLives;

// Indomitable

::Const.Strings.PerkName.Indomitable <- "Indomitable";
::Const.Strings.PerkDescription.Indomitable <- ::purple("Destiny")
+ "\n" + "Indomitable, like the mountain..."

+ "\n\n" + ::blue("Become Indomitable:")
+ "\n " + ::green("– 50%") + " damage taken"
+ "\n" + ::green("+Stun Immunity")
+ "\n" + ::green("+Displacement Immunity");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Indomitable].Name <- ::Const.Strings.PerkName.Indomitable;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Indomitable].Tooltip <- ::Const.Strings.PerkDescription.Indomitable;
