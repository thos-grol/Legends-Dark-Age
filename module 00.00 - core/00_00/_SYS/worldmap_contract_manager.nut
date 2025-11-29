::mods_hookNewObject("contracts/contract_manager", function(o)
{
    // #0005 - Proof of concept system of modular contract
	// hooks contract_manager to fire day end event at the end of the contract
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
				// TODO: instead we roll for an event and fire it
				::Z.S.end_day_contract();
			}
		}
		else
		{
			this.m.IsEventVisible = true;
			::World.State.getEventScreen().show(this.m.LastShown);
		}
	}

	o.addContract = function( _contract, _isNewContract = true )
	{
		if (!_contract.isValid()) return;

		if (_isNewContract)
		{
			_contract.m.ID = this.generateContractID();

			//TODO: get expiration weeks from contract
			_contract.m.TimeOut += ::World.getTime().SecondsPerDay * (::Math.rand(0, 200) - 100) * 0.01;
		}

		this.logDebug("contract added: " + _contract.getName());

		if (_contract.getFaction() != 0)
		{
			::World.FactionManager.getFaction(_contract.getFaction()).addContract(_contract);

			if (_isNewContract)
			{
				::World.FactionManager.getFaction(_contract.getFaction()).setLastContractTime(this.Time.getVirtualTimeF());
			}
		}

		this.m.Open.push(_contract);

		// hk - spawn contract entity here
		::Z.S.spawn_contract_entity(_contract.m.Home, _contract);
	}
	
});