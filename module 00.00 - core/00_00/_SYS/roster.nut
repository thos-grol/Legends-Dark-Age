// hk purpose
// - get bro roster

// function strategic_onQueryBrothersList()
// {
// 	local roster = ::World.Assets.getFormation();
// 	for( local i = 0; i != roster.len(); i = ++i )
// 	{
// 		if (roster[i] != null)
// 		{
// 			roster[i] = this.UIDataHelper.convertEntityToUIData(roster[i], null);
// 		}
// 	}
// 	return roster;
// }

::mods_hookExactClass("states/world/asset_manager", function(o)
{
    // - get bro roster, we modify it for the increased roster size
    o.getFormation <- function()
	{
		// we expand the possible formation size to 470 max
        // this is for 10 theoretical squads (270), and 200 storage
        local ret = [];
		ret.resize(27 * 10 + 200, null);

		local roster = ::World.getPlayerRoster().getAll();
		foreach( b in roster )
		{
			ret[b.getPlaceInFormation()] = b;
		}
		return ret;
	}

    // this function here determines the count for in combat, and also changes roster positions
    // shouldn't be necessary if we validate input in squad ui
    o.updateFormation <- function( considerMaxBros = false ) { }
});

// extend the roster size from u8 to u16
// _out.writeU8(this.m.PlaceInFormation);
// u8 is 256 logical locations, we want around 400 about, so change it to u16
// we need to modify serialize and deserialize
::mods_hookExactClass("entity/tactical/player", function(o)
{
    o.onSerialize <- function( _out )
	{
		this.human.onSerialize(_out);
		_out.writeU8(this.m.Level);
		_out.writeU8(this.m.PerkPoints);
		_out.writeU8(this.m.PerkPointsSpent);
		_out.writeU8(this.m.LevelUps);
		_out.writeF32(this.m.Mood);
		_out.writeU8(this.m.MoodChanges.len());

		for( local i = 0; i != this.m.MoodChanges.len(); i = ++i )
		{
			_out.writeBool(this.m.MoodChanges[i].Positive);
			_out.writeString(this.m.MoodChanges[i].Text);
			_out.writeF32(this.m.MoodChanges[i].Time);
		}

		_out.writeF32(this.m.HireTime);
		_out.writeF32(this.m.LastDrinkTime);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			_out.writeU8(this.m.Talents[i]);
		}

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			_out.writeU8(this.m.Attributes[i].len());

			foreach( a in this.m.Attributes[i] )
			{
				_out.writeU8(a);
			}
		}

		// u8 to u16
        _out.writeU16(this.m.PlaceInFormation);

		_out.writeU32(this.m.LifetimeStats.Kills);
		_out.writeU32(this.m.LifetimeStats.Battles);
		_out.writeU32(this.m.LifetimeStats.BattlesWithoutMe);
		_out.writeU16(this.m.LifetimeStats.MostPowerfulVanquishedType);
		_out.writeString(this.m.LifetimeStats.MostPowerfulVanquished);
		_out.writeU16(this.m.LifetimeStats.MostPowerfulVanquishedXP);
		_out.writeString(this.m.LifetimeStats.FavoriteWeapon);
		_out.writeU32(this.m.LifetimeStats.FavoriteWeaponUses);
		_out.writeU32(this.m.LifetimeStats.CurrentWeaponUses);
		_out.writeBool(this.m.IsTryoutDone);
	}

	o.onDeserialize <- function( _in )
	{
		if (_in.getMetaData().getVersion() >= 59)
		{
			this.human.onDeserialize(_in);
		}
		else
		{
			this.actor.onDeserialize(_in);
		}

		this.m.Surcoat = null;
		this.m.Level = _in.readU8();
		this.m.PerkPoints = _in.readU8();
		this.m.PerkPointsSpent = _in.readU8();
		this.m.LevelUps = _in.readU8();
		this.m.Mood = _in.readF32();
		local numMoodChanges = _in.readU8();
		this.m.MoodChanges.resize(numMoodChanges, 0);

		for( local i = 0; i != numMoodChanges; i = ++i )
		{
			local moodChange = {};
			moodChange.Positive <- _in.readBool();
			moodChange.Text <- _in.readString();
			moodChange.Time <- _in.readF32();
			this.m.MoodChanges[i] = moodChange;
		}

		this.m.HireTime = _in.readF32();
		this.m.LastDrinkTime = _in.readF32();
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			this.m.Talents[i] = _in.readU8();
		}

		this.m.Attributes.resize(this.Const.Attributes.COUNT);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			this.m.Attributes[i] = [];
			local n = _in.readU8();
			this.m.Attributes[i].resize(n);

			for( local j = 0; j != n; j = ++j )
			{
				this.m.Attributes[i][j] = _in.readU8();
			}
		}

		local ret = this.m.Skills.query(this.Const.SkillType.Background);

		if (ret.len() != 0)
		{
			this.m.Background = ret[0];
			this.m.Background.adjustHiringCostBasedOnEquipment();
			this.m.Background.buildDescription(true);
		}

		// u8 to u16
        this.m.PlaceInFormation = _in.readU16();
        
		this.m.LifetimeStats.Kills = _in.readU32();
		this.m.LifetimeStats.Battles = _in.readU32();
		this.m.LifetimeStats.BattlesWithoutMe = _in.readU32();

		if (_in.getMetaData().getVersion() >= 37)
		{
			this.m.LifetimeStats.MostPowerfulVanquishedType = _in.readU16();
		}

		this.m.LifetimeStats.MostPowerfulVanquished = _in.readString();
		this.m.LifetimeStats.MostPowerfulVanquishedXP = _in.readU16();
		this.m.LifetimeStats.FavoriteWeapon = _in.readString();
		this.m.LifetimeStats.FavoriteWeaponUses = _in.readU32();
		this.m.LifetimeStats.CurrentWeaponUses = _in.readU32();
		this.m.IsTryoutDone = _in.readBool();
		this.m.Skills.update();
	}
});