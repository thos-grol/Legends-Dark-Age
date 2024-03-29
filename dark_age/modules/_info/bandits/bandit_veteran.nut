//Bandit Veteran
//Level 8 Raider template
//raider template, 7 perks
::Const.Tactical.Actor.BanditVeteran <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 10,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.BanditVeteran] <- {
    Level = 8,
    Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 3], //5
        ["D", 6], //6
        ["T", 5], //7
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Ranged Skill", 4, 0, 2],
		["Fatigue", 3, 0, 2],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/legend_infantry_axe"
        ],
        [
        	"scripts/items/weapons/hooked_blade"
        ],
        [
        	"scripts/items/weapons/pike"
        ],
        [
        	"scripts/items/weapons/longaxe"
        ],
        [
        	"scripts/items/weapons/two_handed_wooden_hammer"
        ],
        [
        	"scripts/items/weapons/two_handed_mace"
        ],
        [
        	"scripts/items/weapons/legend_two_handed_club"
        ]
	],
	Builds = {},
	BuildsChance = 50
};

///////
::B.Info[::Const.EntityType.BanditVeteran].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4], //4
        ["scripts/skills/perks/perk_shield_expert"],
        ["D", 6], //6
        ["T", 3], //7
    ],
	LevelUps = [
		["Ranged Defense", 7, 0, 2],
		["Health", 4, 0, 2],
		["Fatigue", 3, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/morning_star",
			"scripts/items/shields/kite_shield"
		],
	]
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["1H Duelist"] <- {
	Name = "1H Duelist",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 1], //5
        ["D", 6], //6
        ["scripts/skills/perks/perk_duelist"], //7
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Ranged Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/boar_spear"
		],
		[
			"scripts/items/weapons/morning_star"
		],
		[
			"scripts/items/weapons/military_cleaver"
		],
	],
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4], //4
        ["scripts/skills/perks/perk_legend_net_casting"],
        ["D", 6], //6
        ["T", 5], //8
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Ranged Skill", 4, 0, 2],
		["Fatigue", 3, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe"
		],
		[
			"scripts/items/weapons/boar_spear"
		],
		[
			"scripts/items/weapons/morning_star"
		],
	],
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["Longsword"] <- {
	Name = "Longsword",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_hold_out"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_reach_advantage"], //7
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Ranged Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_longsword",
		],
	]
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["Chopper"] <- {
	Name = "Chopper",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_strange_strikes"],
		["scripts/skills/perks/perk_duelist"], //7
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Ranged Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_axe"
		],
	]
};