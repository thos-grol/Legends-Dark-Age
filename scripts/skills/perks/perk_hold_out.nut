::Const.Strings.PerkName.HoldOut <- "Resilient";
::Const.Strings.PerkDescription.HoldOut <- "Resist what ails the common man..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– 1 duration for negative status effects")
+ "\n"+::MSU.Text.colorGreen("+10") + " Vitality"
+ "\n"+::MSU.Text.colorGreen("+33%") + " chance to survive being struck down (Base: 33%)";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Name = ::Const.Strings.PerkName.HoldOut;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Tooltip = ::Const.Strings.PerkDescription.HoldOut;

this.perk_hold_out <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.hold_out";
		this.m.Name = ::Const.Strings.PerkName.HoldOut;
		this.m.Description = ::Const.Strings.PerkDescription.HoldOut;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.NegativeStatusEffectDuration += -1;
		_properties.Hitpoints += 10;
		_properties.SurviveWithInjuryChanceMult *= 1.33;
	}

});

