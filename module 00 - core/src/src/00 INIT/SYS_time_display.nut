// #0003 - Set up basic World UI - create new day variable as flag
::mods_hookExactClass("states/world_state", function(o)
{
    local onInit = o.onInit;
	o.onInit = function()
	{
		//after init finishes (this is when statistics is loaded or created), if days dne, create
        onInit();
        if (!::World.Statistics.getFlags().has("Days_sim")) 
            ::World.Statistics.getFlags().set("Days_sim", 1);
		
		// make sure you update the world screen
		::World.State.getWorldScreen().getTopbarDatasourceModule().updateTimeInformation_manual();
	}
});

// #0003 - Set up basic World UI - ui queries to display time information
// This hook add/overrides functions that the ui queries to display time information
// We can use updateTimeInformation_manual to update the ui manually during freeze time 
// Call stack
//      ::World.State
//          getWorldScreen() -> this.m.WorldScreen
//              getTopbarDatasourceModule() -> return this.m.TopbarDatasourceModule;
//
// ::World.State.getWorldScreen().getTopbarDatasourceModule().updateTimeInformation_manual()
::mods_hookExactClass("ui/screens/world/modules/topbar/world_screen_topbar_datasource_module", function(o) {
    o.updateTimeInformation <- function()
	{
		local currentTime = ::World.getTime();

		if (::Math.abs(currentTime.Minutes - this.m.LastTimeInformationUpdate) < 2) return;
		this.m.LastTimeInformationUpdate = currentTime.Minutes;
		local data = {
			day = ::World.Statistics.getFlags().getAsInt("Days_sim"),
			time = "Morning",
			degree = 0
		};
		this.m.JSHandle.asyncCall("loadTimeInformation", data);
	}
    o.updateTimeInformation_manual <- function()
	{
		local data = {
			day = ::World.Statistics.getFlags().getAsInt("Days_sim"),
			time = "Morning",
			degree = 0
		};
		this.m.JSHandle.asyncCall("loadTimeInformation", data);
	}
});

