
this.perk_mettle <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.mettle";
		this.m.Name = ::Const.Strings.PerkName.Mettle;
		this.m.Description = ::Const.Strings.PerkDescription.Mettle;
		this.m.Icon = "ui/perks/mettle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += 5;
	}
});