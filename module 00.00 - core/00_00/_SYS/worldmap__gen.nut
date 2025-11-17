::Const.World.Settings.Snowline <- 0.70;
::Const.World.Settings.MinDesertTiles <- 900;

::Const.World.settingsUpdate <- function ()
{
	// this.Const.World.Settings.LandMassMult = 1.0 + (::Legends.Mod.ModSettings.getSetting("LandRatio").getValue() / 100.0);
	// this.Const.World.Settings.WaterConnectivity = ::Legends.Mod.ModSettings.getSetting("Water").getValue();
	// this.Const.World.Settings.Snowline = ::Legends.Mod.ModSettings.getSetting("Snowline").getValue() / 100.0;
};

::Const.World.Settlements.LegendsWorldMaster <- [
	{
		Ratio = 0.0,
		Types = Const.World.Settlements.Legends_fortifications,
		Capitals = true,
		Cap = true,
		Sizes = [
			{
				Ratio = 10,
				MinAmount = 3,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.20,
		Types = this.Const.World.Settlements.Legends_villages_coast,
		Sizes = [
			{
				Ratio = 3,
				MinAmount = 2,
				Size = 2
			}
		]
	},
	{
		Ratio = 0.50,
		Types = Const.World.Settlements.Legends_villages,
		Sizes = [
			{
				Ratio = 3,
				MinAmount = 13,
				Size = 2,
			},
		]
	},
	{
		Ratio = 0.0,
		Types = Const.World.Settlements.Legends_citystates,
		IgnoreSide = true,
		AdditionalSpace = 13,
		Sizes = [
			{
				Ratio = 10,
				MinAmount = 1,
				Size = 3
			}
		]
	}
];

::mods_hookNewObjectOnce("mapgen/templates/world/worldmap_generator", function ( o )
{
    o.guaranteeAllBuildingsInSettlements <- function () { }
    
	o.buildSettlements = function ( _rect )
	{
		local _properties = this.World.State.m.CampaignSettings;
		this.LoadingScreen.updateProgress("Building Settlements ...");
		this.logInfo("Building settlements...");
		local isLeft = this.Math.rand(0, 1);
		local settlementTiles = [];

		//TODO: when rolling factions, assign correct citadels to factions

		// then close to a faction's village, place 3 bandit warlord camps for each faction

		// TODO: let's design organic factions and force level system

		// TODO: place vampire castle
		// TODO: place shifting woods
		// TODO: place ghost village 

		//TODO: lower the snow line

		foreach( list in this.Const.World.Settlements.LegendsWorldMaster )
		{
			local num = Math.ceil(::Legends.Mod.ModSettings.getSetting("Settlements").getValue() * list.Ratio);
			//Add at least one of each

			local additionalSpace = 0;
			if ("AdditionalSpace" in list)
			{
				additionalSpace = list.AdditionalSpace;
			}

			if ("Capitals" in list)
			{
				foreach (s in list.Sizes)
				{
					for (local i = 0; i < s.MinAmount; i = ++i)
					{
						settlementTiles = this.addSettlement_Capital(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list, (i == 0));
						num = --num;
					}
				}
			}
			else
			{
				foreach (s in list.Sizes)
				{
					for (local i = 0; i < s.MinAmount; i = ++i)
					{
						
						settlementTiles = this.addSettlement(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list);
						num = --num;
					}
				}
			}

			

			if ("Cap" in list && list.Cap) continue;
			

			while (num > 0)
			{
				local r = this.Math.rand(1, 10);
				local total = 0;
				foreach (s in list.Sizes)
				{
					total += s.Ratio;
					if (r > total)
					{
						continue;
					}
					settlementTiles = this.addSettlement(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list);
					break;
				}
				num = --num;
			}
		}

		this.logInfo("Created " + settlementTiles.len() + " settlements.");
		return settlementTiles.len() >= 19
	}


	o.addSettlement_Capital <- function (_rect, isLeft, settlementList, settlementSize, settlementTiles, additionalSpace, ignoreSide, is_north)
	{
		local tries = 0;

		while (tries++ < 3000)
		{
			local x;
			local y;

			if (!ignoreSide)
			{
				if (isLeft)
				{
					x = this.Math.rand(5, _rect.W * 0.6);
				}
				else
				{
					x = this.Math.rand(_rect.W * 0.4, _rect.W - 6);
				}
			}
			else
			{
				x = this.Math.rand(5, _rect.W - 6);
			}

			y = this.Math.rand(5, _rect.H * 0.95);
			local tile = this.World.getTileSquare(x, y);

			if (is_north)
			{
				if (tile.Type != ::Const.World.TerrainType.Snow) continue;
			}
			else
			{
				if (tile.Type == ::Const.World.TerrainType.Snow) continue;
				if (tile.Type == ::Const.World.TerrainType.SnowyForest) continue;
			}

			if (settlementTiles.find(tile.ID) != null) continue;

			local next = false;
			local distance = 12 + additionalSpace;
			// if (tries > 3000) {
			// 	distance -= 4;
			// }
			// if (tries > 6000) {
			// 	distance -= 8;
			// }

			foreach( settlement in settlementTiles )
			{
				if (tile.getDistanceTo(settlement) < 50)
				{
					next = true;
					break;
				}
			}

			if (next)
			{
				continue;
			}


			local terrain = this.getTerrainInRegion(tile);


			if (terrain.Adjacent[this.Const.World.TerrainType.Ocean] >= 3 || terrain.Adjacent[this.Const.World.TerrainType.Shore] >= 3)
			{
				continue;
			}

			local candidates = [];

			foreach( settlement in settlementList )
			{
				if (settlement.isSuitable(terrain))
				{
					candidates.push(settlement);
				}
			}

			if (candidates.len() == 0)
			{
				continue;
			}

			local type = candidates[this.Math.rand(0, candidates.len() - 1)];

			if ((terrain.Region[this.Const.World.TerrainType.Ocean] >= 3 || terrain.Region[this.Const.World.TerrainType.Shore] >= 3) && !("IsCoastal" in type) && !("IsFlexible" in type))
			{
				continue;
			}

			if (!("IsCoastal" in type))
			{
				local skip = settlementTiles.len() != 0;
				local navSettings = this.World.getNavigator().createSettings();

				for( local i = settlementTiles.len() - 1; i >= 0; i = --i )
				{
					local settlement = settlementTiles[i];
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
					local path = this.World.getNavigator().findPath(tile, settlement, navSettings, 0);

					if (!path.isEmpty())
					{
						skip = false;
						break;
					}
				}

				if (skip)
				{
					continue;
				}
			}
			else if (settlementTiles.len() >= 1 && tries < 500)
			{
				local hasConnection = false;

				for( local i = settlementTiles.len() - 1; i >= 0; i = --i )
				{
					local settlement = settlementTiles[i];
					local navSettings = this.World.getNavigator().createSettings();
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
					local path = this.World.getNavigator().findPath(tile, settlement, navSettings, 0);

					if (!path.isEmpty())
					{
						hasConnection = true;
						break;
					}
				}

				if (!hasConnection)
				{
					continue;
				}
			}

			tile.clear();
			local entity = this.World.spawnLocation(type.Script, tile.Coords);
			entity.setSize(settlementSize);
			settlementTiles.push(tile);
			return settlementTiles;
		}
		return settlementTiles
	}

});

