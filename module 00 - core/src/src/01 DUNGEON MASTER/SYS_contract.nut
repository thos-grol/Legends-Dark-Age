// #0005 - Proof of concept system of modular contract
// hooks contract_manager to fire day end event at the end of the contract
::mods_hookNewObject("contracts/contract_manager", function(o)
{
    //processInput controls execution flow based on contract screen outputs
	o.processInput = function ( _option )
	{
		if (this.m.LastShown == null) return;
		if (!this.m.LastShown.processInput(_option))
		{
			if (this.m.IsEventVisible)
			{
				this.m.IsEventVisible = false;
				::World.State.getMenuStack().pop(true);

				//hk - fire day end event at the end of the contract
				::Z.S.end_day_contract();
			}
		}
		else
		{
			this.m.IsEventVisible = true;
			::World.State.getEventScreen().show(this.m.LastShown);
		}
	}
	
});

::mods_hookDescendants("contracts/contract", function (o)
{
    //processInput controls execution flow based on contract screen outputs
	o.processInput <- function( _option )
	{
        if (this.m.ActiveScreen == null) return false;
		if (_option >= this.m.ActiveScreen.Options.len()) return true;
		
        local result = this.m.ActiveScreen.Options[_option].getResult();

		if (typeof result != "string" && result <= 0)
		{
            if (this.isActive()) this.setScreen(null);
			return false;
		}

        //hk - pop and get the next screen from the contract_stack to display
		if (typeof result == "string" && result == "contract_stack")
        {
            local c_stack_id = ::Z.T.Contract.Stack.pop();
            this.setScreen(this.getScreen(c_stack_id));
        }
        else
        {
            this.setScreen(this.getScreen(result));
        }
		
		return true;
	}
});

