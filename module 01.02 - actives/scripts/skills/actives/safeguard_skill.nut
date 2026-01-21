this.safeguard_skill <- this.inherit("scripts/skills/skill", {
	m = {
		cooldown = 0,
		cooldown_max = 2
	},
	function create()
	{
		this.m.ID = "actives.safeguard";
		this.m.Name = "Safeguard";
		this.m.Description = "Protect an ally, swapping positions with them. User will then shieldwall and then taunt all enemies that can attack in 2 tiles. Can rescue stun and rooted allies.";
		this.m.Icon = "skills/safeguard.png";
		this.m.IconDisabled = "skills/safeguard_bw.png";
		this.m.Overlay = "safeguard";
		this.m.SoundOnUse = [
			"sounds/combat/rotation_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onTurnStart()
	{
		if (this.m.cooldown > 0) this.m.cooldown--;
	}

	function getTooltip()
	{
		// local value = this.Math.round(this.Math.minf(0.5, this.getContainer().getActor().getCurrentProperties().Bravery * 0.005) * 100);
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
		];

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
				text = ::red("Can not be used while rooted")
			});
		}

		return ret;
	}

	function getCursorForTile( _tile )
	{
		return this.Const.UI.Cursor.Rotation;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult *= _properties.IsProficientWithShieldWall ? 0.25 : 1.0;
		this.m.FatigueCostMult *= _properties.BlockMastery ? 0.75 : 1.0;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local has_shield = shield != null && shield.isItemType(this.Const.Items.ItemType.Shield);
		return !has_shield;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local has_shield = shield != null && shield.isItemType(this.Const.Items.ItemType.Shield);
		
		return this.skill.isUsable()
			&& has_shield
			&& this.m.cooldown == 0
			&& !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;

		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();
		local setting = ::Legends.Mod.ModSettings.getSetting("AiRotation").getValue();

		if (actor.getFaction() != this.Const.Faction.Player && setting == "Disabled")
			return false;

		if (!target.isAlive() && ::MSU.isNull(target))
			return false;

		// if (target.getCurrentProperties().IsStunned)
		// 	return false;

		// if (target.getCurrentProperties().IsRooted)
		// 	return false;

		if (!target.getCurrentProperties().IsMovable)
			return false;

		if (target.getCurrentProperties().IsImmuneToRotation)
			return false;

		local canRotate = target.isAlliedWith(this.getContainer().getActor()) || this.getContainer().hasPerk(::Legends.Perk.LegendTwirl);
		local setting = ::Legends.Mod.ModSettings.getSetting("AiRotation").getValue();
		if (!canRotate)
			return false;

		if (actor.getFaction() != this.Const.Faction.Player && target.getFaction() == this.Const.Faction.Player)
		{
			if (setting == "Limited" || (setting && !canRotate))
			{
				return false;
			}
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		this.m.cooldown = this.m.cooldown_max;

		this.Tactical.getNavigator().switchEntities(_user, target, null, null, 1.0);

		local tag = {
			User = _user,
			TargetTile = _targetTile
		};

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.delayed_shieldwall, tag);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1000, this.delayed_taunt, tag);
		return true;
	}

	function delayed_shieldwall( _tag )
	{
		local shieldwall = _tag.User.getSkills().getSkillByID("actives.shieldwall");
		if (shieldwall != null) shieldwall.useForFree(_tag.TargetTile);
	}

	function delayed_taunt( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
		local range = 2;
		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.isAlliedWith(_tag.User)) continue;
				if (a.getID() == _tag.User.getID()) continue;
				if (a.getTile().getDistanceTo(mytile) > range) continue;

				local taunted = ::new("scripts/skills/effects/taunted_effect");

				if (_tag.User.isPlayerControlled()) // user is player
				{
					a.getAIAgent().setForcedOpponent(_tag.User);
				}
				else // user is ai
				{
					taunted.m.forced_target = a;
				}
				a.getSkills().add(taunted);
			}
		}
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

