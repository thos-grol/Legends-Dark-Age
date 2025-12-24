this.lions_roar <- this.inherit("scripts/skills/skill", {
	m = {
		charges = 0,
		charges_max = 8
	},
	function create()
	{
		this.m.ID = "actives.lions_roar";
		this.m.Name = "Lion\'s Roar";
		this.m.Description = "Consume 8 charges to apply T4 Stun to all enemies in ZOC and T4 Weakness to all enemies in 2 tiles. If HP drops to 33% this skill automatically triggers.\n\nCharges are generated when hit by attacks";
		this.m.KilledString = "Bashed to death";
		this.m.Icon = "skills/lions_roar.png";
		this.m.IconDisabled = "skills/lions_roar_bw.png";
		this.m.Overlay = "lions_roar";
		this.m.SoundOnUse = [
			"sounds/general/lions_roar.wav",
		];
		this.m.SoundOnHit = [];
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsStacking = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;

		this.m.IsTargeted = false;
		this.m.IsAttack = false;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function isHidden()
	{
		return false;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();

		ret.push({
			id = 4,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Charges: " + this.m.charges + "/" + this.m.charges_max
		});

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.charges = 0;
		local tag = {
			User = _user,
			TargetTile = _targetTile,
			Skill = this
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 250, this.roar, tag);
		return true;
	}

	function roar( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.isAlliedWith(_tag.User)) continue;
				if (a.getID() == _tag.User.getID()) continue;
				local tl = a.getTile();
				if (tl.getDistanceTo(mytile) <= 2)
				{
					::Z.S.add_effect( _tag.User, a, ::Legends.Effect.Weakness, 4);
					_tag.Skill.spawnAttackEffect(tl, ::Const.Tactical.AttackEffectBash);
				}
				if (a.getTile().getDistanceTo(mytile) <= 1)
				{
					::Z.S.add_effect( _tag.User, a, ::Legends.Effect.Stunned, 4);
				}
			}
		}
	}

	function isUsable()
	{
		return this.skill.isUsable()
			&& this.m.charges == this.m.charges_max;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		if (this.m.charges < this.m.charges_max)
		{
			this.m.charges++;
		}

		local pct = actor.getHitpointsPct();
		if (pct <= 0.33) this.useForFree(actor.getTile());
	}
});

