::mods_hookExactClass("skills/effects/spider_poison_effect", function(o)
{
    o.m.Damage <- 5;

    o.getDescription = function()
	{
		return "This character has a vicious poison running through their veins and will lose " + ::red(this.m.Damage) + " Health each turn for " + ::red(this.m.TurnsLeft) + " more turn(s)";
	}

	o.applyDamage = function()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_54", actor.getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, actor.getPos());
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			if (this.m.reduced) hitInfo.DamageRegular = 3;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getAttacker(), this, hitInfo);
		}
	}

    o.onAdded = function()
	{
		if (this.getContainer().hasSkill("trait.ailing")) ++this.m.TurnsLeft;
	}
});
