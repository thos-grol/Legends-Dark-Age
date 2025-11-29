
this.perk_heavy_counter <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.heavy_counter";
		this.m.Name = ::Const.Strings.PerkName.HeavyCounter;
		this.m.Description = ::Const.Strings.PerkDescription.HeavyCounter;
		this.m.Icon = "ui/perks/heavy_counter.png";
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