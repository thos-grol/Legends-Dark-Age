this.horrific_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.horrific_scream";
		this.m.Name = "Horrific Scream";
		this.m.Description = "";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " [Horrific Scream] " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()));
		}

		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);

		local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = ::Math.rand(25, 55);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_targetTile.getEntity().onDamageReceived(_user, this, hitInfo);

		return true;
	}

});

