// This file defines static functions involving character classes

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

// =========================================================================================
// Main
// =========================================================================================

// called when a class is randomly assigned
// direction 0 - 5 clockwise, 0 being top 

            //       __0___
            //    5 /      \ 1
            //     /        \
            //     \        /
            //    4 \___3__/ 2

// gt.Const.Direction <- {
// 	N = 0,
// 	NE = 1,
// 	SE = 2,
// 	S = 3,
// 	SW = 4,
// 	NW = 5,
// 	COUNT = 6
// };

// returns empty tiles from closest to furthest
// with ZOC data
::Z.S.get_empty_tiles_direction <- function ( _actor, _origin, _direction, _min_distance, _max_distance)
{
    local distance = 0;
    local t = _origin;

    local ret = [];

    while (distance <= _max_distance)
    {
        if (!t.hasNextTile(_direction)) break;
        t = t.getNextTile(_direction)
        distance++;

        if (distance < _min_distance) continue;
        local zocs = t.getZoneOfControlCountOtherThan(_actor.getAlliedFactions());
        if (t.IsEmpty) ret.push({
            _tile = t,
            _zocs = zocs,
            _distance = distance
        });
    }
    return ret;
}

// =========================================================================================
// Helper
// =========================================================================================
