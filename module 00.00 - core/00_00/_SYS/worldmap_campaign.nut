::mods_hookExactClass("states/world_state", function(o) {

	o.startNewCampaign <- function()
	{
		this.setAutoPause(true);
		this.Time.setVirtualTime(0);
		this.m.IsRunningUpdatesWhilePaused = true;
		this.setPause(true);
		this.Math.seedRandomString(this.m.CampaignSettings.Seed);
		local worldmap = this.MapGen.get("world.worldmap_generator");
		local minX = worldmap.getMinX();
		local minY = worldmap.getMinY();
		this.World.resizeScene(minX, minY);
		worldmap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
		::logInfo("worldmap.fill");
		this.m.Assets.init();
		this.World.FactionManager.createFactions();
		this.World.EntityManager.buildRoadAmbushSpots();
		this.Math.seedRandomString(this.m.CampaignSettings.Seed);
		::logInfo("this.Math.seedRandomString(this.m.CampaignSettings.Seed);");

		if (this.m.CampaignSettings != null)
		{
			::logInfo("1");
			this.m.Assets.setCampaignSettings(this.m.CampaignSettings);
			::logInfo("2");
			this.m.CampaignSettings.StartingScenario.onSpawnPlayer();
			::logInfo("3");
			this.m.CampaignSettings.StartingScenario.onInit();
			::logInfo("4");
			this.World.uncoverFogOfWar(this.getPlayer().getTile().Pos, 900.0);
			::logInfo("5");
		}

		::logInfo("6");
		this.World.FactionManager.uncoverSettlements(this.m.CampaignSettings.ExplorationMode);
		::logInfo("uncoverSettlements");
		this.World.FactionManager.runSimulation();
		::logInfo("runSimulation");
		this.m.CampaignSettings = null;
		this.setupWeather();
		this.Math.seedRandom(this.Time.getRealTime());
		
		if (this.Const.DLC.Unhold)
		{
			this.World.Flags.set("IsUnholdCampaign", true);
		}
		
		if (this.Const.DLC.Wildmen)
		{
			this.World.Flags.set("IsWildmenCampaign", true);
		}
		
		if (this.Const.DLC.Desert)
		{
			this.World.Flags.set("IsDesertCampaign", true);
		}
		
		this.World.FactionManager.fix_settlement_display();
        this.World.setFogOfWar(false);
	}

    local onDeserialize = o.onDeserialize;
    o.onDeserialize = function ( _in )
    {
        onDeserialize(_in);
        this.World.setFogOfWar(false);
    }

});

