//hooks loading screen to add various functions
::mods_hookExactClass("ui/screens/loading/loading_screen", function(o) {
	o.onScreenHidden = function()
	{
		this.m.Visible = false;
		this.m.Animating = false;

		if (this.m.OnScreenHiddenListener != null)
		{
			this.m.OnScreenHiddenListener();
		}

		//hk - show custom time system
		try
		{
			::World.State.getWorldScreen().getTopbarDatasourceModule().updateTimeInformation_manual();
		} catch(Exception) {}
		
        //hk - pop and get the next screen from the contract_stack to display
		if (::Z.T.Contract.Stack.len() > 0)
        {
            ::Z.S.show_contract_screen_post_combat(null);
            return;
        }
	}
});