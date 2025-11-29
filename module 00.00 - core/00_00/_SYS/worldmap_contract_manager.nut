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
			// _contract.m.TimeOut += ::World.getTime().SecondsPerDay * (::Math.rand(0, 200) - 100) * 0.01;

			// hk - spawn contract entity here
			::Z.S.spawn_contract_entity(_contract.m.Home, _contract);
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
	}

	o.finishActiveContract <- function( _isCancelled = false )
	{
		if (this.m.Active == null) return;

		if (!_isCancelled)
		{
			if (this.World.FactionManager.getFaction(this.m.Active.getFaction()).getType() == this.Const.FactionType.NobleHouse)
			{
				this.updateAchievement("MeddlingWithNobility", 1, 1);
			}
			else if (this.World.FactionManager.getFaction(this.m.Active.getFaction()).getType() == this.Const.FactionType.Settlement && this.m.Active.getType() != "contract.tutorial")
			{
				this.updateAchievement("BloodMoney", 1, 1);
			}

			if (this.m.Active.getType() == "contract.escort_caravan")
			{
				this.World.Statistics.getFlags().increment("EscortCaravanContractsDone");
			}

			if (this.World.FactionManager.getFaction(this.m.Active.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
			{
				this.World.Statistics.getFlags().increment("CityStateContractsDone");
			}
		}
		else
		{
			this.updateAchievement("BrokenPromises", 1, 1);
		}

		this.World.FactionManager.getFaction(this.m.Active.getFaction()).removeContract(this.m.Active);
		this.World.Assets.getOrigin().onContractFinished(this.m.Active.getType(), _isCancelled);
		this.m.Active.clear();
		this.m.Active = null;
		this.m.LastShown = null;
		++this.m.ContractsDone;

		if (!_isCancelled)
		{
			++this.m.ContractsFinished;
		}

		this.World.State.getWorldScreen().clearContract();
		this.World.State.updateTopbarAssets();
		this.World.Ambitions.updateUI();
	}


	o.get_contract_by_id <- function ( _id ){
		foreach(contract in this.m.Open)
		{
			if(contract.getID() == _id)
			{
				return contract;
			}
		}
		return null;
	}
	
});