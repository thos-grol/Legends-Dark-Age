this.send_bandit_ambushers_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		timeBetweenSpawnsPerSettlement = 150
	},
	function create()
	{
		this.m.ID = "send_bandit_ambushers_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();

		if (settlements.len() < 7)
		{
			return;
		}

		if (this.World.FactionManager.isCivilWar())
		{
			if (_faction.getUnits().len() >= 9)
			{
				return;
			}
		}
		else if (this.World.FactionManager.isGreaterEvil())
		{
			if (_faction.getUnits().len() >= 4)
			{
				return;
			}
		}
		else if (_faction.getUnits().len() >= 7)
		{
			return;
		}

		local allowed = false;

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() == 0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + this.m.timeBetweenSpawnsPerSettlement > this.Time.getVirtualTimeF())
			{
				continue;
			}

			allowed = true;
			break;
		}

		if (!allowed)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() == 0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + this.m.timeBetweenSpawnsPerSettlement > this.Time.getVirtualTimeF() || s.getFlags().get("isContractLocation"))
			{
				continue;
			}

			local activeContract = this.World.Contracts.getActiveContract();

			if (activeContract != null && ("Destination" in activeContract.m) && activeContract.m.Destination == s)
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local mult = this.World.FactionManager.isCivilWar() ? 1.1 : 1.0;

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			if (this.World.FactionManager.isCivilWar())
			{
			}
			else
			{
				local mult = 1.0;
			}
		}

		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());

		if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
		{
			mult = mult * (distanceToNextSettlement / 14);
		}

		local party = this.getFaction().spawnEntity(settlement.getTile(), "Brigands", false, this.Const.World.Spawn.BanditRaiders, this.Math.rand(75, 120) * this.getScaledDifficultyMult() * mult);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A rough and tough band of brigands preying on the weak.");
		party.setFootprintType(this.Const.World.FootprintsType.Brigands);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(0, 50);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Medicine = this.Math.rand(0, 2);
		party.getLoot().Ammo = this.Math.rand(0, 20);
		local r = this.Math.rand(1, 6);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/roots_and_berries_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dried_fruits_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/ground_grains_item");
		}
		else if (r == 5)
		{
			party.addToInventory("supplies/pickled_mushrooms_item");
		}

		local c = party.getController();
		local ambush = this.new("scripts/ai/world/orders/ambush_order");
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(ambush);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	}

});

