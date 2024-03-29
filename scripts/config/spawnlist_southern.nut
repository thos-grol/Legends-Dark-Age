local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Southern <- {
	Name = "Southern",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_southern_01",
	MaxR = 560,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Slave,
					MaxR = 100,
					Cost = 7
				},
				{
					Type = ::Const.World.Spawn.Troops.Conscript,
					Cost = 18
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Gunner,
					MinR = 250,
					Cost = 20
				}
			]
		},
		{
			Weight = 6,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Engineer,
					Cost = 10,
					MinR = 250,
					MinGuards = 1,
					MaxGuards = 1,
					MaxGuardsWeight = 100,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.Mortar,
							Cost = 30,
							function Weight( scale )
							{
								return 100;
							}

						}
					]
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Officer,
					MinR = 300,
					Cost = 35
				}
			]
		},
		{
			Weight = 9,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Assassin,
					MinR = 300,
					Cost = 35
				}
			]
		}
	]
};
gt.Const.World.Spawn.CaravanSouthern <- {
	Name = "CaravanSouthern",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "cart_03",
	MaxR = 560,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 3,
			Weight = 30,
			Type = ::Const.World.Spawn.Troops.SouthernDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 62,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Conscript,
					Cost = 20
				}
			]
		},
		{
			Weight = 1,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Mercenary,
					Cost = 30
				}
			]
		},
		{
			Weight = 1,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				}
			]
		},
		{
			Weight = 1,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Officer,
					Cost = 35
				}
			]
		},
	]
};



gt.Const.World.Spawn.Slaves <- {
	Name = "Slaves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_slave_01",
	MaxR = 210,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Slave,
					Cost = 7
				}
			]
		}
	]
};
gt.Const.World.Spawn.NorthernSlaves <- {
	Name = "NorthernSlaves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_slave_01",
	MaxR = 210,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.NorthernSlave,
					Cost = 7
				}
			]
		}
	]
};
gt.Const.World.Spawn.Assassins <- {
	Name = "Assassins",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_southern_01",
	MaxR = 420,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Assassin,
					Cost = 35
				}
			]
		}
	]
};
