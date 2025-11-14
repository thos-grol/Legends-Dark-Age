// This file implements various hooks onDamageReceived
// ::mods_hookBaseClass("entity/tactical/actor", function (o) {
// while(!("onDamageReceived" in o)) o = o[o.SuperName];
::mods_hookExactClass("entity/tactical/actor", function(o) {
o.onDamageReceived = function( _attacker, _skill, _hitInfo )
{
	if (!this.isAlive() || !this.isPlacedOnMap()) return 0;
	if (_hitInfo.DamageRegular == 0 && _hitInfo.DamageArmor == 0) return 0;

	// init
	if (typeof _attacker == "instance") _attacker = _attacker.get();
	local RET;

	// reveal if hidden
	if (_attacker != null && _attacker.isAlive() && _attacker.isPlayerControlled() && !this.isPlayerControlled())
	{
		this.setDiscovered(true);
		this.getTile().addVisibilityForFaction(::Const.Faction.Player);
		this.getTile().addVisibilityForCurrentEntity();
	}



	// =============================================================================================
	// DMG CALC
	//
	// hk - disable critical immunity, in future, might add logic to reduce headshot damage
	// if (this.m.CurrentProperties.IsImmuneToCriticals || this.m.CurrentProperties.IsImmuneToHeadshots)
	// {
	// 	_hitInfo.BodyDamageMult = 1.0;
	// }

	local p = getSkills().buildPropertiesForBeingHit(_attacker, _skill, _hitInfo);
	
	// hk - roll instinct damage reduction
	::Z.S.roll_instinct( _hitInfo, p );
	
	//FEATURE_1: remove this system, then just skip lines on round or turn end
	if (::Z.T.Log.cd_obdr_msg)
	{
		::Tactical.EventLog.logIn(::Z.T.Log.cd_obdr_str);
		::Z.T.Log.cd_obdr_msg <- false;
		::Z.T.Log.cd_obdr_str <- "";
	}

	this.m.Items.onBeforeDamageReceived(_attacker, _skill, _hitInfo, p);
	local dmgMult = p.DamageReceivedTotalMult;

	if (_skill != null)
	{
		dmgMult = dmgMult * (_skill.isRanged() ? p.DamageReceivedRangedMult : p.DamageReceivedMeleeMult);
	}

	_hitInfo.DamageRegular -= p.DamageRegularReduction;
	_hitInfo.DamageArmor -= p.DamageArmorReduction;
	_hitInfo.DamageRegular *= p.DamageReceivedRegularMult * dmgMult;
	_hitInfo.DamageArmor *= p.DamageReceivedArmorMult * dmgMult;

	// hk - if graze, also reduce armor damage
	if (::Z.T.Instinct.RESULT == ::Z.T.Instinct.Body) _hitInfo.DamageArmor *= _hitInfo.BodyDamageMult;

	local armor = 0;
	local armorDamage = 0;

	if (_hitInfo.DamageDirect < 1.0)
	{
		armor = p.Armor[_hitInfo.BodyPart] * p.ArmorMult[_hitInfo.BodyPart];
		armorDamage = ::Math.min(armor, _hitInfo.DamageArmor);
		armorDamage = ::Math.max(0, ::Math.round(armorDamage));
		armor = armor - armorDamage;
		_hitInfo.DamageInflictedArmor = armorDamage;
	}

	_hitInfo.DamageFatigue *= p.FatigueEffectMult;
	this.m.Fatigue = ::Math.min(this.getFatigueMax(), ::Math.round(this.m.Fatigue + _hitInfo.DamageFatigue * p.FatigueReceivedPerHitMult * this.m.CurrentProperties.FatigueLossOnAnyAttackMult));
	local damage = 0;
	damage = damage + ::Math.maxf(0.0, _hitInfo.DamageRegular * _hitInfo.DamageDirect * p.DamageReceivedDirectMult - armor * ::Const.Combat.ArmorDirectDamageMitigationMult);

	if (armor <= 0 || _hitInfo.DamageDirect >= 1.0)
	{
		damage = damage + ::Math.max(0, _hitInfo.DamageRegular * ::Math.maxf(0.0, 1.0 - _hitInfo.DamageDirect * p.DamageReceivedDirectMult) - armorDamage);
	}

	damage = damage * _hitInfo.BodyDamageMult;
	damage = ::Math.max(0, ::Math.max(damage, ::Math.min(_hitInfo.DamageMinimum, _hitInfo.DamageMinimum * p.DamageReceivedTotalMult)));
	_hitInfo.DamageInflictedHitpoints = damage;
	
	// hk - ensure dmg is an int
	damage = ::Math.round(damage);
	this.m.Skills.onDamageReceived(_attacker, _hitInfo.DamageInflictedHitpoints, _hitInfo.DamageInflictedArmor);
	// =============================================================================================



	// =============================================================================================
	// SFX BLOCK 1 - why is this jumbled here?
	if (armorDamage > 0 && !this.isHiddenToPlayer() && _hitInfo.IsPlayingArmorSound)
	{
		local armorHitSound = this.m.Items.getAppearance().ImpactSound[_hitInfo.BodyPart];

		if (armorHitSound.len() > 0)
		{
			this.Sound.play(armorHitSound[::Math.rand(0, armorHitSound.len() - 1)], ::Const.Sound.Volume.ActorArmorHit, this.getPos());
		}

		if (damage < ::Const.Combat.PlayPainSoundMinDamage)
		{
			this.playSound(::Const.Sound.ActorEvent.NoDamageReceived, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.NoDamageReceived] * this.m.SoundVolumeOverall);
		}
	}
	// =============================================================================================



	// =============================================================================================
	// check death immunity and apply damage
	local health_before = this.m.Hitpoints;
	if (damage > 0)
	{
		if (!this.m.IsAbleToDie && damage >= this.m.Hitpoints)
		{
			this.m.Hitpoints = 1;
		}
		else
		{
			this.m.Hitpoints = ::Math.round(this.m.Hitpoints - damage);
		}
	}

	if (this.m.Hitpoints <= 0)
	{
		local lorekeeperPotionEffect = this.m.Skills.getSkillByID("effects.lorekeeper_potion");

		if (lorekeeperPotionEffect != null && (!lorekeeperPotionEffect.isSpent() || lorekeeperPotionEffect.getLastFrameUsed() == this.Time.getFrame()))
		{
			this.getSkills().removeByType(::Const.SkillType.DamageOverTime);
			this.m.Hitpoints = this.getHitpointsMax();
			lorekeeperPotionEffect.setSpent(true);
			::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + " is reborn by the power of the Lorekeeper!");
		}
		else
		{
			local nineLivesSkill = this.m.Skills.getSkillByID("perk.nine_lives");

			if (nineLivesSkill != null && (!nineLivesSkill.isSpent() || nineLivesSkill.getLastFrameUsed() == this.Time.getFrame()))
			{
				this.getSkills().removeByType(::Const.SkillType.DamageOverTime);
				this.m.Hitpoints = ::Math.rand(11, 15);
				nineLivesSkill.setSpent(true);
				::Z.S.log_skill_nine_lives(this);
			}
		}
	}

	local fatalityType = ::Const.FatalityType.None;
	if (this.m.Hitpoints <= 0)
	{
		this.m.IsDying = true;

		if (_skill != null)
		{
			if (_skill.getChanceDecapitate() >= 100 || _hitInfo.BodyPart == ::Const.BodyPart.Head && ::Math.rand(1, 100) <= _skill.getChanceDecapitate() * _hitInfo.FatalityChanceMult)
			{
				fatalityType = ::Const.FatalityType.Decapitated;
			}
			else if (_skill.getChanceSmash() >= 100 || _hitInfo.BodyPart == ::Const.BodyPart.Head && ::Math.rand(1, 100) <= _skill.getChanceSmash() * _hitInfo.FatalityChanceMult)
			{
				fatalityType = ::Const.FatalityType.Smashed;
			}
			else if (_skill.getChanceDisembowel() >= 100 || _hitInfo.BodyPart == ::Const.BodyPart.Body && ::Math.rand(1, 100) <= _skill.getChanceDisembowel() * _hitInfo.FatalityChanceMult)
			{
				fatalityType = ::Const.FatalityType.Disemboweled;
			}
		}
	}
	// =============================================================================================

	
	
	// =============================================================================================
	// DMG CALC - OVERFLOW
	if (_hitInfo.DamageDirect < 1.0)
	{
		local overflowDamage = _hitInfo.DamageArmor;

		if (this.m.BaseProperties.Armor[_hitInfo.BodyPart] != 0)
		{
			overflowDamage = overflowDamage - this.m.BaseProperties.Armor[_hitInfo.BodyPart] * this.m.BaseProperties.ArmorMult[_hitInfo.BodyPart];
			overflowDamage = ::Math.round(overflowDamage);
			
			local armor_new = this.m.BaseProperties.Armor[_hitInfo.BodyPart] * p.ArmorMult[_hitInfo.BodyPart] - _hitInfo.DamageArmor;
			armor_new = armor_new / p.ArmorMult[_hitInfo.BodyPart];
			armor_new = ::Math.max(0, ::Math.round(armor_new));

			this.m.BaseProperties.Armor[_hitInfo.BodyPart] = ::Math.round(this.m.BaseProperties.Armor[_hitInfo.BodyPart]);
			local armor_old = this.m.BaseProperties.Armor[_hitInfo.BodyPart];
			this.m.BaseProperties.Armor[_hitInfo.BodyPart] = armor_new;
			
			//(::Const.UI.getColorizedEntityName(this) + "\'s armor is hit for [b]" + ::Math.floor(_hitInfo.DamageArmor) + "[/b] damage");
			local part_name = ::Const.Strings.BodyPartName[_hitInfo.BodyPart];
			::Z.S.log_damage_armor(this, part_name, armor_new, armor_old, _hitInfo.DamageArmor, true)
		}

		if (overflowDamage > 0)
		{
			this.m.Items.onDamageReceived(overflowDamage, fatalityType, _hitInfo.BodyPart == ::Const.BodyPart.Body ? ::Const.ItemSlot.Body : ::Const.ItemSlot.Head, _attacker);
		}
	}
	// =============================================================================================



	// =============================================================================================
	// SFX BLOCK 2
	if (this.getFaction() == ::Const.Faction.Player && _attacker != null && _attacker.isAlive())
	{
		this.Tactical.getCamera().quake(_attacker, this, 5.0, 0.16, 0.3);
	}

	if (damage <= 0 && armorDamage >= 0)
	{
		if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
		{
			local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
			local recoverMult = 1.0;
			this.Tactical.getShaker().cancel(this);
			this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, ::Const.Combat.ShakeEffectArmorHitColor, ::Const.Combat.ShakeEffectArmorHitHighlight, ::Const.Combat.ShakeEffectArmorHitFactor, ::Const.Combat.ShakeEffectArmorSaturation, layers, recoverMult);
		}

		this.m.Skills.update();
		this.setDirty(true);
		return 0;
	}

	if (damage >= ::Const.Combat.SpawnBloodMinDamage)
	{
		this.spawnBloodDecals(this.getTile());
	}
	// =============================================================================================



	// kill?
	if (this.m.Hitpoints <= 0)
	{
		this.spawnBloodDecals(this.getTile());
		this.kill(_attacker, _skill, fatalityType);
		return damage;
	}
	


	// =============================================================================================
	// SFX, FX BLOCK 3
	if (damage >= ::Const.Combat.SpawnBloodEffectMinDamage)
	{
		local mult = ::Math.maxf(0.75, ::Math.minf(2.0, damage / this.getHitpointsMax() * 3.0));
		this.spawnBloodEffect(this.getTile(), mult);
	}

	if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && _attacker != null && _attacker.getID() != this.getID())
	{
		local mult = damage / this.getHitpointsMax();

		if (mult >= 0.75)
		{
			this.Sound.play(::Const.Sound.ArenaBigHit[::Math.rand(0, ::Const.Sound.ArenaBigHit.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
		}
		else if (mult >= 0.25 || ::Math.rand(1, 100) <= 20)
		{
			this.Sound.play(::Const.Sound.ArenaHit[::Math.rand(0, ::Const.Sound.ArenaHit.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
		}
	}
	// =============================================================================================
	
	
	
	// =============================================================================================
	// DMG RESOLUTION
	//
	// if can apply injury...
	if (this.m.CurrentProperties.IsAffectedByInjuries && this.m.IsAbleToDie && damage >= ::Const.Combat.InjuryMinDamage && this.m.CurrentProperties.ThresholdToReceiveInjuryMult != 0 && _hitInfo.InjuryThresholdMult != 0 && _hitInfo.Injuries != null)
	{
		local potentialInjuries = [];
		local bonus = _hitInfo.BodyPart == ::Const.BodyPart.Head ? 1.25 : 1.0;

		foreach( inj in _hitInfo.Injuries )
		{
			if (inj.Threshold * _hitInfo.InjuryThresholdMult * ::Const.Combat.InjuryThresholdMult * this.m.CurrentProperties.ThresholdToReceiveInjuryMult * bonus <= damage / (this.getHitpointsMax() * 1.0))
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
			local r = ::Math.rand(0, potentialInjuries.len() - 1);
			local injury = ::new("scripts/skills/" + potentialInjuries[r]);

			if (injury.isValid(this))
			{
				this.m.Skills.add(injury);

				if (this.isPlayerControlled() && this.isKindOf(this, "player"))
				{
					this.worsenMood(::Const.MoodChange.Injury, "Suffered an injury");

					if (("State" in ::World) && ::World.State != null && ::World.Ambitions.hasActiveAmbition() && ::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_sacrifice")
					{
						::World.Statistics.getFlags().increment("OathtakersInjuriesSuffered");
					}
				}

				if (this.isPlayerControlled() || !this.isHiddenToPlayer())
				{
					// (::Const.UI.getColorizedEntityName(this) + "\'s " + ::Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + ::Math.floor(damage) + "[/b] damage and suffers " + injury.getNameOnly() + "!");

					local body_part = ::Const.Strings.BodyPartName[_hitInfo.BodyPart];
					::Z.S.log_damage_flesh(this, body_part, this.m.Hitpoints, health_before, damage);
					::Z.S.log_injury(this, injury.getNameOnly());
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
			if (damage > 0 && !this.isHiddenToPlayer())
			{
				local body_part = ::Const.Strings.BodyPartName[_hitInfo.BodyPart];
				::Z.S.log_damage_flesh(this, body_part, this.m.Hitpoints, health_before, damage);
			}
		}
	}
	// if not injured...
	else if (damage > 0 && !this.isHiddenToPlayer())
	{
		::Z.S.log_damage_flesh(this, ::Const.Strings.BodyPartName[_hitInfo.BodyPart], this.m.Hitpoints, health_before, damage);
	}

	// log instinct
	::Z.S.log_instinct_trigger();

	// morale check based on dmg done
	if (this.m.MoraleState != ::Const.MoraleState.Ignore && damage >= ::Const.Morale.OnHitMinDamage && this.getCurrentProperties().IsAffectedByLosingHitpoints)
	{
		if (!this.isPlayerControlled() || !this.m.Skills.hasSkill("effects.berserker_mushrooms"))
		{
			this.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - this.getHitpoints() / this.getHitpointsMax()) - (_attacker != null && _attacker.getID() != this.getID() ? _attacker.getCurrentProperties().ThreatOnHit : 0), ::Const.MoraleCheckType.Default, "", true);
		}
	}

	this.m.Skills.onAfterDamageReceived();
	this.m.Skills.update();
	this.onUpdateInjuryLayer();
	// =============================================================================================



	
	// =============================================================================================
	// SFX, FX BLOCK 4
	if (damage >= ::Const.Combat.PlayPainSoundMinDamage && this.m.Sound[::Const.Sound.ActorEvent.DamageReceived].len() > 0)
	{
		local volume = 1.0;

		if (damage < ::Const.Combat.PlayPainVolumeMaxDamage)
		{
			volume = damage / ::Const.Combat.PlayPainVolumeMaxDamage;
		}

		this.playSound(::Const.Sound.ActorEvent.DamageReceived, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] * this.m.SoundVolumeOverall * volume, this.m.SoundPitch);
	}

	if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
	{
		local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
		local recoverMult = ::Math.minf(1.5, ::Math.maxf(1.0, damage * 2.0 / this.getHitpointsMax()));
		this.Tactical.getShaker().cancel(this);
		this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, ::Const.Combat.ShakeEffectHitpointsHitColor, ::Const.Combat.ShakeEffectHitpointsHitHighlight, ::Const.Combat.ShakeEffectHitpointsHitFactor, ::Const.Combat.ShakeEffectHitpointsSaturation, layers, recoverMult);
	}
	// =============================================================================================


	this.setDirty(true); //flag update
	return damage;
}});