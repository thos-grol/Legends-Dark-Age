
this.perk_heavy_counter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.heavy_counter";
		this.m.Name = ::Const.Strings.PerkName.HeavyCounter;
		this.m.Description = ::Const.Strings.PerkDescription.HeavyCounter;
		this.m.Icon = "ui/perks/heavy_counter.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function consume_flaw_child(_actor, _targetEntity)
	{
		local roll = ::Math.rand(1, 100);
		if (roll <= 25) ::Z.S.add_effect( _actor, _targetEntity, ::Legends.Effect.Stunned, 2);
		else ::Z.S.add_effect( _actor, _targetEntity, ::Legends.Effect.Dazed, 2);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null) return;

		local actor = this.getContainer().getActor();
		if (_targetEntity == actor) return;

		// striking targets with flaw will detonate into a debuff
		local flaw = _targetEntity.getSkills().getSkillByID("effects.flaw");
		if (flaw != null)
		{
			flaw.consume_flaw(actor, _targetEntity);
		}
		else
		{
			if (::Tactical.TurnSequenceBar.getActiveEntity() != null 
			&& ::Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID()) return;
			::Z.S.add_effect_lite(actor, _targetEntity, ::Legends.Effect.Flaw);
		}
	}
});