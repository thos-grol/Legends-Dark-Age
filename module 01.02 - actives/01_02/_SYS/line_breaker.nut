::mods_hookExactClass("skills/actives/line_breaker", function(o)
{
	o.m.cooldown <- 0;
	o.m.cooldown_max <- 3;

	local create = o.create;
	o.create <- function()
	{
		create();
		this.m.Icon = "skills/line_breaker.png";
		this.m.IconDisabled = "skills/line_breaker_bw.png";
		this.m.Overlay = "line_breaker";
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
	}

	o.getTooltip <- function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
		];

		ret.push({
			id = 4,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Cooldown: " + this.m.cooldown + "/" + this.m.cooldown_max
		});

		return ret;
	}

	o.isUsable <- function()
	{
		return this.skill.isUsable() 
			&& this.m.cooldown == 0;
	}

	o.onTurnStart <- function()
	{
		if (this.m.cooldown > 0) this.m.cooldown--;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Orc"))
		{
			this.m.SoundOnUse = [
				"sounds/combat/knockback_01.wav",
				"sounds/combat/knockback_02.wav",
				"sounds/combat/knockback_03.wav"
			];
			this.m.SoundOnHit = [
				"sounds/combat/knockback_hit_01.wav",
				"sounds/combat/knockback_hit_02.wav",
				"sounds/combat/knockback_hit_03.wav"
			];
		}
	}

	o.onUse <- function ( _user, _targetTile )
	{
		this.m.cooldown = this.m.cooldown_max;

		local target = _targetTile.getEntity();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null)
		{
			return false;
		}

		this.applyFatigueDamage(target, 10);

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " pushes through " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
		}
		else
		{
			local p = this.getContainer().getActor().getCurrentProperties();
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;
			this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true);
		}

		local tag = {
			TargetTile = _targetTile,
			Actor = _user
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 250, this.onFollow, tag);
		return true;
	}

	
});
