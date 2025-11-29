// has to be put here, otherwise keybind will be overwritten by msu

::mods_hookExactClass("states/world_state", function(o)
{
	# #0003 Set up basic World UI - logic to forever disable unpausing
	o.setPause = function( _f )
	{
		if (this.m.IsGamePaused && this.m.IsGameAutoPaused) return;
		if (!this.m.IsGamePaused) this.m.IsGamePaused = true
		if (!this.m.IsGameAutoPaused) this.m.IsGameAutoPaused = true

		this.m.LastWorldSpeedMult = ::World.getSpeedMult() != 0 ? ::World.getSpeedMult() : this.m.LastWorldSpeedMult;
		::World.setSpeedMult(0.0);
		this.m.IsAIPaused = true;

		if ("TopbarDayTimeModule" in ::World && ::World.TopbarDayTimeModule != null)
			::World.TopbarDayTimeModule.updateTimeButtons(0);
	}
});


# #0003 Set up basic World UI - logic keybind town screen
//adds a keybind to open and close town screen with space
::MSU.Mod.Keybinds.addSQKeybind("oc_town_screen", "space", ::MSU.Key.State.World, function() {
	if (this.m.MenuStack.hasBacksteps() && this.m.CharacterScreen.isVisible())
	{
		this.toggleCharacterScreen();
		return true;
	}

	if (this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating()) return false;
	if (!this.m.WorldTownScreen.isVisible())
	{
		this.m.AutoEnterLocation = null;
		local closest_settlement = ::Z.S.get_settlement_closest();
		this.m.LastEnteredTown = this.WeakTableRef(closest_settlement);
		// this.m.LastEnteredLocation = this.WeakTableRef(closest_settlement);
		this.showTownScreen();
	}
	else
	{
		this.m.MenuStack.pop();
		#FEATURE_1: o.onLeave <- function ()
		# override legend's onleave function, disable camping shit
		# add your own stuff
	}
		
	return true;
}, "Open Closest Location", null, "Reopens closest location from map.");