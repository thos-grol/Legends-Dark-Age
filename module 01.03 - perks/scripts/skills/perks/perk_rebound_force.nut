
this.perk_rebound_force <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.rebound_force";
		this.m.Name = ::Const.Strings.PerkName.ReboundForce;
		this.m.Description = ::Const.Strings.PerkDescription.ReboundForce;
		this.m.Icon = "ui/perks/rebound_force.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		
		_properties.DamageRegularMin += BUFF;
		_properties.DamageRegularMax += BUFF;
	}
});