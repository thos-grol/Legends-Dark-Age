::Const.Perks.HoundmasterClassTree <- {
	ID = "HoundmasterClassTree",
	Name = "Hound Master",
	Descriptions = [
		"training dogs"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.VanguardClassTree <- {
	ID = "VanguardClassTree",
	Name = "Vanguard",
	Descriptions = [
		"TODO"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.ClassTrees <- {
	Tree = [
		::Const.Perks.HoundmasterClassTree,
	],
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}

			L.push(i);
		}

		local r = ::Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];

		foreach( row in tree.Tree )
		{
			foreach( p in row )
			{
				L.push(p);
			}
		}

		local r = ::Math.rand(0, L.len() - 1);
		return L[r];
	}

};

