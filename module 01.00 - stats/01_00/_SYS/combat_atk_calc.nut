// hk - purpose
// - we smooshed together ratk and matk, so we need to implement custom logic to handle only 1 skill stat
// - we smooshed together rdef and mdef, so we need to implement custom logic to handle only 1 skill stat
// - implement long war's graze band
// - note we're using old hooks here because legends usees the old hooks and using the new hook has no result
::mods_hookBaseClass("skills/skill", function (o) {
while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];

o.attackEntity = function( _user, _targetEntity, _allowDiversion = true )
{
	// hk
	// - removed a whole lot of useless stuff here about attacking scenery, that was hampering
	// readability. Why not implement logic in static functions to be called?
	// hk end
	
	if (_targetEntity != null && !_targetEntity.isAlive())
	{
		return false;
	}

    local properties = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, _targetEntity));
	local userTile = _user.getTile();
	local astray = false;

	if (_allowDiversion && this.m.IsRanged && userTile.getDistanceTo(_targetEntity.getTile()) > 1)
	{
		local blockedTiles = ::Const.Tactical.Common.getBlockedTiles(userTile, _targetEntity.getTile(), _user.getFaction());

		if (blockedTiles.len() != 0 && ::Math.rand(1, 100) <= ::Math.ceil(::Const.Combat.RangedAttackBlockedChance * properties.RangedAttackBlockedChanceMult * 100))
		{
			_allowDiversion = false;
			astray = true;
			_targetEntity = blockedTiles[::Math.rand(0, blockedTiles.len() - 1)].getEntity();
		}
	}

	if (!_targetEntity.isAttackable())
	{
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(_targetEntity.getTile()) >= ::Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}
		this.m.Container.onTargetMissed(this, _targetEntity);

		return false;
	}

    local defenderProperties = _targetEntity.getSkills().buildPropertiesForDefense(_user, this);
	local defense = _targetEntity.getDefense(_user, this, defenderProperties);
	local levelDifference = _targetEntity.getTile().Level - _user.getTile().Level;
	local distanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile());
	local toHit = 0;
	
	// hk
    // - we smooshed together ratk and matk, so we need to implement custom logic to handle only 1 skill stat
	local ranged_mult = ::Z.S.get_ranged_mult(_user);
	local skill = properties.MeleeSkill * properties.MeleeSkillMult;
	if (this.m.IsRanged) skill *= ::Z.S.get_ranged_mult(_user);
	// hk end

	toHit += skill - defense; //used algebra to write a better statement
	// hk - executioner logic
    // if (_user.getSkills().getSkillByID("perk.executioner2") != null && _targetEntity.getHitpointsPct() <= 0.5)
	// {
	// 	toHit += 20
	// }
	// hk end
	

	if (this.m.IsRanged)
	{
		toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
	}

	if (levelDifference < 0)
	{
		toHit = toHit + ::Const.Combat.LevelDifferenceToHitBonus;
	}
	else
	{
		toHit = toHit + ::Const.Combat.LevelDifferenceToHitMalus * levelDifference;
	}

	// hk
	// - we smooshed together rdef and mdef, so we need to implement custom logic to handle only 1 skill stat
	// this handles shield calculations
	if (!this.m.IsShieldRelevant) // aka if is ignoring shield bonus
	{
		local shield = _targetEntity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield)) 
		{
			local s_defense = shield.getMeleeDefense();
			local s_mult = _targetEntity.getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0;
			if (this.m.IsRanged) s_defense *= 0.75;
			s_defense *= s_mult;
			s_defense = ::Math.round(s_defense);
			toHit = toHit + s_defense; // negate the shield bonus from defense
		}
	}

	local shieldBonus = 0;
	local shield = _targetEntity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
	if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield))
	{
		shieldBonus = shield.getMeleeDefense();
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Shieldwall)) shieldBonus = shieldBonus * 2;
	}
	// hk end

	toHit = toHit * properties.TotalAttackToHitMult;
	toHit = toHit + ::Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);

	if (this.m.IsRanged && !_allowDiversion && this.m.IsShowingProjectile)
	{
		toHit = toHit - 15;
		// properties.DamageTotalMult *= 0.75; // why is this here?
	}

	// hk
	// - implement long war's graze band
	// changed to clamp to 0-100 range
	toHit = ::Math.max(0, ::Math.min(100, toHit)); 
	// hk end

	_targetEntity.onAttacked(_user);

	if (this.m.IsDoingAttackMove && !_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
	{
		this.Tactical.getShaker().cancel(_user);

		if (this.m.IsDoingForwardMove)
		{
			this.Tactical.getShaker().shake(_user, _targetEntity.getTile(), 5);
		}
		else
		{
			local otherDir = _targetEntity.getTile().getDirectionTo(_user.getTile());

			if (_user.getTile().hasNextTile(otherDir))
			{
				this.Tactical.getShaker().shake(_user, _user.getTile().getNextTile(otherDir), 6);
			}
		}
	}

	// hk
	// - implement long war's graze band
	local hit_result = HIT_RESULT.MISS;

	local is_rolling = true;
	local is_using_hitchance = this.isUsingHitchance();

	local r = 0;
	local graze_band;
	local roll_info = null;

	// local attacker_advantage = false;
	// local defender_advanage = false;


	if (!_targetEntity.isAbleToDie() && _targetEntity.getHitpoints() == 1) // is_death_immune
	{
		is_rolling = false;
		toHit = 0;
	}

	if (!this.isUsingHitchance()) // guaranteed hit
	{
		is_rolling = false;
		hit_result = HIT_RESULT.HIT;
		toHit = 100;
	}

	local advantage = 0;
	local r1 = 0;
	local r2 = 0;
	
	if (is_rolling)
	{
		graze_band = ::Z.S.calc_graze_band(toHit);
		roll_info = ::Z.S.get_hit_result(graze_band, properties, defenderProperties);
		hit_result = roll_info.HitResult;
		
		//record details
		r = roll_info.R;
		advantage = roll_info.Advantage;
		r1 = roll_info.R1;
		r2 = roll_info.R2;
	}

    if (defenderProperties.IsEvadingAllAttacks)
	{
		hit_result = HIT_RESULT.MISS;
	}

	if (!_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
    {
        this.Tactical.EventLog.log_newline();

		if (defenderProperties.IsEvadingAllAttacks)
        {
            ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and " + ::Const.UI.getColorizedEntityName(_targetEntity) + " evades the attack");
        }
        else
        {
			::Z.S.log_skill({
				User = _user,
				Target = _targetEntity,
				Name = getName(),

				Roll = r,
				R1 = r1,
        		R2 = r2,
				Chance = 0,
				GrazeBand = graze_band,
				HitResult = hit_result,
				ResultType = RESULT_TYPE.GRAZE_BAND,

				IsUsingHitchance = is_using_hitchance,
				Astray = astray,
				Advantage = advantage
			});
		}
	}

	// luck reroll code and log notifications
	local luck_roll = ::Math.rand(1, 100);
	local luck_reroll_chance = _targetEntity.getCurrentProperties().RerollDefenseChance;
	if (is_rolling && hit_result > HIT_RESULT.MISS && luck_roll <= luck_reroll_chance)
	{
		if (_user.getFlags().has("IgnoreLuck")) 
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + ::red(" NEGATES LUCK"));
		else
		{
			r = ::Math.rand(1, 100);
			local temp_result = ::Z.S.get_hit_result(graze_band, properties, defenderProperties);

			if (temp_result < hit_result) # if the luck roll downgraded the hit
			{
				hit_result = temp_result;
				::Z.S.log_skill({
					User = _user,
					Target = null,
					Name = "LUCK REROLL",
	
					Roll = r,
					Chance = 0,
					GrazeBand = graze_band,
					HitResult = hit_result,
					ResultType = RESULT_TYPE.GRAZE_BAND,
	
					IsUsingHitchance = true,
					Advantage = 0
				});
			}
		}
	}
	
	if (hit_result != HIT_RESULT.MISS)
	{
		this.getContainer().setBusy(true);

		if (hit_result == HIT_RESULT.GRAZE) properties.DamageTotalMult *= 0.33;

		local info = {
			Skill = this,
			Container = this.getContainer(),
			User = _user,
			TargetEntity = _targetEntity,
			Properties = properties,
			TargetProperties = defenderProperties,
			DistanceToTarget = distanceToTarget,
			HitResult = hit_result,
		};

		// hk end

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0 && _user.getTile().getDistanceTo(_targetEntity.getTile()) >= ::Const.Combat.SpawnProjectileMinDist && (!_user.isHiddenToPlayer() || !_targetEntity.isHiddenToPlayer()))
		{
			local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;
			local time = this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onScheduledTargetHit, info);

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, time + this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}
		}
		else
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, _targetEntity.getPos());
			}

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && toHit <= 15)
			{
				this.Sound.play(::Const.Sound.ArenaShock[::Math.rand(0, ::Const.Sound.ArenaShock.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
			}

			this.onScheduledTargetHit(info);
		}

		return true;
	}
	else
	{
		local distanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile());
		_targetEntity.onMissed(_user, this, this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2);
		this.m.Container.onTargetMissed(this, _targetEntity);
		local prohibitDiversion = false;

		if (_allowDiversion && this.m.IsRanged && !_user.isPlayerControlled() && ::Math.rand(1, 100) <= 25 && distanceToTarget > 2)
		{
			local targetTile = _targetEntity.getTile();

            for( local i = 0; i < ::Const.Direction.COUNT; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (tile.IsEmpty)
					{
					}
					else if (tile.IsOccupiedByActor && tile.getEntity().isAlliedWith(_user))
					{
						prohibitDiversion = true;
						break;
					}
				}
			}
		}

		if (_allowDiversion && this.m.IsRanged && !(this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2) && !prohibitDiversion && distanceToTarget > 2)
		{
			this.divertAttack(_user, _targetEntity);
		}
		else if (this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2)
		{
			local info = {
				Skill = this,
				User = _user,
				TargetEntity = _targetEntity,
				Shield = shield
			};

			if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
			{
				local divertTile = _targetEntity.getTile();
				local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;
				local time = 0;

				if (_user.getTile().getDistanceTo(divertTile) >= ::Const.Combat.SpawnProjectileMinDist)
				{
					time = this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), divertTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}

				this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onShieldHit, info);
			}
			else
			{
				this.onShieldHit(info);
			}
		}
		else
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[::Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, _targetEntity.getPos());
			}

			if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
			{
				local divertTile = _targetEntity.getTile();
				local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;

				if (_user.getTile().getDistanceTo(divertTile) >= ::Const.Combat.SpawnProjectileMinDist)
				{
					this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), divertTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
			}

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
			{
				if (toHit >= 90 || _targetEntity.getHitpointsPct() <= 0.1)
				{
					this.Sound.play(::Const.Sound.ArenaMiss[::Math.rand(0, ::Const.Sound.ArenaBigMiss.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
				else if (::Math.rand(1, 100) <= 20)
				{
					this.Sound.play(::Const.Sound.ArenaMiss[::Math.rand(0, ::Const.Sound.ArenaMiss.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
			}
		}

		return false;
	}
}

});