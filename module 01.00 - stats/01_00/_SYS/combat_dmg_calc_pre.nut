::mods_hookBaseClass("skills/skill", function ( o )
{
	// rewrite the entire function to use our logic instead
    while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];
    o.onScheduledTargetHit = function( _info )
	{
		_info.Container.setBusy(false);
		if (!_info.TargetEntity.isAlive()) return;

		// prep mults
        local hit_part = (::Math.rand(1, 100) <= _info.Properties.getHitchance(::Const.BodyPart.Head)) ? ::Const.BodyPart.Head : ::Const.BodyPart.Body;
        local bodyPartDamageMult = 1.0;
        bodyPartDamageMult = bodyPartDamageMult * _info.Properties.DamageAgainstMult[hit_part];

        local mult_dmg = _info.Properties.DamageTotalMult; //Damage total mult includes graze
        mult_dmg *= this.m.IsRanged ? _info.Properties.RangedDamageMult : _info.Properties.MeleeDamageMult;

        // do rolls
        local dmg_roll = ::Math.rand(_info.Properties.DamageRegularMin, _info.Properties.DamageRegularMax);
		local dmg = dmg_roll * _info.Properties.DamageRegularMult;

		// we damage armor from regular damage... so comment this out
        // local damageArmor = dmg_roll * _info.Properties.DamageArmorMult;
		// dmg = ::Math.max(0, dmg + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);
		// damageArmor = ::Math.max(0, damageArmor + _info.DistanceToTarget * _info.Properties.DamageAdditionalWithEachTile);

		// seems like this is a mult. we don't need it. Can perhaps create a flat value to add.

        // local damageDirect = ::Math.minf(1.0, _info.Properties.DamageDirectMult * (this.m.DirectDamageMult + _info.Properties.DamageDirectAdd + (this.m.IsRanged ? _info.Properties.DamageDirectRangedAdd : _info.Properties.DamageDirectMeleeAdd)));
        //hk end

        local injuries;
		
		if (this.m.InjuriesOnBody != null && hit_part == ::Const.BodyPart.Body)
		{
			injuries = (_info.TargetEntity.getFlags().has("skeleton")) ? ::Const.Injury.SkeletonBody : this.m.InjuriesOnBody;
		}
		else if (this.m.InjuriesOnHead != null && hit_part == ::Const.BodyPart.Head)
		{
			injuries = (_info.TargetEntity.getFlags().has("skeleton")) ? ::Const.Injury.SkeletonHead : this.m.InjuriesOnHead;
		}

		// hk
        // armor acts as ablative
        // hardness reduces damage

		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = dmg * mult_dmg; //regular damage
        hitInfo.DamageMinimum = _info.Properties.DamageMinimum * mult_dmg; // piercing damage

        hitInfo.DamageFatigue = ::Const.Combat.FatigueReceivedPerHit * _info.Properties.FatigueDealtPerHitMult + _info.Properties.FatigueDealtAsPercentOfMaxFatigue * _info.TargetEntity.getFatigueMax();

		hitInfo.DamageArmor = 0;
		hitInfo.DamageDirect = 0;
        
		hitInfo.BodyPart = hit_part;
		hitInfo.BodyDamageMult = bodyPartDamageMult;
		hitInfo.Injuries = injuries;
		hitInfo.InjuryThresholdMult = _info.Properties.ThresholdToInflictInjuryMult;

		hitInfo.FatalityChanceMult = _info.Properties.FatalityChanceMult;
		hitInfo.Tile = _info.TargetEntity.getTile();
		_info.Container.onBeforeTargetHit(_info.Skill, _info.TargetEntity, hitInfo);
		local pos = _info.TargetEntity.getPos();
		local hasArmorHitSound = _info.TargetEntity.getItems().getAppearance().ImpactSound[hit_part].len() != 0;
		
        //check combat_dmg_calc for continuation
        _info.TargetEntity.onDamageReceived(_info.User, _info.Skill, hitInfo);

		if (hitInfo.DamageInflictedHitpoints >= ::Const.Combat.PlayHitSoundMinDamage)
		{
			if (this.m.SoundOnHitHitpoints.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitHitpoints[::Math.rand(0, this.m.SoundOnHitHitpoints.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
			}
		}

		if (hitInfo.DamageInflictedArmor >= ::Const.Combat.PlayHitSoundMinDamage)
		{
			if (this.m.SoundOnHitArmor.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitArmor[::Math.rand(0, this.m.SoundOnHitArmor.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, pos);
			}
		}

		if (typeof _info.User == "instance" && _info.User.isNull() || !_info.User.isAlive() || _info.User.isDying()) return;

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