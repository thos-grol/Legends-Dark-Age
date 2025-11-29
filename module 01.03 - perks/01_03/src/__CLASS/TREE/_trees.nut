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
		[
			::Const.Perks.PerkDefs.LoadTraining,
			::Const.Perks.PerkDefs.Mettle,
			::Const.Perks.PerkDefs.BruteStrength,
		],
		[
			::Const.Perks.PerkDefs.Safeguard,
			::Const.Perks.PerkDefs.Steadfast2,
			::Const.Perks.PerkDefs.SurvivalInstinct,
		],
		[
			::Const.Perks.PerkDefs.IronMountain,
			::Const.Perks.PerkDefs.HoldtheLine,
			::Const.Perks.PerkDefs.Rage,
		],
		[
			::Const.Perks.PerkDefs.BlockMastery,
			::Const.Perks.PerkDefs.SteadyDefense,
			::Const.Perks.PerkDefs.DyingWish,
		],
		[
			::Const.Perks.PerkDefs.ReboundForce,
			::Const.Perks.PerkDefs.ShieldBash,
			::Const.Perks.PerkDefs.Berserk,
		],
		[
			::Const.Perks.PerkDefs.UnendingForce,
			::Const.Perks.PerkDefs.Indomitable,
			::Const.Perks.PerkDefs.UnendingRage,
		],
		[
			::Const.Perks.PerkDefs.Immortal,
			::Const.Perks.PerkDefs.Momentum,
			::Const.Perks.PerkDefs.DeathDealer,
		]
	]
};

::Const.Perks.ClassTrees <- {
	Tree = [
		// ::Const.Perks.HoundmasterClassTree,
		::Const.Perks.VanguardClassTree,
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