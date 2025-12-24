
this.perk_executioner2 <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 25
	},
	function create()
	{
		this.m.ID = "perk.executioner2";
		this.m.Name = ::Const.Strings.PerkName.Executioner2;
		this.m.Description = ::Const.Strings.PerkDescription.Executioner2;
		this.m.Icon = "ui/perks/executioner2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack()) return;
		if (_targetEntity == null) return;
		if (_targetEntity.getHitpointsPct() > 0.5) return;
		
		_properties.MeleeSkill += this.m.BUFF;
		_properties.HitChance[this.Const.BodyPart.Head] += this.m.BUFF;
		if (!_skill.isRanged())
		{
			_skill.m.HitChanceBonus += this.m.BUFF;
		}
		else if (_skill.isRanged())
		{
			_skill.m.AdditionalAccuracy += this.m.BUFF;
		}
	}
});