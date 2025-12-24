// This file applies the damage calculation. Note this is from the perspective of the defender from the actor
//hk - implement IsAffectedByStaminaHitDamage
::mods_hookExactClass("entity/tactical/actor", function(o)
{
    o.onDamageReceived = function( _attacker, _skill, _hitInfo )
    {
        _hitInfo.BodyDamageMultBeforeSteelBrow = _hitInfo.BodyDamageMult;
        
        if (!this.isAlive() || !this.isPlacedOnMap())
        {
            return 0;
        }

        if (_hitInfo.DamageRegular == 0 && _hitInfo.DamageArmor == 0)
        {
            return 0;
        }

        if (typeof _attacker == "instance")
        {
            _attacker = _attacker.get();
        }

        if (_attacker != null && _attacker.isAlive() && _attacker.isPlayerControlled() && !this.isPlayerControlled())
        {
            this.setDiscovered(true);
            this.getTile().addVisibilityForFaction(this.Const.Faction.Player);
            this.getTile().addVisibilityForCurrentEntity();
        }

        if (this.m.CurrentProperties.IsImmuneToCriticals || this.m.CurrentProperties.IsImmuneToHeadshots)
        {
            _hitInfo.BodyDamageMult = 1.0;
        }

        local p = this.m.Skills.buildPropertiesForBeingHit(_attacker, _skill, _hitInfo);
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
        
        local armor = 0;
        local armorDamage = 0;

        if (_hitInfo.DamageDirect < 1.0)
        {
            armor = p.Armor[_hitInfo.BodyPart] * p.ArmorMult[_hitInfo.BodyPart];
            armorDamage = ::Math.min(armor, _hitInfo.DamageArmor);
            armor = armor - armorDamage;
            _hitInfo.DamageInflictedArmor = ::Math.max(0, armorDamage);
        }

        // hk - implement IsAffectedByStaminaHitDamage
        if (p.IsAffectedByStaminaHitDamage)
        {
            _hitInfo.DamageFatigue *= p.FatigueEffectMult;
            this.m.Fatigue = ::Math.min(this.getFatigueMax(), ::Math.round(this.m.Fatigue + _hitInfo.DamageFatigue * p.FatigueReceivedPerHitMult * this.m.CurrentProperties.FatigueLossOnAnyAttackMult));
        }
        
        local damage = 0;
        damage = damage + ::Math.maxf(0.0, _hitInfo.DamageRegular * _hitInfo.DamageDirect * p.DamageReceivedDirectMult - armor * this.Const.Combat.ArmorDirectDamageMitigationMult);

        if (armor <= 0 || _hitInfo.DamageDirect >= 1.0)
        {
            damage = damage + ::Math.max(0, _hitInfo.DamageRegular * ::Math.maxf(0.0, 1.0 - _hitInfo.DamageDirect * p.DamageReceivedDirectMult) - armorDamage);
        }

        damage = damage * _hitInfo.BodyDamageMult;
        damage = ::Math.max(0, ::Math.max(::Math.round(damage), ::Math.min(::Math.round(_hitInfo.DamageMinimum), ::Math.round(_hitInfo.DamageMinimum * p.DamageReceivedTotalMult))));
        _hitInfo.DamageInflictedHitpoints = damage;
        this.m.Skills.onDamageReceived(_attacker, _hitInfo.DamageInflictedHitpoints, _hitInfo.DamageInflictedArmor);

        if (armorDamage > 0 && !this.isHiddenToPlayer() && _hitInfo.IsPlayingArmorSound)
        {
            local armorHitSound = this.m.Items.getAppearance().ImpactSound[_hitInfo.BodyPart];

            if (armorHitSound.len() > 0)
            {
                this.Sound.play(armorHitSound[::Math.rand(0, armorHitSound.len() - 1)], this.Const.Sound.Volume.ActorArmorHit, this.getPos());
            }

            if (damage < this.Const.Combat.PlayPainSoundMinDamage)
            {
                this.playSound(this.Const.Sound.ActorEvent.NoDamageReceived, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.NoDamageReceived] * this.m.SoundVolumeOverall);
            }
        }

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
                    this.m.Hitpoints = 15;
                    nineLivesSkill.setSpent(true);
                    ::Tactical.EventLog.logIn(::color_name(this) + " [Nine Lives]");
                }
            }
        }

        local fatalityType = this.Const.FatalityType.None;

        if (this.m.Hitpoints <= 0)
        {
            this.m.IsDying = true;

            if (_skill != null)
            {
                if (_skill.getChanceDecapitate() >= 100 || _hitInfo.BodyPart == this.Const.BodyPart.Head && ::Math.rand(1, 100) <= _skill.getChanceDecapitate() * _hitInfo.FatalityChanceMult)
                {
                    fatalityType = this.Const.FatalityType.Decapitated;
                }
                else if (_skill.getChanceSmash() >= 100 || _hitInfo.BodyPart == this.Const.BodyPart.Head && ::Math.rand(1, 100) <= _skill.getChanceSmash() * _hitInfo.FatalityChanceMult)
                {
                    fatalityType = this.Const.FatalityType.Smashed;
                }
                else if (_skill.getChanceDisembowel() >= 100 || _hitInfo.BodyPart == this.Const.BodyPart.Body && ::Math.rand(1, 100) <= _skill.getChanceDisembowel() * _hitInfo.FatalityChanceMult)
                {
                    fatalityType = this.Const.FatalityType.Disemboweled;
                }
            }
        }

        if (_hitInfo.DamageDirect < 1.0)
        {
            local overflowDamage = _hitInfo.DamageArmor;

            if (this.m.BaseProperties.Armor[_hitInfo.BodyPart] != 0)
            {
                overflowDamage = overflowDamage - this.m.BaseProperties.Armor[_hitInfo.BodyPart] * this.m.BaseProperties.ArmorMult[_hitInfo.BodyPart];
                local newArmor = this.m.BaseProperties.Armor[_hitInfo.BodyPart] * p.ArmorMult[_hitInfo.BodyPart] - _hitInfo.DamageArmor;
                newArmor = newArmor / p.ArmorMult[_hitInfo.BodyPart];
                this.m.BaseProperties.Armor[_hitInfo.BodyPart] = ::Math.max(0, newArmor);
                this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s armor is hit for [b]" + ::Math.floor(_hitInfo.DamageArmor) + "[/b] damage");
            }

            if (overflowDamage > 0)
            {
                this.m.Items.onDamageReceived(overflowDamage, fatalityType, _hitInfo.BodyPart == this.Const.BodyPart.Body ? this.Const.ItemSlot.Body : this.Const.ItemSlot.Head, _attacker);
            }
        }

        if (this.getFaction() == this.Const.Faction.Player && _attacker != null && _attacker.isAlive())
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
                this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, this.Const.Combat.ShakeEffectArmorHitColor, this.Const.Combat.ShakeEffectArmorHitHighlight, this.Const.Combat.ShakeEffectArmorHitFactor, this.Const.Combat.ShakeEffectArmorSaturation, layers, recoverMult);
            }

            this.m.Skills.update();
            this.setDirty(true);
            return 0;
        }

        if (damage >= this.Const.Combat.SpawnBloodMinDamage)
        {
            this.spawnBloodDecals(this.getTile());
        }

        if (this.m.Hitpoints <= 0)
        {
            this.spawnBloodDecals(this.getTile());
            this.kill(_attacker, _skill, fatalityType);
        }
        else
        {
            if (damage >= this.Const.Combat.SpawnBloodEffectMinDamage)
            {
                local mult = ::Math.maxf(0.75, ::Math.minf(2.0, damage / this.getHitpointsMax() * 3.0));
                this.spawnBloodEffect(this.getTile(), mult);
            }

            if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && _attacker != null && _attacker.getID() != this.getID())
            {
                local mult = damage / this.getHitpointsMax();

                if (mult >= 0.75)
                {
                    this.Sound.play(this.Const.Sound.ArenaBigHit[::Math.rand(0, this.Const.Sound.ArenaBigHit.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
                }
                else if (mult >= 0.25 || ::Math.rand(1, 100) <= 20)
                {
                    this.Sound.play(this.Const.Sound.ArenaHit[::Math.rand(0, this.Const.Sound.ArenaHit.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
                }
            }

            if (this.m.CurrentProperties.IsAffectedByInjuries && this.m.IsAbleToDie && damage >= this.Const.Combat.InjuryMinDamage && this.m.CurrentProperties.ThresholdToReceiveInjuryMult != 0 && _hitInfo.InjuryThresholdMult != 0 && _hitInfo.Injuries != null)
            {
                local potentialInjuries = [];
                local bonus = _hitInfo.BodyPart == this.Const.BodyPart.Head ? 1.25 : 1.0;

                foreach( inj in _hitInfo.Injuries )
                {
                    if (inj.Threshold * _hitInfo.InjuryThresholdMult * this.Const.Combat.InjuryThresholdMult * this.m.CurrentProperties.ThresholdToReceiveInjuryMult * bonus <= damage / (this.getHitpointsMax() * 1.0))
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
                            this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + ::Math.floor(damage) + "[/b] damage and suffers " + injury.getNameOnly() + "!");
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
                        this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + ::Math.floor(damage) + "[/b] damage");
                    }
                }
            }
            else if (damage > 0 && !this.isHiddenToPlayer())
            {
                this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[_hitInfo.BodyPart] + " is hit for [b]" + ::Math.floor(damage) + "[/b] damage");
            }

            if (this.m.MoraleState != this.Const.MoraleState.Ignore && damage >= this.Const.Morale.OnHitMinDamage && this.getCurrentProperties().IsAffectedByLosingHitpoints)
            {
                if (!this.isPlayerControlled() || !this.m.Skills.hasSkill("effects.berserker_mushrooms"))
                {
                    this.checkMorale(-1, this.Const.Morale.OnHitBaseDifficulty * (1.0 - this.getHitpoints() / this.getHitpointsMax()) - (_attacker != null && _attacker.getID() != this.getID() ? _attacker.getCurrentProperties().ThreatOnHit : 0), this.Const.MoraleCheckType.Default, "", true);
                }
            }

            this.m.Skills.onAfterDamageReceived();

            if (damage >= this.Const.Combat.PlayPainSoundMinDamage && this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived].len() > 0)
            {
                local volume = 1.0;

                if (damage < this.Const.Combat.PlayPainVolumeMaxDamage)
                {
                    volume = damage / this.Const.Combat.PlayPainVolumeMaxDamage;
                }

                this.playSound(this.Const.Sound.ActorEvent.DamageReceived, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] * this.m.SoundVolumeOverall * volume, this.m.SoundPitch);
            }

            this.m.Skills.update();
            this.onUpdateInjuryLayer();

            if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
            {
                local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
                local recoverMult = ::Math.minf(1.5, ::Math.maxf(1.0, damage * 2.0 / this.getHitpointsMax()));
                this.Tactical.getShaker().cancel(this);
                this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, this.Const.Combat.ShakeEffectHitpointsHitColor, this.Const.Combat.ShakeEffectHitpointsHitHighlight, this.Const.Combat.ShakeEffectHitpointsHitFactor, this.Const.Combat.ShakeEffectHitpointsSaturation, layers, recoverMult);
            }

            this.setDirty(true);
        }

        this.m.HitInfo = _hitInfo; // save hitInfo for later use
        return damage;
    }
});