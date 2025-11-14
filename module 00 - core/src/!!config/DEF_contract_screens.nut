//This file defines screen templates to be used by contracts
::Const.Contracts.Overview_NEW <- [
	{
		ID = "Overview",
		Title = "",
		Text = "The contract you negotiated is as follows. Do you agree to the terms?",
		Image = "",
		List = [],
		Options = [
			{
				Text = "I accept this contract.",
				function getResult()
				{
					this.Contract.setState("Running");
					return "contract_stack";
				}

			},
			{
				Text = "I\'ll need some time to think about this.",
				function getResult()
				{
					::World.State.getTownScreen().updateContracts();
					return 0;
				}

			},
			{
				Text = "On second thought, I decline this contract.",
				function getResult()
				{
					::World.Contracts.removeContract(this.Contract);
					::World.State.getTownScreen().updateContracts();
					return 0;
				}

			}
		],
		ShowObjectives = true,
		ShowPayment = true,
		ShowEmployer = true,
		ShowDifficulty = true,
		function start()
		{
			this.Contract.m.IsNegotiated = true;
		}

	}
];