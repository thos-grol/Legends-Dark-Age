this.fleche_skill <- this.inherit("scripts/skills/skill", {
	m = {
		cooldown = 0,
		cooldown_max = 2,
	},
	function create()
	{
		this.m.ID = "actives.fleche";
		this.m.Name = "Fleche";
		this.m.Description = "A swift lunge towards a target within 4 tiles, followed by an attack from the currently equipped weapon";
		this.m.KilledString = "Fleched";
		this.m.Icon = "skills/active_135.png";
		this.m.IconDisabled = "skills/active_135_sw.png";
		this.m.Overlay = "active_135";
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/lunge_move_01.wav",
			"sounds/combat/dlc2/lunge_move_02.wav",
			"sounds/combat/dlc2/lunge_move_03.wav",
			"sounds/combat/dlc2/lunge_move_04.wav"
		];
		this.m.SoundOnHit = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 1;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 2;
		this.m.MaxRange = 4;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		// recalc_costs();
		local ret = this.getDefaultTooltip();
		ret.pop();
		ret.pop();
		ret.pop();
		
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Cooldown: " + this.m.cooldown + "/" + this.m.cooldown_max
		});

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}
	

	function onUse( _user, _targetTile )
	{
		this.m.cooldown = this.m.cooldown_max;

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local destTile;

		for( local i = 0; i < 6; i = ++i )
		{
			if (_targetTile.hasNextTile(i))
			{
				local tile = _targetTile.getNextTile(i);

				if (tile.IsEmpty && tile.getDistanceTo(myTile) <= 4 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
				{
					destTile = tile;
					break;
				}
			}
		}

		if (destTile == null) return false;
		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(myTile);
		::Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local ZOC = [];
		this.getContainer().setBusy(false);

		for( local i = 0; i != 6; i = ++i )
		{
			if (myTile.hasNextTile(i))
			{
				local tile = myTile.getNextTile(i);
				if (tile.IsOccupiedByActor)
				{
					local actor = tile.getEntity();
					if (!actor.isAlliedWith(_entity) && !actor.getCurrentProperties().IsStunned)
					{
						ZOC.push(actor);
					}
				}
			}
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true)) continue;
			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.logIn(::color_name(_entity) + " is repelled");
				}
				if (!_entity.isAlive() || _entity.isDying()) return;
				
				local dir = myTile.getDirectionTo(_tag.OldTile);
				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);
					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}
			}
		}

		local skill = _tag.User.getSkills().getAttackOfOpportunity();
		if (skill != null)
		{
			local info = {
				User = _tag.User,
				Skill = skill,
				TargetTile = _tag.TargetTile
			};
			this.Time.scheduleEvent(this.TimeUnit.Virtual, this.Const.Combat.RiposteDelay, this.on_aoo.bindenv(this), info);
		}
	}

	function on_aoo( _info )
	{
		if (!_info.User.isAlive()) return;
		_info.Skill.useForFree(_info.TargetTile);
	}

	function onRepelled( _tag )
	{
		::Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onAfterUpdate( _properties )
	{
		recalc_costs();
		this.m.FatigueCostMult *= _properties.IsProficientWithRogue ? 0.75 : 1.0;
	}



	// management logic

	function recalc_costs()
	{
		local actor = this.getContainer().getActor();
		local skill = actor.getSkills().getAttackOfOpportunity();
		
		if (skill == null) return;

		this.m.ActionPointCost = skill.getActionPointCost();
		this.m.FatigueCost = skill.getFatigueCost() + 15;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable()
			&& this.m.cooldown == 0
			&& !actor.getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;

		local myTile = this.getContainer().getActor().getTile();
		local hasTile = false;
		for( local i = 0; i < 6; i = ++i )
		{
			if (_targetTile.hasNextTile(i))
			{
				local tile = _targetTile.getNextTile(i);
				if (tile.IsEmpty && tile.getDistanceTo(myTile) <= 4 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
				{
					hasTile = true;
					break;
				}
			}
		}

		return hasTile;
	}

	// manage cds

	function onTurnStart()
	{
		if (this.m.cooldown > 0) this.m.cooldown--;
	}

	function onCombatStarted()
	{
		this.m.cooldown = 0;
	}

	function onCombatFinished()
	{
		this.m.cooldown = 0;
	}
});

