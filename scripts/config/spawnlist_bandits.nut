local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.BanditRoamers <- {
	Name = "BanditRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MinR = 56,
	MaxR = 220,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabble,
					MaxR = 100,
					Cost = 8
				},
			]
		},
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 100,
					Cost = 12
				},
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					MinR = 250,
					Cost = 18
				}
			]
		}
	]
};
gt.Const.World.Spawn.BanditScouts <- {
	Name = "BanditScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MinR = 61,
	MaxR = 340,
	Fixed = [],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					MinR = 160,
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 250,
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 340,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					MinR = 340,
					Cost = 15
				},
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
};

gt.Const.World.Spawn.BanditRaiders <- {
	Name = "BanditRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MinR = 63,
	MaxR = 600,
	Troops = [
		{
			Weight = 54,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 250,
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 500,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 11
				},
				{
					MinR = 250,
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				},
				{
					MinR = 500,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			MinR = 250,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 40,
					Roll = true
				}
			]
		},
	]
};

gt.Const.World.Spawn.BanditDefenders <- {
	Name = "BanditDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MinR = 45,
	MaxR = 600,
	Troops = [
		{
			Weight = 59,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					MinR = 130,
					Cost = 16
				},
				{
					MinR = 320,
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 18,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					MinR = 400,
					Cost = 18
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 4,
			MinR = 500,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditWarlord,
					Cost = 100,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.BanditBoss <- {
	Name = "BanditBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Weight = 1,
			Cost = 25,
			Roll = true
		},
		{
			MinR = 600,
			Weight = 1,
			Type = ::Const.World.Spawn.Troops.BanditWarlord,
			Cost = 50,
			Roll = true
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
					Cost = 20
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					Type = ::Const.World.Spawn.Troops.Necromancer,
					Cost = 50,
					Roll = true
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditWarlord,
					Cost = 50,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.BanditArmy <- {
	Name = "BanditArmy",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MaxR = 1,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.BanditWarlord,
			Weight = 100,
			Cost = 1,
			Roll = true
		}
	],
	MaxR = 12,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = ::Const.World.Spawn.Troops.LegendPeasantMonk,
			Weight = 75,
			Cost = 2
		},
		{
			Type = ::Const.World.Spawn.Troops.BanditVeteran,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = ::Const.World.Spawn.Troops.BanditMarksman,
			Weight = 45,
			Cost = 2
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
					Cost = 20
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.BanditsDisguisedAsDirewolves <- {
	Name = "BanditsDisguisedAsDireWolves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	MinR = 75,
	MaxR = 475,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderWolf,
					Cost = 25
				}
			]
		}
	]
};
gt.Const.World.Spawn.BanditVermes <- {
	Name = "BanditsVermes",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	MaxR = 475,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditVermes,
					Cost = 7
				}
			]
		}
	]
};

gt.Const.World.Spawn.BanditRaidersTown <- {
	Name = "BanditRaidersTown",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 1,
			Weight = 30,
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Cost = 0
		}
	],
	MinR = 63,
	MaxR = 600,
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				}
			]
		}
	]
};

