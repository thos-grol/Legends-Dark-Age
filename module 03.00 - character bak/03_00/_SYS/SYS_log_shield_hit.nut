::mods_hookBaseClass("skills/skill", function (o)
{
	// while(!("onShieldHit" in o)) o = o[o.SuperName];
	while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];
	o.onShieldHit = function( _info )
	{
		local shield = _info.Shield;
		local user = _info.User;
		local targetEntity = _info.TargetEntity;

		if (_info.Skill.m.SoundOnHitShield.len() != 0)
		{
			this.Sound.play(_info.Skill.m.SoundOnHitShield[::Math.rand(0, _info.Skill.m.SoundOnHitShield.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, user.getPos());
		}

		shield.applyShieldDamage(::Const.Combat.BasicShieldDamage, _info.Skill.m.SoundOnHitShield.len() == 0);

		if (shield.getCondition() == 0)
		{
			if (!user.isHiddenToPlayer()) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(targetEntity) + "\'s shield has destroyed ");
		}
		else
		{
			if (!this.Tactical.getNavigator().isTravelling(targetEntity))
			{
				this.Tactical.getShaker().shake(targetEntity, user.getTile(), 2, ::Const.Combat.ShakeEffectSplitShieldColor, ::Const.Combat.ShakeEffectSplitShieldHighlight, ::Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}
		}

		_info.TargetEntity.getItems().onShieldHit(_info.User, this);
	}
});