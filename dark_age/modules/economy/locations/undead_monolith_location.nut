::mods_hookExactClass("entity/world/locations/undead_monolith_location", function(o) {
	o.getDescription = function()
	{
		return "A pitch black monolith towers over the surrounding lands, emitting a baleful aura. No living being dares drawing close to it.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.black_monolith";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 500;
		this.m.NamedWeaponsList = ::Const.Items.NamedUndeadWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedUndeadShields;
		this.m.OnEnter = "event.location.monolith_enter";
	}

	o.onSpawned = function()
	{
		this.m.Name = "Black Monolith";
		this.location.onSpawned();

		for( local i = 0; i < 8; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.SkeletonMedium
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 7; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.SkeletonMediumPolearm
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 5; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.Vampire
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.VampireLOW
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 9; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.SkeletonHeavy
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 8; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.SkeletonHeavyPolearm
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 5; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.SkeletonHeavyBodyguard
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 3; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.SkeletonPriest
			}, false);
			i = ++i;
		}
	}

	o.onBeforeCombatStarted = function()
	{
		this.location.onBeforeCombatStarted();

		for( local added = 0; this.m.Troops.len() < 47;  )
		{
			local r = ::Math.rand(1, 7);

			if (r == 1)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.SkeletonMedium
				}, false);
			}
			else if (r == 2)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.SkeletonMediumPolearm
				}, false);
			}
			else if (r == 3)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.Vampire
				}, false);
			}
			else if (r == 4)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.VampireLOW
				}, false);
			}
			else if (r == 5)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.SkeletonHeavy
				}, false);
			}
			else if (r == 6)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.SkeletonHeavyPolearm
				}, false);
			}
			else if (r == 7)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.SkeletonPriest
				}, false);
			}

			added = ++added;
			added = added;

			if (added >= 3)
			{
				break;
			}
		}
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(::Math.rand(0, 60), _lootTable);
		this.dropTreasure(::Math.rand(3, 4), [
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"misc/scroll"
		], _lootTable);
		_lootTable.push(::Const.World.Common.pickArmor([
			[
				1,
				"legendary/emperors_armor"
			]
		]));
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_monolith_01");
	}

});

