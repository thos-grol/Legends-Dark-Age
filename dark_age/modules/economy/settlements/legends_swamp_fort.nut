::mods_hookExactClass("entity/world/settlements/legends_swamp_fort", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Schwarzwacht",
				"Mooswall",
				"Pfuhlwall",
				"Moorwacht",
				"Furthwacht",
				"Stakenwall",
				"Kolkwacht",
				"Auenturm",
				"Torfwall",
				"Pfuhlwacht",
				"Krautwacht",
				"Moorwacht",
				"Birkwall",
				"Birkturm",
				"Brunnwall",
				"Kaltenwacht",
				"Furthwacht",
				"Grunenturm",
				"Suhlwacht",
				"Schwarzgard",
				"Moorgard",
				"Wehrturm",
				"Furthwehr",
				"Schanzmoor",
				"Wallpfuhl",
				"Wallfurt",
				"Auenwacht",
				"Brookwall",
				"Fennwacht",
				"Fackelwacht",
				"Bruchwacht",
				"Riedwehr",
				"Rohrwall",
				"Dusterwall"
			],
			[
				"Schwarzburg",
				"Moosburg",
				"Pfuhlburg",
				"Moorburg",
				"Furthburg",
				"Stakenburg",
				"Kolkburg",
				"Torfburg",
				"Krautburg",
				"Birkenburg",
				"Brunnburg",
				"Kaltenburg",
				"Grunburg",
				"Suhlburg",
				"Brookburg",
				"Muckenburg",
				"Egelburg",
				"Dunkelburg",
				"Nebelburg",
				"Bruchburg",
				"Morastburg",
				"Froschburg",
				"Schlammburg",
				"Brackenburg",
				"Molchburg",
				"Teichburg",
				"Fennburg",
				"Riedburg",
				"Schlickburg",
				"Senkburg",
				"Rohrburg",
				"Marschburg",
				"Schilfburg"
			],
			[
				"Schwarzburg",
				"Moosburg",
				"Pfuhlburg",
				"Moorburg",
				"Furthburg",
				"Stakenburg",
				"Kolkburg",
				"Torfburg",
				"Krautburg",
				"Birkenburg",
				"Brunnburg",
				"Kaltenburg",
				"Grunburg",
				"Suhlburg",
				"Brookburg",
				"Muckenburg",
				"Egelburg",
				"Dunkelburg",
				"Nebelburg",
				"Bruchburg",
				"Morastburg",
				"Froschburg",
				"Schlammburg",
				"Brackenburg",
				"Molchburg",
				"Teichburg",
				"Fennburg",
				"Riedburg",
				"Schlickburg",
				"Senkburg",
				"Rohrburg",
				"Marschburg",
				"Schilfburg"
			]
		];
		this.m.DraftLists = [
			[
				

				"daytaler_background",
				"hunter_background",
				"militia_background",
				"militia_background",
				
				


				"bastard_background",
				"deserter_background",
				"retired_soldier_background",
				

				"hunter_background",
				"militia_background",
				"militia_background",
				
				


				"bastard_background",
				"deserter_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",

				"beggar_background",
				"butcher_background",
				
				
				"hunter_background",
				
				"militia_background",
				"militia_background",


				



				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"disowned_noble_background",

				"retired_soldier_background",
				"apprentice_background",

				"butcher_background",
				
				
				"hunter_background",
				
				"militia_background",
				"militia_background",


				



				"bastard_background",
				"deserter_background",

				"retired_soldier_background"
			],
			[
				"apprentice_background",

				"beggar_background",
				"butcher_background",
				
				
				"hunter_background",
				
				"militia_background",
				"militia_background",


				



				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"disowned_noble_background",
				"retired_soldier_background",
				"apprentice_background",

				"butcher_background",
				
				
				"hunter_background",
				
				"militia_background",
				"militia_background",


				



				"bastard_background",
				"deserter_background",
				"retired_soldier_background"
			]
		];
		this.m.FemaleDraftLists = [
			[


			],
			[


				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[


				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			]
		];
		this.m.StablesLists = [
			[


			],
			[


			],
			[


			]
		];

		// if (::Const.DLC.Unhold)
		// {
		// 	this.m.DraftLists[0].push("beast_hunter_background");
		// 	this.m.DraftLists[1].push("beast_hunter_background");
		// 	this.m.DraftLists[2].push("beast_hunter_background");
		// 	this.m.DraftLists[2].push("beast_hunter_background");
		// }

		this.m.Rumors = ::Const.Strings.RumorsSwampSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		local r = ::Math.rand(1, 2);
		if (r == 1)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], 4, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));

		local r = ::Math.rand(2, 3);
		if (r == 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else if (r == 3)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));

		local r = ::Math.rand(2, 3);
		if (r == 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else if (r == 3)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
	}

});

