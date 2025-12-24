
this.perk_rage <- this.inherit("scripts/skills/skill", {
	m = {
		stacks = 0,
		stacks_max = 1
	},
	function create()
	{
		this.m.ID = "perk.rage";
		this.m.Name = ::Const.Strings.PerkName.Rage;
		this.m.Description = ::Const.Strings.PerkDescription.Rage;
		this.m.Icon = "ui/perks/rage.png";
		this.m.Overlay = "rage";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null) return;

		local actor = this.getContainer().getActor();
		if (_attacker.isAlliedWith(actor)) return;

		// If the damage exceeds 25% of health, chance becomes 100%"
		local dmg = _damageHitpoints + _damageArmor;
		local big_blow = dmg >= ::Math.round(actor.getHitpointsMax() * 0.33);

		if (!big_blow && this.Math.rand(1, 100) > 33) return;
		if (this.m.stacks >= this.m.stacks_max) return;
		
		this.m.stacks++;

		// spawn overlay effect
		local _c = this.getContainer();
		if (_c != null && _c.getActor().isPlacedOnMap() && this.m.Overlay != "")
		{
			this.spawnIcon(this.m.Overlay, _c.getActor().getTile());
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null) return;

		local actor = this.getContainer().getActor();
		if (_targetEntity == actor) return;

		this.m.stacks--;
		this.m.stacks = ::Math.max(0, this.m.stacks);
	}

	function onUpdate( _properties )
	{
		if (this.m.stacks > 0) 
		{
			_properties.DamageTotalMult *= 2.0;
		}
	}
});