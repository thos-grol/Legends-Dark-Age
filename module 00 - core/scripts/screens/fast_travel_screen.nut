//#0003 - Set up basic World UI - fast travel
//this is the sq class for the fast travel screen
this.fast_travel_screen <- ::inherit("scripts/mods/msu/ui_screen", {
	m = {},
	
	//calls the ui to confirm travel
	function ask_travel(_immediately = false)
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("ask_travel", _immediately);
		}
	}

	//ui calls this fn to initiate travel
	function do_travel()
	{
		::Z.T.Event.build_stack();
		::Z.S.transition(::Z.T.Event.iterate_stack);
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
		this.m.JSHandle = ::UI.connect("Mod_Fast_Travel_Screen", this);
	}
});
