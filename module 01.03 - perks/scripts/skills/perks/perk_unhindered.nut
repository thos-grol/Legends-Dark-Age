
this.perk_unhindered <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.unhindered";
		this.m.Name = ::Const.Strings.PerkName.Unhindered;
		this.m.Description = ::Const.Strings.PerkDescription.Unhindered;
		this.m.Icon = "ui/perks/unhindered.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.PhysicalResistance = 2;
	}
});