//#0003 - Set up basic World UI - fast travel
//this screen fades in and out as a transition
this.transition_screen <- ::inherit("scripts/mods/msu/ui_screen", {
	m = {},

	//calls the ui to confirm travel
	function transition()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("do_transition", null);
		}
	}

	function transition_callback()
	{
		::Z.S.transition_callback();
	}

	function show( _flags = [] )
	{
		if (this.m.JSHandle == null)
		{
			throw ::MSU.Exception.NotConnected(this.m.ID);
		}
		else if (this.isVisible())
		{
			throw ::MSU.Exception.AlreadyInState(this.m.ID);
		}
		this.m.JSHandle.asyncCall("show", ::MSU.System.ModSettings.getUIData(_flags));
	}

	function connect()
	{
		this.m.JSHandle = ::UI.connect("Mod_Transition_Screen", this);
	}
});
