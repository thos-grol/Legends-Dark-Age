
this.perk_impact_condensation <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.impact_condensation";
		this.m.Name = ::Const.Strings.PerkName.ImpactCondensation;
		this.m.Description = ::Const.Strings.PerkDescription.ImpactCondensation;
		this.m.Icon = "ui/perks/impact_condensation.png";
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