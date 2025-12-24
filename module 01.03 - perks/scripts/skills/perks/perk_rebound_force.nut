
this.perk_rebound_force <- this.inherit("scripts/skills/skill", {
	m = {
		primed = false,
		primed_damage = 0,
		charges = 4,
		charges_reset = 4
	},
	function create()
	{
		this.m.ID = "perk.rebound_force";
		this.m.Name = ::Const.Strings.PerkName.ReboundForce;
		this.m.Description = ::Const.Strings.PerkDescription.ReboundForce;
		this.m.Icon = "ui/perks/rebound_force.png";
		this.m.Overlay = "rebound_force";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		this.m.charges = this.m.charges_reset;
	}

	function set_primed_damage(dmg_roll)
	{
		this.m.primed = true;
		this.m.primed_damage = ::Math.round(dmg_roll * 0.25);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!_attacker.isAlive() || _attacker.isDying()) return;
		if (::MSU.isNull(_attacker)) return;
		if (this.m.charges == 0) return;
		if (!this.m.primed || this.m.primed_damage <= 0) return;

		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.m.primed_damage;
		hitInfo.DamageFatigue = this.m.primed_damage;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;

		_attacker.onDamageReceived(this.getContainer().getActor(), this, hitInfo);

		// spawn overlay effect
		local _c = this.getContainer();
		if (_c != null && _c.getActor().isPlacedOnMap() && this.m.Overlay != "")
		{
			this.spawnIcon(this.m.Overlay, _c.getActor().getTile());
		}

		this.m.primed = false;
		this.m.primed_damage = 0;
		this.m.charges = ::Math.max(0, this.m.charges - 1);

		if (::Math.rand(1, 100) <= 25 
			&& !_attacker.getCurrentProperties().IsImmuneToDisarm) 
		{
			::Legends.Effects.grant(_attacker, ::Legends.Effect.Disarmed);
		}
		
		// if (this.m.SoundOnUse.len() != 0)
		// {
		// 	this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		// }
	}
});