
this.perk_nine_lives2 <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.nine_lives2";
		this.m.Name = ::Const.Strings.PerkName.NineLives2;
		this.m.Description = ::Const.Strings.PerkDescription.NineLives2;
		this.m.Icon = "ui/perks/nine_lives2.png";
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