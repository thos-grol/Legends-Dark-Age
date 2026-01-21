
this.perk_fast_adaptation2 <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
	},
	function create()
	{
		this.m.ID = "perk.fast_adaptation2";
		this.m.Name = ::Const.Strings.PerkName.FastAdaptation2;
		this.m.Description = ::Const.Strings.PerkDescription.FastAdaptation2;
		this.m.Icon = "ui/perks/fast_adaptation2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.Stacks > 0 && _skill.isAttack())
		{
			local bonus = 15 * this.m.Stacks;
			_properties.MeleeSkill += bonus;
			
			if (!_skill.isRanged()) _skill.m.HitChanceBonus += bonus;
			else _skill.m.AdditionalAccuracy += bonus;
		}

		if (_targetEntity == null) return;

		local flaw = _targetEntity.getSkills().getSkillByID("effects.flaw");
		if (flaw != null) 
		{
			local bonus = 15;
			_properties.MeleeSkill += bonus;
			if (!_skill.isRanged()) _skill.m.HitChanceBonus += bonus;
			else _skill.m.AdditionalAccuracy += bonus;
		}
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});