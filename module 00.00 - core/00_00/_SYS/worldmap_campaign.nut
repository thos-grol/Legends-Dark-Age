::mods_hookExactClass("states/world_state", function(o) {
	o.startNewCampaign <- function()
	{
		this.setAutoPause(true);
		this.Time.setVirtualTime(0);
		this.m.IsRunningUpdatesWhilePaused = true;
		this.setPause(true);
		::Math.seedRandomString(this.m.CampaignSettings.Seed);
		local worldmap = this.MapGen.get("world.worldmap_generator");
		local minX = worldmap.getMinX();
		local minY = worldmap.getMinY();
		::World.resizeScene(minX, minY);
		worldmap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
		::logInfo("worldmap.fill");
		this.m.Assets.init();

		// this is where we setup the war table
		::World.FactionManager.createFactions();

		::World.EntityManager.buildRoadAmbushSpots();
		::Math.seedRandomString(this.m.CampaignSettings.Seed);
		::logInfo("::Math.seedRandomString(this.m.CampaignSettings.Seed);");

		if (this.m.CampaignSettings != null)
		{
			this.m.Assets.setCampaignSettings(this.m.CampaignSettings);
			this.m.CampaignSettings.StartingScenario.onSpawnPlayer();
			this.m.CampaignSettings.StartingScenario.onInit();
			// ::World.uncoverFogOfWar(this.getPlayer().getTile().Pos, 900.0);
			// ::logInfo("5");
		}

		// ::World.FactionManager.uncoverSettlements(this.m.CampaignSettings.ExplorationMode);
		::World.FactionManager.update_true();
		::World.FactionManager.runSimulation();

		this.m.CampaignSettings = null;
		this.setupWeather();
		::Math.seedRandom(this.Time.getRealTime());
		
		if (this.Const.DLC.Unhold)
		{
			::World.Flags.set("IsUnholdCampaign", true);
		}
		
		if (this.Const.DLC.Wildmen)
		{
			::World.Flags.set("IsWildmenCampaign", true);
		}
		
		if (this.Const.DLC.Desert)
		{
			::World.Flags.set("IsDesertCampaign", true);
		}
		
		::World.FactionManager.fix_settlement_display();
        ::World.setFogOfWar(false);
	}

    local onDeserialize = o.onDeserialize;
    o.onDeserialize = function ( _in )
    {
        onDeserialize(_in);
        ::World.setFogOfWar(false);
    }

});

::mods_hookNewObject("factions/faction_manager", function(o)
{
    o.fix_settlement_display <- function()
	{
		foreach( s in ::World.EntityManager.getSettlements() )
		{
            s.make_less_apparent();
		}
	}
});

