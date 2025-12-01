
this.perk_lions_roar <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.lions_roar";
		this.m.Name = ::Const.Strings.PerkName.LionsRoar;
		this.m.Description = ::Const.Strings.PerkDescription.LionsRoar;
		this.m.Icon = "ui/perks/lions_roar.png";
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