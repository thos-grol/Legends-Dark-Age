// contracts are all stored in contract manager
// settlement has getContracts() to pull list of contracts in that settlement
// embark button should set contract to be triggered in queue and then save
    // upon loading, contract would be triggered
    // there can be multiple fights in the contract

::mods_hookNewObject("factions/faction_manager", function(o)
{
    // we abandon this update, seems to threaded, and called multiple times upon world gen, so avoid
	o.update <- function( _ignoreDelay = false ) { }
	o.update_true <- function( )
	{
		::Z.S.generate_weekly_actions();
		// local ids = [
		// 	"House Adelheim"
		// ];

		// foreach (id in ids) {
		// 	this.get_faction(id);
		// }
	}

	o.runSimulation <- function ()
	{
		// this.logInfo("Running simulation for " + this.Const.Factions.CyclesOnNewCampaign + " cycles...");
		// local barbarians = this.Const.DLC.Wildmen ? this.getFactionOfType(this.Const.FactionType.Barbarians) : null;
		// local bandits = this.getFactionOfType(this.Const.FactionType.Bandits);
		// local nomads = this.Const.DLC.Desert ? this.getFactionOfType(this.Const.FactionType.OrientalBandits) : null;
		// local orcs = this.getFactionOfType(this.Const.FactionType.Orcs);
		// local goblins = this.getFactionOfType(this.Const.FactionType.Goblins);
		// local undead = this.getFactionOfType(this.Const.FactionType.Undead);
		// local zombies = this.getFactionOfType(this.Const.FactionType.Zombies);
		// local beasts = this.getFactionOfType(this.Const.FactionType.Beasts);

		// for( local i = 0; i < this.Const.Factions.CyclesOnNewCampaign; i = ++i )
		// {
		// 	if (barbarians != null)
		// 	{
		// 		barbarians.update(true, true);
		// 	}

		// 	if (nomads != null)
		// 	{
		// 		nomads.update(true, true);
		// 	}

		// 	bandits.update(true, true);
		// 	goblins.update(true, true);
		// 	orcs.update(true, true);
		// 	undead.update(true, true);
		// 	zombies.update(true, true);
		// 	beasts.update(true, true);
		// 	this.__ping();
		// }
	}

});