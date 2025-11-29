::mods_hookBaseClass("skills/skill", function ( o )
{
	while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];

    o.onScheduledTargetHit <- function( _info )
	{
		_info.Container.setBusy(false);

		if (!_info.TargetEntity.isAlive())
		{
			return;
		}

		local partHit = ::Math.rand(1, 100);
		local bodyPart = ::Const.BodyPart.Body;
		local bodyPartDamageMult = 1.0;

		if (partHit <= _info.Properties.getHitchance(::Const.BodyPart.Head))
		{
			bodyPart = ::Const.BodyPart.Head;
		}
		else
		{
			bodyPart = ::Const.BodyPart.Body;
		}

		bodyPartDamageMult = bodyPartDamageMult * _info.Properties.DamageAgainstMult[bodyPart];
		local damageMult = this.m.IsRanged ? _info.Properties.RangedDamageMult : _info.Properties.MeleeDamageMult;
		damageMult = damageMult * _info.Properties.DamageTotalMult;
		local damageRegular = ::Math.rand(_info.Properties.DamageRegularMin, _info.Properties.DamageRegularMax) * _info.Properties.DamageRegularMult;
		local damageArmor = ::Math.rand(_info.Properties.DamageRegularMin, _info.Properties.DamageRegularMax) * _info.Properties.DamageArmorMult;
		damageRegular = ::Math.max(0, damageRegular + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
		damageArmor = ::Math.max(0, damageArmor + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
		local damageDirect = ::Math.minf(1.0, _info.Properties.DamageDirectMult * (this.m.DirectDamageMult + _info.Properties.DamageDirectAdd + (this.m.IsRanged ? _info.Properties.DamageDirectRangedAdd : _info.Properties.DamageDirectMeleeAdd)));
		local injuries;

        // hk - add body logic just in case
		if (this.m.InjuriesOnBody != null)
		{
			if (_info.TargetEntity.getFlags().has("skeleton"))
			{
				if (bodyPart == ::Const.BodyPart.Body) injuries = ::Const.Injury.SkeletonBody;
                if (this.m.InjuriesOnHead != null && bodyPart == ::Const.BodyPart.Head)
                    ::Z.T.Instinct.INJURIES_BODY = ::Const.Injury.SkeletonBody;
			}
			else
			{
				if (bodyPart == ::Const.BodyPart.Body) injuries = this.m.InjuriesOnBody;
                if (this.m.InjuriesOnHead != null && bodyPart == ::Const.BodyPart.Head)
                    ::Z.T.Instinct.INJURIES_BODY = this.m.InjuriesOnBody;
			}
		}

		// hk - resume normal execution
        if (this.m.InjuriesOnHead != null && bodyPart == ::Const.BodyPart.Head)
		{
			if (_info.TargetEntity.getFlags().has("skeleton"))
			{
				injuries = ::Const.Injury.SkeletonHead;
			}
			else
			{
				injuries = this.m.InjuriesOnHead;
			}
		}

		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damageRegular * damageMult;
		hitInfo.DamageArmor = damageArmor * damageMult;
		hitInfo.DamageDirect = damageDirect;
		hitInfo.DamageFatigue = ::Const.Combat.FatigueReceivedPerHit * _info.Properties.FatigueDealtPerHitMult;
		hitInfo.DamageMinimum = _info.Properties.DamageMinimum;
		hitInfo.BodyPart = bodyPart;
		hitInfo.BodyDamageMult = bodyPartDamageMult;
		hitInfo.FatalityChanceMult = _info.Properties.FatalityChanceMult;
		hitInfo.Injuries = injuries;
		hitInfo.InjuryThresholdMult = _info.Properties.ThresholdToInflictInjuryMult;
		hitInfo.Tile = _info.TargetEntity.getTile();
		_info.Container.onBeforeTargetHit(_info.Skill, _info.TargetEntity, hitInfo);
		local pos = _info.TargetEntity.getPos();
		local hasArmorHitSound = _info.TargetEntity.getItems().getAppearance().ImpactSound[bodyPart].len() != 0;
		_info.TargetEntity.onDamageReceived(_info.User, _info.Skill, hitInfo);

		if (hitInfo.DamageInflictedHitpoints >= ::Const.Combat.PlayHitSoundMinDamage)
		{
			if (this.m.SoundOnHitHitpoints.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitHitpoints[::Math.rand(0, this.m.SoundOnHitHitpoints.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
			}
		}

		if (hitInfo.DamageInflictedHitpoints == 0 && hitInfo.DamageInflictedArmor >= ::Const.Combat.PlayHitSoundMinDamage)
		{
			if (this.m.SoundOnHitArmor.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitArmor[::Math.rand(0, this.m.SoundOnHitArmor.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
			}
		}

		if (typeof _info.User == "instance" && _info.User.isNull() || !_info.User.isAlive() || _info.User.isDying())
		{
			return;
		}

		_info.Container.onTargetHit(_info.Skill, _info.TargetEntity, hitInfo.BodyPart, hitInfo.DamageInflictedHitpoints, hitInfo.DamageInflictedArmor);
		_info.User.getItems().onDamageDealt(_info.TargetEntity, this, hitInfo);

		if (hitInfo.DamageInflictedHitpoints >= ::Const.Combat.SpawnBloodMinDamage && !_info.Skill.isRanged() && (_info.TargetEntity.getBloodType() == ::Const.BloodType.Red || _info.TargetEntity.getBloodType() == ::Const.BloodType.Dark))
		{
			_info.User.addBloodied();
			local item = _info.User.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

			if (item != null && item.isItemType(::Const.Items.ItemType.MeleeWeapon))
			{
				item.setBloodied(true);
			}
		}
	}

});