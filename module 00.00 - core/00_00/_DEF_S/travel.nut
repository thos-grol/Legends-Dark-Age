// Defines functions and variables involving travel

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

::Z.T.Travel <- {};
::Z.T.Travel.ID <- null;
::Z.T.Travel.Days <- 0;

::Z.T.Travel.reset <- function()
{
    //#0004 - travel - this resets global variables after travel has finished
	::Z.T.Travel.ID <- null;
	::Z.T.Travel.Days <- 0;
}

// =========================================================================================
// Main
// =========================================================================================

::Z.S.do_travel <- function( _dest )
{
   ::World.State.getPlayer().setPos(_dest.getTile().Pos);
   ::World.setPlayerPos(::World.State.getPlayer().getPos());
   ::World.getCamera().moveTo(_dest);
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.get_distance_by_road <- function( _start, _dest )
{
    local navSettings =::World.getNavigator().createSettings();
    navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost;
    navSettings.RoadMult = 0.2;
    navSettings.RoadOnly = true;
    local path =::World.getNavigator().findPath(_start, _dest, navSettings, 0);

    if (!path.isEmpty()) return path.getSize();
    return _start.getDistanceTo(_dest);
}

::Z.S.get_distance_by_road_days <- function( _numTiles, _speed, _onRoadOnly )
{
    local speed = _speed * ::Const.World.MovementSettings.GlobalMult;

    if (_onRoadOnly) speed = speed * ::Const.World.MovementSettings.RoadMult;
   
    local seconds = _numTiles * 170.0 / speed;
    if (seconds /::World.getTime().SecondsPerDay > 1.0)  seconds = seconds * 1.1;
    return ::Math.max(1, ::Math.round(seconds /::World.getTime().SecondsPerDay));
}

::Z.S.get_settlement_closest <- function () 
{
	local towns = ::World.EntityManager.getSettlements();
	local nearestTown;
	local nearestDist = 9999;
	foreach (t in towns)
	{
		local d = t.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		if (d < nearestDist && t.isAlliedWithPlayer())
		{
			nearestTown = t;
			nearestDist = d;
		}
	}
	return nearestTown;
}

::Z.S.get_settlement_from_name <- function ( _name ) 
{
	local towns = ::World.EntityManager.getSettlements();
	foreach (t in towns)
	{
		if (t.getName() != _name) continue;
        return t;
	}
	return null;
}