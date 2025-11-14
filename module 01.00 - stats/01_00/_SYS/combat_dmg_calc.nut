::mods_hookExactClass("entity/tactical/actor", function(o)
{
    o.onDamageReceived <- function( _attacker, _skill, _hitInfo )
	{
		// pre
        _hitInfo.BodyDamageMultBeforeSteelBrow = _hitInfo.BodyDamageMult;

        if (!this.isAlive() || !this.isPlacedOnMap()) return 0;
		if (_hitInfo.DamageRegular == 0 && _hitInfo.DamageArmor == 0) return 0;

		if (typeof _attacker == "instance") _attacker = _attacker.get();
		if (_attacker != null && _attacker.isAlive() && _attacker.isPlayerControlled() && !this.isPlayerControlled())
		{
			this.setDiscovered(true);
			this.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			this.getTile().addVisibilityForCurrentEntity();
		}

		if (this.m.CurrentProperties.IsImmuneToCriticals || this.m.CurrentProperties.IsImmuneToHeadshots) _hitInfo.BodyDamageMult = 1.0;
		

		// build properties
        local p = this.m.Skills.buildPropertiesForBeingHit(_attacker, _skill, _hitInfo);
		this.m.Items.onBeforeDamageReceived(_attacker, _skill, _hitInfo, p);
		local mult_dmg = p.DamageReceivedTotalMult;
		if (_skill != null)
		{
			mult_dmg *= (_skill.isRanged() ? p.DamageReceivedRangedMult : p.DamageReceivedMeleeMult);
		}

        //1. apply dmg mults including critical
        _hitInfo.DamageRegular *= p.DamageReceivedRegularMult * mult_dmg * _hitInfo.BodyDamageMult;
        _hitInfo.DamageMinimum *= p.DamageReceivedRegularMult * mult_dmg * _hitInfo.BodyDamageMult;

        //2. apply flat reduction
        local hardness = p.Hardness;

        //subtract flat reduction from regular dmg
        _hitInfo.DamageRegular -= p.Hardness; 
        if (_hitInfo.DamageRegular < 0) // if regular dmg is negative, overflow it into pierce dmg
        {
            _hitInfo.DamageMinimum += _hitInfo.DamageRegular;
            _hitInfo.DamageMinimum = ::Math.max(_hitInfo.DamageMinimum, 0); // make non-negative
            _hitInfo.DamageRegular = 0; // make non-negative
        }

        // now this is when we round dmg to ints
        // dmg is always rounded down, unless if it's between 0 and 1
        if (_hitInfo.DamageRegular > 1) _hitInfo.DamageRegular = ::Math.round(::Math.floor(_hitInfo.DamageRegular));
        else if (_hitInfo.DamageRegular > 0 && _hitInfo.DamageRegular <= 1) _hitInfo.DamageRegular = 1;

        if (_hitInfo.DamageMinimum > 1) _hitInfo.DamageMinimum = ::Math.round(::Math.floor(_hitInfo.DamageMinimum));
        else if (_hitInfo.DamageMinimum > 0 && _hitInfo.DamageMinimum <= 1) _hitInfo.DamageMinimum = 1;


        //3. Inflict dmg
        local dmg = _hitInfo.DamageRegular;
        local dmg_armor_total = 0;
        local dmg_armor_innnate = 0;
        local dmg_armor_item = 0;

        local armor = p.Armor[_hitInfo.BodyPart];
        local armor_innate = this.m.BaseProperties.Armor[_hitInfo.BodyPart];
        local armor_item = armor - armor_innate;

        // Armor dmg
        // note p.ArmorMult[_hitInfo.BodyPart] is not used for either innate or item armor now. Just
        // add flat armor if you want more and we don't want to multiply armor anyways. Also search of
        // vanilla code shows that armor mult isn't used anyways. I don't see any rounding either
        // meaning that armor dmg was non-integer wtf

        // calc innate armor dmg
        if (dmg > 0)
        {
            local temp_dmg = 0;
            if (dmg > armor_innate) //innate armor is zeroed
            {
                temp_dmg = armor_innate;
                dmg -= temp_dmg; // update remaining dmg
                armor_innate = 0; // update innate armor
            }
            else // dmg <= armor, dmg is zeroed
            {
                temp_dmg = dmg; 
                dmg = 0; 
                armor_innate -= temp_dmg;
            }
            
            // track armor damge
            dmg_armor_total += temp_dmg; 
            dmg_armor_innnate += temp_dmg;
        }

        // calc item armor dmg
        if (dmg > 0)
        {
            local temp_dmg = 0;
            if (dmg > armor_item) //item armor is zeroed
            {
                temp_dmg = armor_item;
                dmg -= temp_dmg; // update remaining dmg
                armor_item = 0; // update innate armor
            }
            else // dmg <= armor, dmg is zeroed
            {
                temp_dmg = dmg; 
                dmg = 0; 
                armor_item -= temp_dmg;
            }

            // track armor damge
            dmg_armor_total += temp_dmg; 
            dmg_armor_item += temp_dmg;
        }

        local dmg_hp = _hitInfo.DamageMinimum + dmg; // hitpoint dmg = pierce dmg + remaining dmg


        // finalize dmg
        _hitInfo.DamageInflictedArmor = dmg_armor_total;
        _hitInfo.DamageInflictedHitpoints = dmg_hp;
        // local death_pre = this.m.Hitpoints;
        // local death_curr = ::Math.max(0, this.m.Hitpoints - dmg_hp);

		_hitInfo.DamageFatigue *= p.FatigueEffectMult;
		this.m.Fatigue = this.Math.min(this.getFatigueMax(), this.Math.round(this.m.Fatigue + _hitInfo.DamageFatigue * p.FatigueReceivedPerHitMult * this.m.CurrentProperties.FatigueLossOnAnyAttackMult));

        // call event fn		
		this.m.Skills.onDamageReceived(_attacker, _hitInfo.DamageInflictedHitpoints, _hitInfo.DamageInflictedArmor);

		// load armor sound
        if (dmg_armor_total > 0 && !isHiddenToPlayer() && _hitInfo.IsPlayingArmorSound)
		{
			local armorHitSound = this.m.Items.getAppearance().ImpactSound[_hitInfo.BodyPart];

			if (armorHitSound.len() > 0)
			{
				this.Sound.play(armorHitSound[this.Math.rand(0, armorHitSound.len() - 1)], this.Const.Sound.Volume.ActorArmorHit, this.getPos());
			}

			if (dmg_hp < this.Const.Combat.PlayPainSoundMinDamage)
			{
				this.playSound(this.Const.Sound.ActorEvent.NoDamageReceived, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.NoDamageReceived] * this.m.SoundVolumeOverall);
			}
		}

		// do hp dmg
        if (dmg_hp > 0)
		{
			if (!this.m.IsAbleToDie && dmg_hp >= this.m.Hitpoints)
			{
				this.m.Hitpoints = 1;
			}
			else
			{
				this.m.Hitpoints = ::Math.max(this.Math.round(this.m.Hitpoints - dmg_hp), 0);
			}
		}

		if (this.m.Hitpoints <= 0)
		{
			local lorekeeperPotionEffect = this.m.Skills.getSkillByID("effects.lorekeeper_potion");

			if (lorekeeperPotionEffect != null && (!lorekeeperPotionEffect.isSpent() || lorekeeperPotionEffect.getLastFrameUsed() == this.Time.getFrame()))
			{
				this.getSkills().removeByType(this.Const.SkillType.DamageOverTime);
				this.m.Hitpoints = this.getHitpointsMax();
				lorekeeperPotionEffect.setSpent(true);
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " is reborn by the power of the Lorekeeper!");
			}
			else
			{
				local nineLivesSkill = this.m.Skills.getSkillByID("perk.nine_lives");

				if (nineLivesSkill != null && (!nineLivesSkill.isSpent() || nineLivesSkill.getLastFrameUsed() == this.Time.getFrame()))
				{
					this.getSkills().removeByType(this.Const.SkillType.DamageOverTime);
					this.m.Hitpoints = this.Math.rand(11, 15);
					nineLivesSkill.setSpent(true);
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " has nine lives!");
				}
			}
		}

		local fatalityType = this.Const.FatalityType.None;

		if (this.m.Hitpoints <= 0)
		{
			this.m.IsDying = true;

			if (_skill != null)
			{
				if (_skill.getChanceDecapitate() >= 100 || _hitInfo.BodyPart == this.Const.BodyPart.Head && this.Math.rand(1, 100) <= _skill.getChanceDecapitate() * _hitInfo.FatalityChanceMult)
				{
					fatalityType = this.Const.FatalityType.Decapitated;
				}
				else if (_skill.getChanceSmash() >= 100 || _hitInfo.BodyPart == this.Const.BodyPart.Head && this.Math.rand(1, 100) <= _skill.getChanceSmash() * _hitInfo.FatalityChanceMult)
				{
					fatalityType = this.Const.FatalityType.Smashed;
				}
				else if (_skill.getChanceDisembowel() >= 100 || _hitInfo.BodyPart == this.Const.BodyPart.Body && this.Math.rand(1, 100) <= _skill.getChanceDisembowel() * _hitInfo.FatalityChanceMult)
				{
					fatalityType = this.Const.FatalityType.Disemboweled;
				}
			}
		}

        // do armor dmg

        if (dmg_armor_innnate > 0)
        {
            local before = this.m.BaseProperties.Armor[_hitInfo.BodyPart];
            this.m.BaseProperties.Armor[_hitInfo.BodyPart] = armor_innate;
            ::Z.S.log_damage_armor(this, _hitInfo.BodyPart, armor_innate, before, dmg_armor_innnate, true);
        }

        if (dmg_armor_item > 0)
        {
            this.m.Items.onDamageReceived(dmg_armor_item, fatalityType, _hitInfo.BodyPart == this.Const.BodyPart.Body ? this.Const.ItemSlot.Body : this.Const.ItemSlot.Head, _attacker);
        }

		if (this.getFaction() == this.Const.Faction.Player && _attacker != null && _attacker.isAlive())
		{
			this.Tactical.getCamera().quake(_attacker, this, 5.0, 0.16, 0.3);
		}

		if (dmg <= 0 && dmg_armor_total >= 0)
		{
			if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
			{
				local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
				local recoverMult = 1.0;
				this.Tactical.getShaker().cancel(this);
				this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, this.Const.Combat.ShakeEffectArmorHitColor, this.Const.Combat.ShakeEffectArmorHitHighlight, this.Const.Combat.ShakeEffectArmorHitFactor, this.Const.Combat.ShakeEffectArmorSaturation, layers, recoverMult);
			}

			this.m.Skills.update();
			this.setDirty(true);
			return 0;
		}

		if (dmg >= this.Const.Combat.SpawnBloodMinDamage)
		{
			this.spawnBloodDecals(this.getTile());
		}

		if (this.m.Hitpoints <= 0)
		{
			this.spawnBloodDecals(this.getTile());
            // ::Z.S.log_damage_flesh(this, _hitInfo.BodyPart, death_curr, death_pre, dmg_hp); 
			this.kill(_attacker, _skill, fatalityType);
		}
		else
		{
			// do fx
            if (dmg >= this.Const.Combat.SpawnBloodEffectMinDamage)
			{
				local mult = this.Math.maxf(0.75, this.Math.minf(2.0, dmg / this.getHitpointsMax() * 3.0));
				this.spawnBloodEffect(this.getTile(), mult);
			}

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && _attacker != null && _attacker.getID() != this.getID())
			{
				local mult = dmg / this.getHitpointsMax();

				if (mult >= 0.75)
				{
					this.Sound.play(this.Const.Sound.ArenaBigHit[this.Math.rand(0, this.Const.Sound.ArenaBigHit.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
				}
				else if (mult >= 0.25 || this.Math.rand(1, 100) <= 20)
				{
					this.Sound.play(this.Const.Sound.ArenaHit[this.Math.rand(0, this.Const.Sound.ArenaHit.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
				}
			}

			// do injuries
            if (this.m.CurrentProperties.IsAffectedByInjuries && this.m.IsAbleToDie && dmg >= this.Const.Combat.InjuryMinDamage && this.m.CurrentProperties.ThresholdToReceiveInjuryMult != 0 && _hitInfo.InjuryThresholdMult != 0 && _hitInfo.Injuries != null)
			{
				local potentialInjuries = [];
				local bonus = _hitInfo.BodyPart == this.Const.BodyPart.Head ? 1.25 : 1.0;

				foreach( inj in _hitInfo.Injuries )
				{
					if (inj.Threshold * _hitInfo.InjuryThresholdMult * this.Const.Combat.InjuryThresholdMult * this.m.CurrentProperties.ThresholdToReceiveInjuryMult * bonus <= dmg / (this.getHitpointsMax() * 1.0))
					{
						if (!this.m.Skills.hasSkill(inj.ID) && this.m.ExcludedInjuries.find(inj.ID) == null)
						{
							potentialInjuries.push(inj.Script);
						}
					}
				}

				local appliedInjury = false;

				while (potentialInjuries.len() != 0)
				{
					local r = this.Math.rand(0, potentialInjuries.len() - 1);
					local injury = this.new("scripts/skills/" + potentialInjuries[r]);

					if (injury.isValid(this))
					{
						this.m.Skills.add(injury);

						if (this.isPlayerControlled() && this.isKindOf(this, "player"))
						{
							this.worsenMood(this.Const.MoodChange.Injury, "Suffered an injury");

							if (("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_sacrifice")
							{
								this.World.Statistics.getFlags().increment("OathtakersInjuriesSuffered");
							}
						}

						if (this.isPlayerControlled() || !this.isHiddenToPlayer())
						{
							this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + this.Math.floor(dmg) + "[/b] dmg and suffers " + injury.getNameOnly() + "!");
						}

						appliedInjury = true;
						break;
					}
					else
					{
						potentialInjuries.remove(r);
					}
				}

				if (!appliedInjury)
				{
					if (dmg > 0 && !this.isHiddenToPlayer())
					{
						this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + this.Math.floor(dmg) + "[/b] dmg");
					}
				}
			}
			else if (dmg > 0 && !this.isHiddenToPlayer())
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + this.Math.floor(dmg) + "[/b] dmg");
			}

			if (this.m.MoraleState != this.Const.MoraleState.Ignore && dmg >= this.Const.Morale.OnHitMinDamage && this.getCurrentProperties().IsAffectedByLosingHitpoints)
			{
				if (!this.isPlayerControlled() || !this.m.Skills.hasSkill("effects.berserker_mushrooms"))
				{
					this.checkMorale(-1, this.Const.Morale.OnHitBaseDifficulty * (1.0 - this.getHitpoints() / this.getHitpointsMax()) - (_attacker != null && _attacker.getID() != this.getID() ? _attacker.getCurrentProperties().ThreatOnHit : 0), this.Const.MoraleCheckType.Default, "", true);
				}
			}

			this.m.Skills.onAfterDamageReceived();

			if (dmg >= this.Const.Combat.PlayPainSoundMinDamage && this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived].len() > 0)
			{
				local volume = 1.0;

				if (dmg < this.Const.Combat.PlayPainVolumeMaxDamage)
				{
					volume = dmg / this.Const.Combat.PlayPainVolumeMaxDamage;
				}

				this.playSound(this.Const.Sound.ActorEvent.DamageReceived, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] * this.m.SoundVolumeOverall * volume, this.m.SoundPitch);
			}

			this.m.Skills.update();
			this.onUpdateInjuryLayer();

			if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
			{
				local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
				local recoverMult = this.Math.minf(1.5, this.Math.maxf(1.0, dmg * 2.0 / this.getHitpointsMax()));
				this.Tactical.getShaker().cancel(this);
				this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, this.Const.Combat.ShakeEffectHitpointsHitColor, this.Const.Combat.ShakeEffectHitpointsHitHighlight, this.Const.Combat.ShakeEffectHitpointsHitFactor, this.Const.Combat.ShakeEffectHitpointsSaturation, layers, recoverMult);
			}

			this.setDirty(true);
		}

        this.m.HitInfo = _hitInfo;
		return dmg;
	}

});