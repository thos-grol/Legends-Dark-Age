// hk purpose
// - disable movement fatigue costs, because we can't hook the navigator, and the system is a black
// box. instead we only keep 1 stamina cost for changing z levels.

::Const.Movement.LevelDifferenceFatigueCost = 1;

::Const.DefaultMovementFatigueCost <- [
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
];
::Const.PathfinderMovementFatigueCost <- [
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
];