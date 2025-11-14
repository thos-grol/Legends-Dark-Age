
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
		this.m.LastEnteredLocation = this.WeakTableRef(closest_settlement);

		this.showTownScreen();
	}
	else
	{
		this.m.MenuStack.pop();
		#FEATURE_6: o.onLeave <- function ()
		# override legend's onleave function, disable camping shit
		# add your own stuff
	}
		
	return true;
}, "Open Closest Location", null, "Reopens closest location from map.");