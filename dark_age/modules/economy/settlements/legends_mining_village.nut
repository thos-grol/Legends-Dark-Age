::mods_hookExactClass("entity/world/settlements/legends_mining_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Goldhoft",
				"Ellenberg",
				"Kahlenberg",
				"Bokenberg",
				"Gronenberg",
				"Eisenstein",
				"Fuchsberg",
				"Dunkelspitzen",
				"Hochland",
				"Felsig",
				"Reinberg",
				"Kaltenhof",
				"Jaderberg",
				"Steinhausen",
				"Eichenberg",
				"Thal",
				"Wolfhaiden",
				"Trogen",
				"Sattel",
				"Koppingen",
				"Schweikhof",
				"Hochdorf",
				"Bergau",
				"Nasenfels",
				"Adlerstein",
				"Felsheim",
				"Mitterfels",
				"Hohenau",
				"Pfeilstein",
				"Schneeberg",
				"Weissenfels",
				"Senftenberg",
				"Eisengrab",
				"Weitblick",
				"Erdfall",
				"Helfenstein",
				"Hammererden"
			],
			[
				"Hochgrube",
				"Erzgrube",
				"Schachtheim",
				"Erzheim",
				"Schmelzheim",
				"Eisenstein",
				"Erzfels",
				"Gemmenschacht",
				"Salzbruch",
				"Salzfels",
				"Erzbruch",
				"Hohenbruch",
				"Eisenheim",
				"Grubenheim",
				"Eisenberg",
				"Erzberg",
				"Havelberg",
				"Goldbruch",
				"Wolkenstein",
				"Goldstein",
				"Gemmenstein",
				"Grafenschacht",
				"Kahlengrube",
				"Trogenschacht",
				"Adlerstollen",
				"Reinbruch",
				"Hammererden",
				"Schneefels",
				"Weissenschacht",
				"Ellengrube"
			],
			[
				"Hochgrube",
				"Erzgrube",
				"Schachtheim",
				"Erzheim",
				"Schmelzheim",
				"Eisenstein",
				"Erzfels",
				"Gemmenschacht",
				"Salzbruch",
				"Salzfels",
				"Erzbruch",
				"Hohenbruch",
				"Eisenheim",
				"Grubenheim",
				"Eisenberg",
				"Erzberg",
				"Havelberg",
				"Goldbruch",
				"Wolkenstein",
				"Goldstein",
				"Gemmenstein",
				"Grafenschacht",
				"Kahlengrube",
				"Trogenschacht",
				"Adlerstollen",
				"Reinbruch",
				"Hammererden",
				"Schneefels",
				"Weissenschacht",
				"Ellengrube"
			]
		];
		this.m.DraftLists = [
			[
				"apprentice_background",
				"beggar_background",
				"brawler_background",
				"daytaler_background",
				"graverobber_background",


				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",

				"thief_background",
				"poacher_background",
				"apprentice_background",
				"brawler_background",
				"graverobber_background",


				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",

				"poacher_background"
			],
			[
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				
				
				"daytaler_background",
				"juggler_background",
				"killer_on_the_run_background",


				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",

				

				
				"thief_background",

				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				
				
				"juggler_background",
				"killer_on_the_run_background",


				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",

				
				
			],
			[
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				
				
				"daytaler_background",
				"juggler_background",
				"killer_on_the_run_background",


				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",

				

				
				"thief_background",

				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				
				
				"juggler_background",
				"killer_on_the_run_background",


				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",

				
				
			]
		];
		this.m.FemaleDraftLists = [
			[



			],
			[



			],
			[



			]
		];
		this.m.StablesLists = [
			[
				"legend_donkey_background"
			],
			[
				"legend_donkey_background"
			],
			[
				"legend_donkey_background"
			]
		];
		this.m.Rumors = ::Const.Strings.RumorsMiningSettlement;
		this.m.ProduceString = "ore";
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.m.Size >= 2 && ::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 3);

		if (r <= 1)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r <= 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gem_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gem_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/salt_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gold_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 3);

		if (r <= 1)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r <= 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gem_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gem_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/salt_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gold_mine_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}

});

