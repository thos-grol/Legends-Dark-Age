
this.perk_escape <- this.inherit("scripts/skills/skill", {
	m = {
		cooldown = 0,
		cooldown_max = 3
		tile_info = null
	},
	function create()
	{
		this.m.ID = "perk.escape";
		this.m.Name = ::Const.Strings.PerkName.Escape;
		this.m.Description = ::Const.Strings.PerkDescription.Escape;
		this.m.Icon = "ui/perks/escape.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/lunge_move_01.wav",
			"sounds/combat/dlc2/lunge_move_02.wav",
			"sounds/combat/dlc2/lunge_move_03.wav",
			"sounds/combat/dlc2/lunge_move_04.wav"
		];
	}

	function onTurnStart()
	{
		if (this.m.cooldown > 0) this.m.cooldown--;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.cooldown > 0) return;

		this.m.tile_info = get_escape_tile_info();
		if (this.m.tile_info == null || this.m.tile_info._tile == null) return;

		_properties.DamageReceivedRegularMult *= 0.5;
	}

	function onMissed( _attacker, _skill )
	{
		if (this.m.cooldown > 0) return;
		this.m.tile_info = get_escape_tile_info();
		escape();
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.cooldown > 0) return;
		local actor = this.getContainer().getActor();
		if (_damageHitpoints >= actor.getHitpoints()) return;
		escape();
	}


	function escape()
	{
		if (this.m.tile_info == null || this.m.tile_info._tile == null) return;
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer())
		{
			::Tactical.EventLog.logIn(::color_name(actor) + " [Escape]");
		}
		
		this.getContainer().setBusy(true);
		
		actor.spawnTerrainDropdownEffect(actor.getTile());
		::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill);

		this.m.cooldown = this.m.cooldown_max;
		::Tactical.getNavigator().teleport(actor, this.m.tile_info._tile, this.onTeleportDone.bindenv(this), null, false, 3.0);
		this.m.tile_info = null;
	}

	function onTeleportDone( _entity, _tag )
	{
		this.getContainer().setBusy(false);
	}

	function get_escape_tile_info()
	{
		local actor = this.getContainer().getActor();
		local tile = actor.getTile();

		local zocs = tile.getZoneOfControlCountOtherThan(actor.getAlliedFactions());
		if (zocs < 2) return;

		local best_og_tile_info = null;
		
		local directions = [5, 4, 3, 0];
		foreach (direction in directions)
		{
			local tile_infos = ::Z.S.get_empty_tiles_direction(actor, tile, direction, 3, 4);
			if (tile_infos.len() == 0) continue;
			foreach (tile_info in tile_infos)
			{
				local t = tile_info._tile;
				local zocs = tile_info._zocs;
				local distance = tile_info._distance;

				if (best_og_tile_info == null) best_og_tile_info = tile_info;
				else
				{
					if (distance > best_og_tile_info._distance)
					{
						if (zocs <= best_og_tile_info._zocs)
							best_og_tile_info = tile_info;
					}
					else if (distance == best_og_tile_info._distance)
					{
						if (zocs < best_og_tile_info._zocs)
							best_og_tile_info = tile_info;
					}
				}

				if (best_og_tile_info._distance == 4 && best_og_tile_info._zocs == 0) break;
			}

			if (best_og_tile_info._distance == 4 && best_og_tile_info._zocs == 0) break;
		}

		return best_og_tile_info;
	}

});