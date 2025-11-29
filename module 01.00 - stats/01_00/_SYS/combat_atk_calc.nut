::mods_hookBaseClass("skills/skill", function (o) {
// while(!("attackEntity" in o)) o = o[o.SuperName];
while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];
o.attackEntity = function( _user, _targetEntity, _allowDiversion = true )
{
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
    local RET;


	RET = ::Z.S.get_ranged_details(_user);
    local ranged_mult = RET.ranged_mult;
    local melee_mult = RET.melee_mult;

	local skill = properties.MeleeSkill * properties.MeleeSkillMult;
	skill *= (this.m.IsRanged ? ranged_mult : melee_mult);

	toHit = toHit + skill;
	toHit = toHit - defense;

	if (this.m.IsRanged)
	{
		toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
	}

	if (levelDifference < 0) toHit = toHit + ::Const.Combat.LevelDifferenceToHitBonus;
	else toHit = toHit + ::Const.Combat.LevelDifferenceToHitMalus * levelDifference;

	if (!this.m.IsShieldRelevant) // if is ignoring shield bonus
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
		if (this.m.IsRanged) shieldBonus *= 0.75;
		
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Shieldwall)) shieldBonus = shieldBonus * 2;
	}

	toHit = toHit * properties.TotalAttackToHitMult;
	toHit = toHit + ::Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);

	if (this.m.IsRanged && !_allowDiversion && this.m.IsShowingProjectile)
	{
		toHit = toHit - 15;
		properties.DamageTotalMult *= 0.75;
	}

	if (defense > -100 && skill > -100)
	{
		toHit = ::Math.max(5, ::Math.min(95, toHit));
	}

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

	if (!_targetEntity.isAbleToDie() && _targetEntity.getHitpoints() == 1)
	{
		toHit = 0;
	}

	if (!this.isUsingHitchance())
	{
		toHit = 100;
	}

	// compute roll range and roll
    local has_focus_target = _targetEntity.getSkills().hasSkill("perk.legend_perfect_focus");
    local has_focus_user = _user.getSkills().hasSkill("perk.legend_perfect_focus");
	local roll = ::Math.rand(has_focus_target ? 6 : 1, has_focus_user ? 95 : 100);

	local isHit = roll <= toHit;
    if (defenderProperties.IsEvadingAllAttacks)
    {
        isHit = false;
    }

	if (!_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
    {
        if (defenderProperties.IsEvadingAllAttacks)
        {
            ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and " + ::Const.UI.getColorizedEntityName(_targetEntity) + " evades the attack");
        }
        else
        {
            local rolled = roll;
            this.Tactical.EventLog.log_newline();

            if (astray)
            {
                if (this.isUsingHitchance())
                {
                    if (isHit)
                    {
                        ::Z.S.log_skill(_user, _targetEntity, getName(), rolled, toHit, "ASTRAY][HIT", false);
                    }
                    else
                    {
                        ::Z.S.log_skill(_user, _targetEntity, getName(), rolled, toHit, "ASTRAY][MISS", false);
                    }
                }
                else
                {
                    ::Z.S.log_skill(_user, _targetEntity, getName(), rolled, toHit, "ASTRAY][HIT", false, false);
                }
            }
            else if (this.isUsingHitchance())
            {
                if (isHit)
                {
                    ::Z.S.log_skill(_user, _targetEntity, getName(), rolled, toHit, "");
                }
                else
                {
                    ::Z.S.log_skill(_user, _targetEntity, getName(), rolled, toHit, "", false);
                }
            }
            else
            {
                ::Z.S.log_skill(_user, _targetEntity, getName(), rolled, toHit, "", true, false);
            }
	}

	//luck reroll
	local roll_2 = ::Math.rand(1, 100);
	if (isHit && roll_2 <= _targetEntity.getCurrentProperties().RerollDefenseChance)
	{
		if (!_user.getFlags().has("IgnoreLuck"))
		{
			roll = ::Math.rand(1, 100);
			isHit = roll <= toHit;

			if (!isHit)
			{
				::Z.S.log_skill(_user, null, getName(), roll, toHit, "LUCK REROLL (" + roll_2 + " vs " + _targetEntity.getCurrentProperties().RerollDefenseChance + ")][DODGE");
			}
			else
			{
				::Z.S.log_skill(_user, null, getName(), roll, toHit, "LUCK REROLL (" + roll_2 + " vs " + _targetEntity.getCurrentProperties().RerollDefenseChance + ")][FAIL", false);
			}
		}
		else
		{
			::Tactical.EventLog.log(
				::Const.UI.getColorizedEntityName(_user) + ::MSU.Text.colorRed(" IS IGNORING LUCK")
			);
		}

	}

	if (isHit)
	{
		this.getContainer().setBusy(true);
		local info = {
			Skill = this,
			Container = this.getContainer(),
			User = _user,
			TargetEntity = _targetEntity,
			Properties = properties,
			DistanceToTarget = distanceToTarget
		};

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
		_targetEntity.onMissed(_user, this, this.m.IsShieldRelevant && shield != null && roll <= toHit + shieldBonus * 2);
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

		if (_allowDiversion && this.m.IsRanged && !(this.m.IsShieldRelevant && shield != null && roll <= toHit + shieldBonus * 2) && !prohibitDiversion && distanceToTarget > 2)
		{
			this.divertAttack(_user, _targetEntity);
		}
		else if (this.m.IsShieldRelevant && shield != null && roll <= toHit + shieldBonus * 2)
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
}});