::mods_hookNewObject("factions/faction_manager", function(o)
{
    o.get_closest_villages <- function(villages, capital, split_len)
	{
		// create tuples of (distance, index)
		local distance_to_capital = [];
		foreach( i, village in villages )
		{
			distance_to_capital.push([capital.getTile().getDistanceTo(village.getTile()), i]);
		}

		// sort tuples by distance
		function distance_comparator(first, second) 
		{
			local a = first[0];
			local b = second[0];
		
			if (a > b) return 1;
			if (a < b) return -1;
			return 0;
		}
		distance_to_capital.sort(distance_comparator);

		// create list of indices
		local indices = [];
		for(local i = 0; i < split_len; i++)
		{
			indices.push(distance_to_capital[i][1]);
		}
		indices.sort();

		local ret = [];
		for(local i = indices.len() - 1; i >= 0; i--)
		{
			ret.push(villages[indices[i]]);
			villages.remove(indices[i]);
		}
		return ret;
	}

	o.assignSettlementsToNobleHouses = function ( _nobleHouses )
	{
		// Algorithm
		// 1. Assign capitals (and rename)
		// 2. Each faction takes turns picking one settlement closest to them on the list
		
		local settlements = ::World.EntityManager.getSettlements();
		local capitals = [];
		local villages = [];
		for( local i = 0; i < settlements.len(); i = ++i )
		{
			if (this.isKindOf(settlements[i], "city_state")) continue;
			else if (settlements[i].isMilitary())
			{
				capitals.push(settlements[i]);
			}
			else
			{
				villages.push(settlements[i]);
			}
		}

		
		local j = 1;
		foreach (capital in capitals) {
			if (capital.getTile().Type == ::Const.World.TerrainType.Snow)
			{
				_nobleHouses[0].addSettlement(capital);
			}
			else _nobleHouses[j++].addSettlement(capital);
		}
		capitals.clear();
		
		// local index = distance_to_capital[k][1];
		// local village = villages[index];
		// n.addSettlement(village);
		// villages.remove(index);
		
		// Templar Order should have the most villages
		local split = villages.len() / 3;
		
		foreach( i, n in _nobleHouses )
		{
			if (i < 2)
			{
				local capital = n.getSettlements()[0];
				local to_add = this.get_closest_villages(villages, capital, split);
				foreach( village in to_add )
				{
					n.addSettlement(village);
				}
			}
			else // give the templar order all the rest
			{
				foreach( village in villages )
				{
					n.addSettlement(village);
				}

			}
			
		}



		// local turn = 0;
		// do
		// {
			
		// 	turn++;
		// 	if (turn > 2) turn = 0;
		// }
		// while (villages.len() > 0);

		// foreach( s in villages )
		// {
		// 	local best;
		// 	local bestAvgDist = 9000.0;

		// 	foreach( i, n in _nobleHouses )
		// 	{
		// 		local locales = n.getSettlements();
		// 		local avgDist = 0.0;

		// 		foreach( l in locales )
		// 		{
		// 			avgDist = avgDist + l.getTile().getDistanceTo(s.getTile());
		// 		}

		// 		avgDist = avgDist / locales.len();
		// 		avgDist = avgDist + locales.len();

		// 		if (avgDist < bestAvgDist)
		// 		{
		// 			bestAvgDist = avgDist;
		// 			best = n;
		// 		}
		// 	}

		// 	if (best != null)
		// 	{
		// 		best.addSettlement(s);
		// 	}
		// }

		local mapSize = ::World.getMapSize();
		local northernTile = ::World.getTileSquare(mapSize.X / 2, mapSize.Y - 1);
		local houses = [];

		foreach( n in _nobleHouses )
		{
			local closest;
			local dist = 9999;

			foreach( s in n.getSettlements() )
			{
				local d = s.getTile().getDistanceTo(northernTile);

				if (d < dist)
				{
					dist = d;
					closest = s;
				}
			}

			houses.push({
				Faction = n,
				Dist = dist
			});
		}

		houses.sort(function ( _a, _b )
		{
			if (_a.Dist > _b.Dist)
			{
				return -1;
			}
			else if (_a.Dist < _b.Dist)
			{
				return 1;
			}

			return 0;
		});

		for( local i = 0; i < 2; i = ++i )
		{
			houses[i].Faction.getFlags().set("IsHolyWarParticipant", true);
		}
	}

	// o.assignSettlementsToNobleHouses = function ( _nobleHouses )
	// {
	// 	local settlements = ::World.EntityManager.getSettlements();
	// 	local capitals = [];
	// 	local villages = [];

	// 	for( local i = 0; i < settlements.len(); i = ++i )
	// 	{
	// 		if (this.isKindOf(settlements[i], "city_state"))
	// 		{
	// 		}
	// 		else if (settlements[i].isMilitary())
	// 		{
	// 			capitals.push(settlements[i]);
	// 		}
	// 		else
	// 		{
	// 			villages.push(settlements[i]);
	// 		}
	// 	}

	// 	capitals.sort(this.onSizeCompare);

	// 	foreach( i, n in _nobleHouses )
	// 	{
	// 		if (capitals.len() > 0)
	// 		{
	// 			n.addSettlement(capitals[0]);
	// 			capitals.remove(0);
	// 		}
	// 		local other;
	// 		do
	// 		{
	// 			other = ::Math.rand(0, _nobleHouses.len() - 1);
	// 		}
	// 		while (other == i);

	// 		local description = n.getDescription();
	// 		local vars = [
	// 			[
	// 				"noblehousename",
	// 				n.getNameOnly()
	// 			],
	// 			[
	// 				"regionname",
	// 				""
	// 			],
	// 			[
	// 				"factionfortressname",
	// 				n.getSettlements()[0].getName()
	// 			],
	// 			[
	// 				"othernoblehouse",
	// 				_nobleHouses[other].getNameOnly()
	// 			]
	// 		];
	// 		n.setDescription(this.buildTextFromTemplate(description, vars));
	// 	}

	// 	capitals.extend(villages);

	// 	foreach( s in capitals )
	// 	{
	// 		local best;
	// 		local bestAvgDist = 9000.0;

	// 		foreach( i, n in _nobleHouses )
	// 		{
	// 			local locales = n.getSettlements();
	// 			local avgDist = 0.0;

	// 			foreach( l in locales )
	// 			{
	// 				avgDist = avgDist + l.getTile().getDistanceTo(s.getTile());
	// 			}

	// 			avgDist = avgDist / locales.len();
	// 			avgDist = avgDist + locales.len();

	// 			if (avgDist < bestAvgDist)
	// 			{
	// 				bestAvgDist = avgDist;
	// 				best = n;
	// 			}
	// 		}

	// 		if (best != null)
	// 		{
	// 			best.addSettlement(s);
	// 		}
	// 	}

	// 	local mapSize = ::World.getMapSize();
	// 	local northernTile = ::World.getTileSquare(mapSize.X / 2, mapSize.Y - 1);
	// 	local houses = [];

	// 	foreach( n in _nobleHouses )
	// 	{
	// 		local closest;
	// 		local dist = 9999;

	// 		foreach( s in n.getSettlements() )
	// 		{
	// 			local d = s.getTile().getDistanceTo(northernTile);

	// 			if (d < dist)
	// 			{
	// 				dist = d;
	// 				closest = s;
	// 			}
	// 		}

	// 		houses.push({
	// 			Faction = n,
	// 			Dist = dist
	// 		});
	// 	}

	// 	houses.sort(function ( _a, _b )
	// 	{
	// 		if (_a.Dist > _b.Dist)
	// 		{
	// 			return -1;
	// 		}
	// 		else if (_a.Dist < _b.Dist)
	// 		{
	// 			return 1;
	// 		}

	// 		return 0;
	// 	});

	// 	for( local i = 0; i < 2; i = ++i )
	// 	{
	// 		houses[i].Faction.getFlags().set("IsHolyWarParticipant", true);
	// 	}
	// }

    //function createFactions()

    // function createSettlements()
	// {
	// 	local settlements = ::World.EntityManager.getSettlements();

	// 	foreach( s in settlements )
	// 	{
	// 		if (s.isMilitary() || this.isKindOf(s, "city_state"))
	// 		{
	// 			continue;
	// 		}

	// 		local f = this.new("scripts/factions/settlement_faction");
	// 		f.setID(this.m.Factions.len());
	// 		f.setName(s.getName());
	// 		f.setDescription(s.getDescription());
	// 		f.setBanner(11);
	// 		f.setDiscovered(true);
	// 		this.m.Factions.push(f);
	// 		f.addTrait(this.Const.FactionTrait.Settlement);
	// 		f.addSettlement(s, false);
	// 	}
	// }

	
});