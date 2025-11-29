
this.perk_iron_mountain <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.iron_mountain";
		this.m.Name = ::Const.Strings.PerkName.IronMountain;
		this.m.Description = ::Const.Strings.PerkDescription.IronMountain;
		this.m.Icon = "ui/perks/iron_mountain.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		//FEATURE_8: add this.m.IsPhysical = true default to skill class. Then set false for valid
		// skills
		// then add check here to disable increase
		_properties.DamageRegularMin += BUFF;
		_properties.DamageRegularMax += BUFF;
	}
});