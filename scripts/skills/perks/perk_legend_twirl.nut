::Const.Strings.PerkName.LegendTwirl <- "Twirl";
::Const.Strings.PerkDescription.LegendTwirl <- "Gracefully redirect the enemy... and land them in danger!"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Rotation\' (3 AP, 25 Fat):")
+ "\nSwitch places with an allied unit"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+"Rotation now targets enemies and has a 20% chance to stagger them"
+ "\n"+::MSU.Text.colorRed("The chance to stagger becomes 40% if this unit has the Rotation perk");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Name = ::Const.Strings.PerkName.LegendTwirl;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Icon = "ui/perks/twirl.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].IconDisabled = "ui/perks/twirl_bw.png";

//////////////////

::Const.Strings.PerkName.Rotation = "Rotation";
::Const.Strings.PerkDescription.Rotation = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Rotation\' (3 AP, 25 Fat):")
+ "\nSwitch places with an allied unit"
+ "\n"+::MSU.Text.colorRed("Invalid if either character is stunned, rooted or otherwise disabled");

//////////////////

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rotation].Name = ::Const.Strings.PerkName.Rotation;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rotation].Tooltip = ::Const.Strings.PerkDescription.Rotation;

this.perk_legend_twirl <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_twirl";
		this.m.Name = ::Const.Strings.PerkName.LegendTwirl;
		this.m.Description = ::Const.Strings.PerkDescription.LegendTwirl;
		this.m.Icon = "ui/perks/twirl_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

