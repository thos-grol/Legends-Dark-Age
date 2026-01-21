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


::Const.Perks.RogueClassTree <- {
	ID = "RogueClassTree",
	Name = "Rogue",
	Descriptions = [
		"TODO"
	],
	Tree = [
		[
			::Const.Perks.PerkDefs.Alert2,
			::Const.Perks.PerkDefs.Conservation,
			::Const.Perks.PerkDefs.Fleche,
		],
		[
			::Const.Perks.PerkDefs.TwinFangs,
			::Const.Perks.PerkDefs.FastAdaptation2,
			::Const.Perks.PerkDefs.WeaponHarmony,
		],
		[
			::Const.Perks.PerkDefs.Poisoner,
			::Const.Perks.PerkDefs.Reflex,
			::Const.Perks.PerkDefs.QuickHands2,
		],
		[
			::Const.Perks.PerkDefs.Escape,
			::Const.Perks.PerkDefs.NineLives,
			::Const.Perks.PerkDefs.TrueStrike,
		],
		[
			::Const.Perks.PerkDefs.PoisonMaster,
			::Const.Perks.PerkDefs.Untouchable,
			::Const.Perks.PerkDefs.SerpentsStrike,
		],
		[
			::Const.Perks.PerkDefs.LotusPoison,
			::Const.Perks.PerkDefs.Sap,
			::Const.Perks.PerkDefs.BattleDance,
		],
		[
			::Const.Perks.PerkDefs.UncannyDodge,
			::Const.Perks.PerkDefs.ViciousInsight,
			::Const.Perks.PerkDefs.WeaponMaster,
		]
	]
};


::Const.Perks.VanguardClassTree <- {
	ID = "VanguardClassTree",
	Name = "Vanguard",
	Descriptions = [
		"Vanguards are meant to stand tall amidst a sea of foes"
	],
	Tree = [
		[
			::Const.Perks.PerkDefs.BlockMastery,
			::Const.Perks.PerkDefs.Conservation,
			::Const.Perks.PerkDefs.BruteStrength,
		],
		[
			::Const.Perks.PerkDefs.Safeguard,
			::Const.Perks.PerkDefs.Steadfast2,
			::Const.Perks.PerkDefs.SurvivalInstinct,
		],
		[
			::Const.Perks.PerkDefs.IronMountain,
			::Const.Perks.PerkDefs.Vanguard,
			::Const.Perks.PerkDefs.Rage,
		],
		[
			::Const.Perks.PerkDefs.StunStrike,
			::Const.Perks.PerkDefs.Executioner2,
			::Const.Perks.PerkDefs.TrueStrike,
		],
		[
			::Const.Perks.PerkDefs.ReboundForce,
			::Const.Perks.PerkDefs.HoldtheLine,
			::Const.Perks.PerkDefs.Berserk,
		],
		[
			::Const.Perks.PerkDefs.NineLives,
			::Const.Perks.PerkDefs.HeavyCounter,
			::Const.Perks.PerkDefs.Unhindered,
		],
		[
			::Const.Perks.PerkDefs.ImpactCondensation,
			::Const.Perks.PerkDefs.LionsRoar,
			::Const.Perks.PerkDefs.DeathDealer,
		]
	]
};


::Const.Perks.ClassTrees <- {
	Tree = [
		::Const.Perks.RogueClassTree,
		// ::Const.Perks.VanguardClassTree,
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