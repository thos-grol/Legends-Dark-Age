this.direwolf_blizzard <- this.inherit("scripts/skills/skill", {
	m = {
		SnowTiles = []
	},
	function create()
	{
		this.m.ID = "actives.direwolf_blizzard";
		this.m.Name = "Blizzard";
		this.m.Description = "Casts a powerful cold spell. Can hit many targets.";
		this.m.Icon = "ui/xx7.png";
		this.m.IconDisabled = "ui/xx7_sw.png";
		this.m.SoundOnUse = [
			"sounds/winter/blizzard_buildup.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 222;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsWeaponSkill = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsTargetingActor = false;
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;

		for( local i = 1; i <= 3; i = ++i )
		{
			this.m.SnowTiles.push(this.MapGen.get("tactical.tile.snow" + i));
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: [color=" + ::Const.UI.Color.PositiveValue + "](40) ~ (80 + Level x 2)[/color] \nDouble Grip: [color=" + ::Const.UI.Color.PositiveValue + "]+30% Damage[/color] \nDuelist (Perk): [color=" + ::Const.UI.Color.PositiveValue + "]+30% Armor Ignore[/color]"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "+5% Hit chance, Ranged attack type, Ignores obstacles and only attacks selected targets, Can hit up to 7 targets"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The area affected by the skill turns into a snow tile, and units located at that point become cold. (100% chance)"
		});
		return ret;
	}

	function applyEffectToTargets( _tag )
	{
		local user = _tag.User;
		local targets = _tag.Targets;

		foreach( t in targets )
		{
			for( local i = 0; i < ::Const.Tactical.SpiritWalkEndParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, ::Const.Tactical.SpiritWalkEndParticles[i].Brushes, t, ::Const.Tactical.SpiritWalkEndParticles[i].Delay, ::Const.Tactical.SpiritWalkEndParticles[i].Quantity, ::Const.Tactical.SpiritWalkEndParticles[i].LifeTimeQuantity, ::Const.Tactical.SpiritWalkEndParticles[i].SpawnRate, ::Const.Tactical.SpiritWalkEndParticles[i].Stages);
			}

			if (t.Subtype != ::Const.Tactical.TerrainSubtype.Snow && t.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow)
			{
				t.clear();
				t.Type = 0;
				_tag.Skill.m.SnowTiles[::Math.rand(0, _tag.Skill.m.SnowTiles.len() - 1)].onFirstPass({
					X = t.SquareCoords.X,
					Y = t.SquareCoords.Y,
					W = 1,
					H = 1,
					IsEmpty = true,
					SpawnObjects = false
				});
			}

			if (!t.IsOccupiedByActor || !t.getEntity().isAttackable())
			{
				continue;
			}

			local target = t.getEntity();
			this.attackEntity(user, target, false);
			// target.getSkills().add(::new("scripts/skills/effects/xxmagebb_effect"));
		}
		this.Sound.play("sounds/winter/blizzard_impact.wav", 2.0, user.getPos());
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [];
		this.Tactical.queryTilesInRange(_targetTile, 1, 1, false, [], this.onQueryTilesHit, ret);
		this.Tactical.queryTilesInRange(_targetTile, 2, 4, false, [], this.onQueryTilesHitRandom, ret);
		return ret;
	}

	function onQueryTilesHit( _tile, _ret )
	{
		_ret.push(_tile);
	}

	function onQueryTilesHitRandom( _tile, _ret )
	{
		if (::Math.rand(1,100) <= 50) _ret.push(_tile);
	}

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = this.getAffectedTiles(_targetTile);

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};
		for( local i = 0; i < ::Const.Tactical.SpiritWalkStartParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, ::Const.Tactical.SpiritWalkStartParticles[i].Brushes, _user.getTile(), ::Const.Tactical.SpiritWalkStartParticles[i].Delay, ::Const.Tactical.SpiritWalkStartParticles[i].Quantity, ::Const.Tactical.SpiritWalkStartParticles[i].LifeTimeQuantity, ::Const.Tactical.SpiritWalkStartParticles[i].SpawnRate, ::Const.Tactical.SpiritWalkStartParticles[i].Stages);
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local user = _tag.User;
		local targetTile = _tag.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local affectedTiles = this.getAffectedTiles(targetTile);
		local tag = {
			Skill = _tag.Skill,
			User = user,
			Targets = affectedTiles
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.applyEffectToTargets.bindenv(this), tag);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 40;
			_properties.DamageRegularMax = 60;
			_properties.DamageArmorMult = 0.0;
			// local xactor = this.getContainer().getActor();
			// local xitems = xactor.getItems();
			// local mainh = xitems.getItemAtSlot(::Const.ItemSlot.Mainhand);
			// local offh = xitems.getItemAtSlot(::Const.ItemSlot.Offhand);
			// _properties.RangedSkill += 5;
			// _properties.RangedAttackBlockedChanceMult *= 0;
			// if (xthis.m.Container.hasSkill("perk.duelist"))
			// {
			// 	if (offh == null && !xitems.hasBlockedSlot(::Const.ItemSlot.Offhand) || offh != null && offh.isItemType(::Const.Items.ItemType.Tool))
			// 	{
			// 		_properties.DamageDirectAdd += 0.05;
			// 	}
			// }
			// if (mainh != null && offh == null && mainh.isDoubleGrippable())
			// {
			// 	_properties.DamageTotalMult *= 1.3;
			// }
		}
	}

});

