
this.perk_survival_instinct <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.survival_instinct";
		this.m.Name = ::Const.Strings.PerkName.SurvivalInstinct;
		this.m.Description = ::Const.Strings.PerkDescription.SurvivalInstinct;
		this.m.Icon = "ui/perks/survival_instinct.png";
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