::Const.Factions.RelationDecayPerDay <- 0;

::m.rawHook("scripts/factions/faction", function(p) {
    // update
    p.update <- function( _ignoreDelay = false, _isNewCampaign = false )
	{
		if (!this.m.IsActive) return;
		if (this.m.Deck.len() == 0) return;
		if (!_ignoreDelay && this.m.LastActionTime + this.Const.Factions.GlobalMinDelay > this.Time.getVirtualTimeF()) return;
		
		if (!_ignoreDelay) this.m.LastActionTime = this.Time.getVirtualTimeF();

		this.onUpdateRoster();
		this.onUpdate();

        // autoresolve -> determine squad preset used for mission -> determine strength of unit (unit strength * autoresolve multiplier)
        //             -> determine strength of enemy squad (unit strength * autoresolve multiplier)

        // smaller/larger - determine tiers for chance of victory
        // ie. 100% = 50%
        //      90% = 45%
        //      80% = 35%
        //      70% = 30%
        //      60% = 15%
        //      50% = 10%
        //       <  = 0%

        // unit strength ratings:
        // lv 1-2 Rookie = 10 str
        // lv 3-4 Grunt  = 20 str
        // lv 5-6 Veteran = 30 str
        // lv 7   Warrior = 60 str
        // lv 8   Elite = 70 str

        // Determine Hero str and rosters

        // gear ratings ie. faction ugprades
        // potions += 50 str
        // armor upgrades
        // weapon upgrades

        // pawn - 1
        // knight - 3
        // bishop - 3.5
        // rook - 5
        // queen - 9



        // create custom decks for factions
        // turn -> all cards in deck will be processed
        // random -> card will be drawn from deck each turn, force level changes deck

		// for( local i = 0; i < this.m.Deck.len(); i = ++i )
		// {
		// 	this.m.Deck[i].update(_isNewCampaign);

		// 	if (this.m.Deck[i].getScore() <= 0)
		// 	{
		// 	}
		// 	else
		// 	{
		// 		score = score + this.m.Deck[i].getScore();
		// 	}
		// }

		// if (score == 0)
		// {
		// 	return;
		// }

		// local pick = this.Math.rand(1, score);

		// for( local i = 0; i < this.m.Deck.len(); i = ++i )
		// {
		// 	if (this.m.Deck[i].getScore() <= 0)
		// 	{
		// 	}
		// 	else
		// 	{
		// 		if (pick <= this.m.Deck[i].getScore())
		// 		{
		// 			actionToFire = this.m.Deck[i];
		// 			break;
		// 		}

		// 		pick = pick - this.m.Deck[i].getScore();
		// 	}
		// }

		// if (actionToFire == null)
		// {
		// 	return;
		// }

		// actionToFire.execute(_isNewCampaign);

	}

    // serialization
    p.onSerialize <- function( _out )
	{
		_out.writeU8(this.m.ID);
		_out.writeString(this.m.Name);
		_out.writeString(this.m.Description);
		_out.writeString(this.m.Motto);
		_out.writeU8(this.m.Banner);
		_out.writeU8(this.m.Traits.len());

		foreach( t in this.m.Traits )
		{
			_out.writeU8(t);
		}

		_out.writeU16(this.m.Deck.len());

		for( local i = 0; i != this.m.Deck.len(); i = ++i )
		{
			_out.writeI32(this.m.Deck[i].ClassNameHash);
			_out.writeF32(this.m.Deck[i].getCooldownUntil());
		}

		_out.writeU8(this.m.Allies.len());

		foreach( a in this.m.Allies )
		{
			_out.writeU8(a);
		}

		_out.writeF32(this.m.PlayerRelation);
		local numSettlements = 0;

		foreach( s in this.m.Settlements )
		{
			if (s.isAlive())
			{
				numSettlements = ++numSettlements;
			}
		}

		_out.writeU8(numSettlements);

		foreach( s in this.m.Settlements )
		{
			if (!s.isAlive())
			{
				continue;
			}

			_out.writeI32(s.getID());

			if (s.getOwner() != null && s.getOwner().getID() == this.getID())
			{
				_out.writeBool(true);
			}
			else
			{
				_out.writeBool(false);
			}
		}

		local numUnits = 0;

		foreach( s in this.m.Units )
		{
			if (s.isAlive())
			{
				numUnits = ++numUnits;
			}
		}

		_out.writeU16(numUnits);

		foreach( s in this.m.Units )
		{
			if (s.isAlive())
			{
				_out.writeI32(s.getID());
			}
		}

		_out.writeF32(this.m.LastActionTime);
		_out.writeU8(this.m.LastActionHour);
		_out.writeF32(this.m.LastContractTime);
		_out.writeBool(this.m.IsDiscovered);
		this.m.Flags.onSerialize(_out);
		_out.writeU8(this.m.PlayerRelationChanges.len());

		for( local i = 0; i != this.m.PlayerRelationChanges.len(); i = ++i )
		{
			_out.writeBool(this.m.PlayerRelationChanges[i].Positive);
			_out.writeString(this.m.PlayerRelationChanges[i].Text);
			_out.writeF32(this.m.PlayerRelationChanges[i].Time);
		}
	}

	p.onDeserialize <- function( _in )
	{
		this.m.ID = _in.readU8();
		this.m.Name = _in.readString();
		this.m.Description = _in.readString();
		this.m.Motto = _in.readString();
		this.m.Banner = _in.readU8();
		local numTraits = _in.readU8();

		for( local i = 0; i < numTraits; i = ++i )
		{
			this.addTrait(_in.readU8());
		}

		local numCooldowns = _in.readU16();
		local cooldowns = [];

		for( local i = 0; i != numCooldowns; i = ++i )
		{
			local actionID = _in.readI32();
			local cooldownUntil = _in.readF32();

			for( local j = 0; j != this.m.Deck.len(); j = ++j )
			{
				if (this.m.Deck[j].ClassNameHash == actionID)
				{
					this.m.Deck[j].setCooldownUntil(cooldownUntil);
					break;
				}
			}
		}

		this.m.Allies = [];
		local numAllies = _in.readU8();

		for( local i = 0; i != numAllies; i = ++i )
		{
			local a = _in.readU8();
			this.addAlly(a);
		}

		this.m.PlayerRelation = _in.readF32();
		local numSettlements = _in.readU8();

		for( local i = 0; i != numSettlements; i = ++i )
		{
			local s = this.World.getEntityByID(_in.readI32());
			local owner = _in.readBool();
			this.addSettlement(s, owner);
		}

		local numUnits = _in.readU16();

		for( local i = 0; i != numUnits; i = ++i )
		{
			local unit = this.World.getEntityByID(_in.readI32());
			this.addUnit(unit);
		}

		this.m.LastActionTime = _in.readF32();
		this.m.LastActionHour = _in.readU8();
		this.m.LastContractTime = _in.readF32();
		this.m.IsDiscovered = _in.readBool();
		this.m.Flags.onDeserialize(_in);
		local numRelationChanges = _in.readU8();
		this.m.PlayerRelationChanges.resize(numRelationChanges, 0);

		for( local i = 0; i != numRelationChanges; i = ++i )
		{
			local relationChange = {};
			relationChange.Positive <- _in.readBool();
			relationChange.Text <- _in.readString();
			relationChange.Time <- _in.readF32();
			this.m.PlayerRelationChanges[i] = relationChange;
		}

		this.updatePlayerRelation();
	}
});