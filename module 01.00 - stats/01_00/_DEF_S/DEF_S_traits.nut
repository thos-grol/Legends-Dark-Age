// This file defines static functions involving travel

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

// =========================================================================================
// Main
// =========================================================================================

//This fn sets primary and secondary trait trees on actors
::Z.S.set_trait_tree <- function ( _actor, _tree_id )
{
    local f = _actor.getFlags();
    if (!f.has("main_trait"))
    {
        f.set("main_trait", _tree_id);
    }
    else if (!f.has("secondary_trait"))
    {
        f.set("secondary_trait", _tree_id);
    }
	return;
}


// =========================================================================================
// Helper
// =========================================================================================
