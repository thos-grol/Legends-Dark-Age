// This file sets up the damage calculation. Note this is from the perspective of the attacker from the skill
//      hk - implement damage reduction
//      hk - hardness subtracts incoming damage
//      hk - shieldwall mitigates damage that hits body. check for skill. subtract block value.
::mods_hookBaseClass("skills/skill", function ( o )
{
	while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];
    o.onScheduledTargetHit = function( _info )
    {
        _info.Container.setBusy(false);

        if (!_info.TargetEntity.isAlive())
        {
            return;
        }

        local partHit = this.Math.rand(1, 100);
        local bodyPart = this.Const.BodyPart.Body;
        local bodyPartDamageMult = 1.0;

        if (partHit <= _info.Properties.getHitchance(this.Const.BodyPart.Head))
        {
            bodyPart = this.Const.BodyPart.Head;
        }
        else
        {
            bodyPart = this.Const.BodyPart.Body;
        }

        
        // hk - implement damage reduction
        bodyPartDamageMult = bodyPartDamageMult * _info.Properties.DamageAgainstMult[bodyPart];
        local damageMult = this.m.IsRanged ? _info.Properties.RangedDamageMult : _info.Properties.MeleeDamageMult;
        damageMult = damageMult * _info.Properties.DamageTotalMult;

        // do a unified roll for armor and hp damage cmon
        local damage_roll =  ::Z.S.get_strike_roll(_info.Properties, _info.TargetProperties);

        // hk - add rebound force
        local rebound_force = _info.TargetEntity.getSkills().getSkillByID("perk.rebound_force");
        if (rebound_force != null && rebound_force.m.charges > 0)
        {
            rebound_force.set_primed_damage(damage_roll);
        }

        // hk - hardness subtracts incoming damage
        if (_info.TargetProperties.Hardness > 0)
        {
            damage_roll = ::Math.max(0, damage_roll - _info.TargetProperties.Hardness);
            if (!_info.User.isHiddenToPlayer() && !_info.TargetEntity.isHiddenToPlayer())
            {
                ::Tactical.EventLog.logIn("Hardness (" + _info.TargetProperties.Hardness + ")");
            }
        }

        // hk - shieldwall mitigates damage that hits body. check for skill. subtract block value.
        local shieldwall = _info.TargetEntity.getSkills().getSkillByID("effects.shieldwall");
        if (shieldwall != null && shieldwall.m.Block_Points > 0)
        {
            local pre_block = shieldwall.m.Block_Points;
            local pre_damage = damage_roll;

            damage_roll = ::Math.max(0, damage_roll - shieldwall.m.Block_Points);
            shieldwall.m.Block_Points = ::Math.max(0, shieldwall.m.Block_Points - pre_damage);

            if (!_info.User.isHiddenToPlayer() && !_info.TargetEntity.isHiddenToPlayer())
            {
                ::Z.S.log_block({
                    prev_block = pre_block,
                    block = shieldwall.m.Block_Points,
                    blocked = pre_block - shieldwall.m.Block_Points,
                });
            }

            // play shield hit sound
            if (_info.Skill.m.SoundOnHitShield.len() != 0)
            {
                ::Sound.play(_info.Skill.m.SoundOnHitShield[::Math.rand(0, _info.Skill.m.SoundOnHitShield.len() - 1)], ::Const.Sound.Volume.Skill * _info.Skill.m.SoundVolume, _info.TargetEntity.getPos());
            }
        }
        
        local damageRegular = damage_roll * _info.Properties.DamageRegularMult;
        local damageArmor = damage_roll * _info.Properties.DamageArmorMult;
        damageRegular = this.Math.max(0, damageRegular + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
        damageArmor = this.Math.max(0, damageArmor + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
        local damageDirect = this.Math.minf(1.0, _info.Properties.DamageDirectMult * (this.m.DirectDamageMult + _info.Properties.DamageDirectAdd + (this.m.IsRanged ? _info.Properties.DamageDirectRangedAdd : _info.Properties.DamageDirectMeleeAdd)));
        local injuries;

        if (this.m.InjuriesOnBody != null && bodyPart == this.Const.BodyPart.Body)
        {
            if (_info.TargetEntity.getFlags().has("skeleton"))
            {
                injuries = this.Const.Injury.SkeletonBody;
            }
            else
            {
                injuries = this.m.InjuriesOnBody;
            }
        }
        else if (this.m.InjuriesOnHead != null && bodyPart == this.Const.BodyPart.Head)
        {
            if (_info.TargetEntity.getFlags().has("skeleton"))
            {
                injuries = this.Const.Injury.SkeletonHead;
            }
            else
            {
                injuries = this.m.InjuriesOnHead;
            }
        }

        local hitInfo = clone this.Const.Tactical.HitInfo;
        hitInfo.DamageRegular = damageRegular * damageMult;
        hitInfo.DamageArmor = damageArmor * damageMult;
        hitInfo.DamageDirect = damageDirect;
        hitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit * _info.Properties.FatigueDealtPerHitMult + _info.Properties.FatigueDealtAsPercentOfMaxFatigue * _info.TargetEntity.getFatigueMax();
        hitInfo.DamageMinimum = _info.Properties.DamageMinimum;
        hitInfo.BodyPart = bodyPart;
        hitInfo.BodyDamageMult = bodyPartDamageMult;
        hitInfo.FatalityChanceMult = _info.Properties.FatalityChanceMult;
        hitInfo.Injuries = injuries;
        hitInfo.InjuryThresholdMult = _info.Properties.ThresholdToInflictInjuryMult;
        hitInfo.Tile = _info.TargetEntity.getTile();

        // hk - fast adaptation logic with graze band
        local fast_adaptation = _info.User.getSkills().getSkillByID("perk.fast_adaptation2");
        if (fast_adaptation != null)
        {
            if (_info.HitResult == HIT_RESULT.HIT) fast_adaptation.m.Stacks = 0;
            else fast_adaptation.m.Stacks++;
        }
        // hk - end

        _info.Container.onBeforeTargetHit(_info.Skill, _info.TargetEntity, hitInfo);
        local pos = _info.TargetEntity.getPos();
        local hasArmorHitSound = _info.TargetEntity.getItems().getAppearance().ImpactSound[bodyPart].len() != 0;
        _info.TargetEntity.onDamageReceived(_info.User, _info.Skill, hitInfo);

        if (hitInfo.DamageInflictedHitpoints >= this.Const.Combat.PlayHitSoundMinDamage)
        {
            if (this.m.SoundOnHitHitpoints.len() != 0)
            {
                this.Sound.play(this.m.SoundOnHitHitpoints[this.Math.rand(0, this.m.SoundOnHitHitpoints.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
            }
        }

        if (hitInfo.DamageInflictedHitpoints == 0 && hitInfo.DamageInflictedArmor >= this.Const.Combat.PlayHitSoundMinDamage)
        {
            if (this.m.SoundOnHitArmor.len() != 0)
            {
                this.Sound.play(this.m.SoundOnHitArmor[this.Math.rand(0, this.m.SoundOnHitArmor.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
            }
        }

        if (typeof _info.User == "instance" && _info.User.isNull() || !_info.User.isAlive() || _info.User.isDying())
        {
            return;
        }

        _info.Container.onTargetHit(_info.Skill, _info.TargetEntity, hitInfo.BodyPart, hitInfo.DamageInflictedHitpoints, hitInfo.DamageInflictedArmor);
        _info.User.getItems().onDamageDealt(_info.TargetEntity, this, hitInfo);

        if (hitInfo.DamageInflictedHitpoints >= this.Const.Combat.SpawnBloodMinDamage && !_info.Skill.isRanged() && (_info.TargetEntity.getBloodType() == this.Const.BloodType.Red || _info.TargetEntity.getBloodType() == this.Const.BloodType.Dark))
        {
            _info.User.addBloodied();
            local item = _info.User.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

            if (item != null && item.isItemType(this.Const.Items.ItemType.MeleeWeapon))
            {
                item.setBloodied(true);
            }
        }
    }
});