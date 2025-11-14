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