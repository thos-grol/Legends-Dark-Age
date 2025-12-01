
this.perk_hold_the_line <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.hold_the_line";
		this.m.Name = ::Const.Strings.PerkName.HoldtheLine;
		this.m.Description = ::Const.Strings.PerkDescription.HoldtheLine;
		this.m.Icon = "ui/perks/hold_the_line.png";
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