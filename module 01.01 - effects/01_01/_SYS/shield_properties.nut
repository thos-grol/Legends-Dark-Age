// this hooks the shield class
// - adds shieldwall armor point amount
::m.rawHook("scripts/items/shields/shield", function(p) {

	// - adds shieldwall armor point amount
	p.m.ShieldwallAP <- 40;

});