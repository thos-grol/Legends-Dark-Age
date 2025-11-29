::mods_hookBaseClass("contracts/contract", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.create = function()
	{
		local r;

		if (::World.getTime().Days < 5)
		{
			r = ::Math.rand(1, 30);
		}
		else if (::World.getTime().Days < 10)
		{
			r = ::Math.rand(1, 75);
		}
		else
		{
			r = ::Math.rand(1, 100);
		}

		if (r <= 30)
		{
			this.m.DifficultyMult = ::Math.rand(70, 85) * 0.01;
		}
		else if (r <= 75)
		{
			this.m.DifficultyMult = ::Math.rand(95, 105) * 0.01;
		}
		else if (r <= 95)
		{
			this.m.DifficultyMult = ::Math.rand(115, 135) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = ::Math.rand(145, 165) * 0.01;
		}

		this.m.PaymentMult = ::Math.rand(90, 110) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
	}

});
