::mods_hookExactClass("entity/world/locations/goblin_hideout_location", function(o) {
	o.getDescription = function()
	{
		return "An abandoned homestead with a collapsed roof.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_hideout";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Passive;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.GoblinDefenders);
		this.m.Resources = 70;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.Hideout);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 100), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 5), _lootTable);
		this.dropAmmo(this.Math.rand(0, 20), _lootTable);
		this.dropFood(this.Math.rand(1, 2), [
			"strange_meat_item",
			"roots_and_berries_item",
			
		], _lootTable);
		this.dropTreasure(1, [
			"loot/signet_ring_item",
			"trade/amber_shards_item",
			"trade/cloth_rolls_item",
			"trade/salt_item",
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_homestead_01");
	}

});
