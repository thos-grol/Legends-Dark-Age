// hk purpose
// - initializes custom day record 
// - displays it
::mods_hookExactClass("states/world_state", function(o)
{
    local onInit = o.onInit;
	o.onInit = function()
	{
        onInit(); //after this, statistics object is created or loaded 

        // hk
		// create custom day record if DNE
		if (!::World.Statistics.getFlags().has("Days_sim")) 
            ::World.Statistics.getFlags().set("Days_sim", 1);
		
		// update the ui with our custom day record
		::World.State.getWorldScreen().getTopbarDatasourceModule().updateTimeInformation_manual();

		// hk end
	}
});



// hk purpose
// - add/overrides functions that the ui queries to display time information to display custom time
// 
// trace of ::World.State.getWorldScreen().getTopbarDatasourceModule().updateTimeInformation_manual():
//
//      ::World.State
//          getWorldScreen() -> this.m.WorldScreen
//              getTopbarDatasourceModule() -> return this.m.TopbarDatasourceModule;
//
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

