
this.perk_poison_master <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.poison_master";
		this.m.Name = ::Const.Strings.PerkName.PoisonMaster;
		this.m.Description = ::Const.Strings.PerkDescription.PoisonMaster;
		this.m.Icon = "ui/perks/poison_master.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.PoisonResistance += 2;
	}
});