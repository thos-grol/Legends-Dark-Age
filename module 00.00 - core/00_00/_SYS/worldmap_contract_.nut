::m.rawHook("scripts/contracts/contract", function(p) {
	// this.m.Home <- stores the settlement associated with the contract, contract.setHome(_h)

	// TODO: completion, destroy world entity, remove this contract from world manager
	// add resolution to faction

			// village tooltip: add owner.
			// contracts spawned if village is above z level use barbarians instead

			// faction has enemies stored as details?
			//	enemies simulated faction can conflict with faction

	p.m.Description <- "";
	p.m.IsStory <- false;
	p.m.Difficulty <- 0; // 0-3
	p.get_details <- function()
	{
		return {
			Name = this.m.Name,
			Description = this.m.Description,
			IsStory = this.m.IsStory,
			Difficulty = this.m.Difficulty,
		};
	}

	p.m.X <- null;
	p.m.Y <- null;
	p.set_coordinates <- function(x, y)
	{
		this.m.X = x;
		this.m.Y = y;
	}

	p.m.Entity <- null;
	p.set_entity <- function(contract_entity)
	{
		this.m.Entity = this.WeakTableRef(contract_entity);
	}

});

// This file sets up contracts
::mods_hookBaseClass("contracts/contract", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];
    local create = o.create;
    o.create = function()
    {
        create();
        // hk - This seed is set to "preserve" rolled enemies
        // use ::Math.seedRandom(this.Time.getRealTime());
        this.m.Flags.set("Seed", this.Time.getRealTime()); 
    }

	local onSerialize = o.onSerialize;
	o.onSerialize = function (_out) {
		onSerialize(_out);
		_out.writeI32(this.m.X);
		_out.writeI32(this.m.Y);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function(_in)
	{
		onDeserialize(_in);
		this.m.X = _in.readI32();
		this.m.Y = _in.readI32();
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

