//Bandit Rabble
//Lvl 3
::Const.Tactical.Actor.BanditRabble <- clone ::B.Templates.Human;

::B[::Const.EntityType.BanditRabble] <- {
    Level = 1,
    Pattern = [
        ["T", 1],
        // ["D", 2],
    ],
	LevelUps = [
		["Health", 2, 0, 1],
		["Fatigue", 2, 0, 1],
	],
    Trait = [],
    Outfit = [
		[1, "bandit_rabble_outfit_00"],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_wooden_pitchfork"
		],
		[
			"scripts/items/weapons/legend_hoe"
		],
		[
			"scripts/items/weapons/legend_wooden_spear"
		],
		[
			"scripts/items/weapons/wooden_stick"
		],
		[
			"scripts/items/weapons/legend_hammer"
		],
		[
			"scripts/items/weapons/butchers_cleaver"
		]
	]
};