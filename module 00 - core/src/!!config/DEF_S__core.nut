//This file defines static functions involving ui transitions
// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================


// =========================================================================================
// Main
// =========================================================================================

::Z.S.increment_day <- function ()
{
	::World.Statistics.getFlags().set("Days_sim", ::World.Statistics.getFlags().getAsInt("Days_sim") + 1);
	::World.State.getWorldScreen().getTopbarDatasourceModule().updateTimeInformation_manual();
}
// =========================================================================================
// Helper
// =========================================================================================