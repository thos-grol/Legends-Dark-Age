::m.rawHook("scripts/contracts/contract", function(p) {
	p.m.Bro_Limit <- 6;
	p.m.IsStory <- false;
	p.m.Difficulty <- 0; // 0-3
	p.get_details <- function()
	{
		return {
			Name = this.m.Name,
			ID = this.m.ID,
			Description = this.m.Description == null ? "Unset" : this.m.Description,
			IsStory = this.m.IsStory,
			Difficulty = this.m.Difficulty,
		};
	}

	p.m.contract_entity <- null;
	p.bind_entity <- function(e)
	{
		this.m.contract_entity = e;
	}

	p.get_contract_entity <- function()
	{
		return this.m.contract_entity;
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

	// local onSerialize = o.onSerialize;
	// o.onSerialize = function (_out) {
	// 	onSerialize(_out);
	// 	_out.writeI32(this.m.X);
	// 	_out.writeI32(this.m.Y);
	// }

	// local onDeserialize = o.onDeserialize;
	// o.onDeserialize = function(_in)
	// {
	// 	onDeserialize(_in);
	// 	this.m.X = _in.readI32();
	// 	this.m.Y = _in.readI32();
	// }
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

// hk - fix text
::mods_hookBaseClass("contracts/contract", function ( o )
{
	o.buildText <- function(_text)
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local brother1 = this.Math.rand(0, brothers.len() - 1);
		local brother2 = this.Math.rand(0, brothers.len() - 1);

		if (brothers.len() >= 2)
		{
			while (brother1 == brother2)
			{
				brother2 = this.Math.rand(0, brothers.len() - 1);
			}
		}

		local gender1 = brothers[brother1].getGender();
		local gender2 = brothers[brother2].getGender();

		if (brothers.len() < 2) {
			brother1 = "unknown";
			brother2 = "unknown";
		} else {
			brother1 = brothers[brother1].getName();
			brother2 = brothers[brother2].getName();
		}

		local villages = this.World.EntityManager.getSettlements();
		local randomTown;

		do
		{
			randomTown = villages[this.Math.rand(0, villages.len() - 1)].getNameOnly();
		}
		while (randomTown == null || randomTown == this.m.Home.getNameOnly());

		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_START",
				"[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randombrother",
				brother1
			],
			[
				"randombrother2",
				brother2
			],
			[
				"randomtown",
				randomTown
			],
			[
				"reward_completion",
				this.m.Payment.getOnCompletion()
			],
			[
				"reward_advance",
				this.m.Payment.getInAdvance()
			],
			[
				"reward_count",
				this.m.Payment.getPerCount()
			],
			[
				"reward_item_count",
				this.m.Payment.Items.len()
			],
			[
				"employer",
				this.m.EmployerID != 0 ? this.Tactical.getEntityByID(this.m.EmployerID).getName() : ""
			],
			[
				"faction",
				this.World.FactionManager.getFaction(this.m.Faction).getName()
			],
			[
				"maxcount",
				this.m.Payment.MaxCount
			]
		];


		// if (this.m.Origin != null) {
		// 	::MSU.Log.printData(this.m.Origin, 4);
		// 	vars.push([
		// 		"origin",
		// 		this.m.Origin.getName()
		// 	]);
		// }


		if (this.m.Home != null) {
			vars.push([
				"townname",
				this.m.Home.getName()
			]);
			vars.push(			[
				"produce",
				this.m.Home.getProduceAsString()
			]);
		}

		this.onPrepareVariables(vars);
		vars.push([
			"reward",
			this.m.Payment.getOnCompletion() + this.m.Payment.getInAdvance()
		]);
		if (this.m.EmployerID != 0)
		{
			::Const.LegendMod.extendVarsWithPronouns(vars, this.getEmployer().getGender(), "employer");
		}
		::Const.LegendMod.extendVarsWithPronouns(vars, gender1, "randombrother");
		::Const.LegendMod.extendVarsWithPronouns(vars, gender2, "randombrother2");
		return this.buildTextFromTemplate(_text, vars);
	}
});