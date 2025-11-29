// hk purpose
// - disable movement fatigue costs, because we can't hook the navigator, and the system is a black
// box. instead we only keep 1 stamina cost for changing z levels.

::m.rawHook("scripts/entity/tactical/actor", function(p) {
	p.getFatigueCosts = function()
	{
		return ::Const.NoMovementFatigueCost;
	}
});