::m.rawHook("scripts/factions/faction", function(p) {
	//hk - actions are fired here, but we disable it in favor of ours
	p.update <- function( _ignoreDelay = false, _isNewCampaign = false ) { }
});