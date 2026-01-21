this.stun_strike_skill <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 20,
		charges = 0,
		charges_max = 3
	},
	function create()
	{
		this.m.ID = "actives.stun_strike";
		this.m.Name = "Stun Strike";
		this.m.Description = "Consume 3 charges to strike the enemy with your shield. If it hits, deal an unresistatable stun for 2 turns.\n\nCharges are generated when hit by attacks";
		this.m.KilledString = "Bashed to death";
		this.m.Icon = "skills/stun_strike.png";
		this.m.IconDisabled = "skills/stun_strike_bw.png";
		this.m.Overlay = "stun_strike";
		this.m.SoundOnUse = [
			"sounds/combat/cudgel_01.wav",
			"sounds/combat/cudgel_02.wav",
			"sounds/combat/cudgel_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/cudgel_hit_01.wav",
			"sounds/combat/cudgel_hit_02.wav",
			"sounds/combat/cudgel_hit_03.wav",
			"sounds/combat/cudgel_hit_04.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 33;
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

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult *= _properties.IsProficientWithShieldWall ? 0.25 : 1.0;
		this.m.FatigueCostMult *= _properties.BlockMastery ? 0.75 : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.m.charges = 0;

		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

		local success = this.attackEntity(_user, target);
		if (!_user.isAlive() || _user.isDying()) return success;
		
		// add T2 Stun
		if (success && target.isAlive())
		{
			::Z.S.add_effect( actor, _targetEntity, ::Legends.Effect.Stunned, 4);
		}

		return success;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local has_shield = shield != null && shield.isItemType(this.Const.Items.ItemType.Shield);
		return !has_shield;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local has_shield = shield != null && shield.isItemType(this.Const.Items.ItemType.Shield);
		
		return this.skill.isUsable()
			&& has_shield
			&& this.m.charges == this.m.charges_max;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.charges < this.m.charges_max)
		{
			this.m.charges++;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();

			// remove weapon damage while keeping other bonuses
			local items = actor.getItems();
			local mainhand = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
			if (mainhand != null && "RegularDamage" in mainhand.m)
			{
				_properties.DamageRegularMin -= mainhand.m.RegularDamage;
				_properties.DamageRegularMin = ::Math.max(0, _properties.DamageRegularMin);

				_properties.DamageRegularMax -= mainhand.m.RegularDamageMax;
				_properties.DamageRegularMax = ::Math.max(0, _properties.DamageRegularMax);
			}

			// add a hit chance bonus, it's easier to strike enemies with a shield
			_properties.MeleeSkill += this.m.BUFF;
			_skill.m.HitChanceBonus += this.m.BUFF;

			// simulate shield as a weapon
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 30;

			// if (this.getContainer().hasPerk(::Legends.Perk.ShieldBash))
			// {
			// 	_properties.DamageRegularMin = 8;
			// 	_properties.DamageRegularMax = 15;
			// }
		}
	}

	function onCombatStarted()
	{
		this.m.charges = 0;
	}

	function onCombatFinished()
	{
		this.m.charges = 0;
	}

});

