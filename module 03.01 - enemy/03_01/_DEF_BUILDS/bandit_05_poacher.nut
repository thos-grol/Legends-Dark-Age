//Thug
//Lvl 5
::Const.Tactical.Actor.BanditPoacher <- clone ::B.Templates.Human;

::B[::Const.EntityType.BanditPoacher] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 4, 0, 1],
		["Fatigue", 4, 0, 1],
	],
    Trait = [],
    Outfit = [
		[
			1,
			"bandit_poacher_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/short_bow",
		],
		[
			"scripts/items/weapons/legend_sling",
		]
	]
};