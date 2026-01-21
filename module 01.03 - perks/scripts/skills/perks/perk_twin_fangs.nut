
this.perk_twin_fangs <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.twin_fangs";
		this.m.Name = ::Const.Strings.PerkName.TwinFangs;
		this.m.Description = ::Const.Strings.PerkDescription.TwinFangs;
		this.m.Icon = "ui/perks/twin_fangs.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	// main logic

	function onTargetMissed( _skill, _targetEntity )
	{
		check_flaw(_skill, _targetEntity);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		check_flaw(_skill, _targetEntity);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
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

	// helpers

	

	function check_flaw(_skill, _targetEntity)
	{
		if (_targetEntity == null) return;

		local actor = this.getContainer().getActor();
		if (_targetEntity == actor) return;

		local flaw = _targetEntity.getSkills().getSkillByID("effects.flaw");
		if (flaw != null)
		{
			local roll = ::Math.rand(1, 100);
			if (roll <= 25)
			{
				flaw.consume_flaw(actor, _targetEntity);

				//TODO: play sfx sound 
				//TODO: trigger skill icon triggering

				local skill = _tag.User.getSkills().getAttackOfOpportunity();
				if (skill != null)
				{
					local info = {
						User = _tag.User,
						Skill = skill,
						TargetTile = _tag.TargetTile
					};
					this.Time.scheduleEvent(this.TimeUnit.Virtual, this.Const.Combat.RiposteDelay, this.on_aoo.bindenv(this), info);
				}
			}
		}
	}

	function on_aoo( _info )
	{
		if (!_info.User.isAlive()) return;
		_info.Skill.useForFree(_info.TargetTile);
	}
});