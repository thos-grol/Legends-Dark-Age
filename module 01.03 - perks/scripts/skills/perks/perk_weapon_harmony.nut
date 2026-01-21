
this.perk_weapon_harmony <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 10,
		_4AP_charges = 0,
		is_spent = false
	},
	function create()
	{
		this.m.ID = "perk.weapon_harmony";
		this.m.Name = ::Const.Strings.PerkName.WeaponHarmony;
		this.m.Description = ::Const.Strings.PerkDescription.WeaponHarmony;
		this.m.Icon = "ui/perks/weapon_harmony.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.Overlay = "weapon_harmony";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.SkillType == SKILL_TYPE.PHYSICAL)
		{
			_properties.DamageRegularMin += this.m.BUFF;
			_properties.DamageRegularMax += this.m.BUFF;
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

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_skill == null) return;
		if (this.m.is_spent) return;
		if (_skill.getActionPointCost() <= 4) 
		{
			this.m._4AP_charges++;
			if (this.m._4AP_charges <= 1) return;
		}
		
		local actor = this.getContainer().getActor();
		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, actor.getPos());
			}

			this.spawnIcon(this.m.Overlay, actor.getTile());
		}

		this.m.is_spent = true;
	}

	

	function onTurnStart()
	{
		this.m._4AP_charges = 0;
		this.m.is_spent = false;
	}

	function onTurnEnd()
	{
		this.m._4AP_charges = 0;
		this.m.is_spent = false;
	}
 
	function onCombatStarted()
	{
		this.m._4AP_charges = 0;
		this.m.is_spent = false;
	}

	function onCombatFinished()
	{
		this.m._4AP_charges = 0;
		this.m.is_spent = false;
	}
});