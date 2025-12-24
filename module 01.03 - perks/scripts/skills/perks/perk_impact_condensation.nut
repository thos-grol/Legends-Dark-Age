
this.perk_impact_condensation <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 0.25,
		stacks = 0,
		stacks_max = 4
	},
	function create()
	{
		this.m.ID = "perk.impact_condensation";
		this.m.Name = ::Const.Strings.PerkName.ImpactCondensation;
		this.m.Description = ::Const.Strings.PerkDescription.ImpactCondensation;
		this.m.Icon = "ui/perks/impact_condensation.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.Overlay = "impact_condensation";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		this.m.stacks = ::Math.max(0, this.m.stacks - 3);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.stacks >= this.m.stacks_max) return;
		this.m.stacks++;
		
		// spawn overlay effect
		local _c = this.getContainer();
		if (_c != null && _c.getActor().isPlacedOnMap() && this.m.Overlay != "")
		{
			this.spawnIcon(this.m.Overlay, _c.getActor().getTile());
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || !_skill.isAttack()) return;
		local actor = this.getContainer().getActor();
		if (_attacker != null && _attacker.getID() == actor.getID()) return;

		local buff_mult = 1.0 - this.m.BUFF * this.m.stacks;
		_properties.DamageReceivedRegularMult *= buff_mult;
		_properties.DamageReceivedArmorMult *= buff_mult;

		if (!_attacker.isHiddenToPlayer() && !actor.isHiddenToPlayer())
		{
			::Tactical.EventLog.logIn("Impact Condensation (" + this.m.BUFF * this.m.stacks * 100 + "%)");
		}
	}
});