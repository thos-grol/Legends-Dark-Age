//This file defines static functions involving ui transitions
// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================
::Z.T.UI <- {};
::Z.T.UI.transition_callback <- null;
::Z.T.UI.deleted_keybinds <- false;


::Z.T.UI.keybinds_to_remove <- {
	"world_pause" : "space",
};


// Main
// =========================================================================================

::Z.S.transition <- function (_fn) 
{
	if (_fn != null) 
	{
		::Z.T.UI.transition_callback <- _fn;
	}
	::Z.Screen.Transition.transition();
}

::Z.S.transition_callback <- function () 
{
	if (::Z.T.UI.transition_callback != null) 
	{
		::Z.T.UI.transition_callback();
		::Z.T.UI.transition_callback <- null;
	}
	// after the event stack is empty, then travel if id is loaded
	if (::Z.T.Travel.ID != null)
	{
		::World.State.do_travel();
	}
}

::Z.S.del_msu_keybinds <- function () 
{
	if (::Z.T.UI.deleted_keybinds) return;

	// display all keybinds to debug
	// foreach (k, v in ::MSU.System.Keybinds.KeybindsByKey) 
	// {
		
	// 	::logInfo(k);
	// 	::MSU.Log.printData( v, 2);
	// 	// ::logInfo(v["ID"]);
	// }

	// find and destroy
	foreach (keybind_id, key in ::Z.T.UI.keybinds_to_remove) 
	{
		local target_idx = 0;
		foreach (k, v in ::MSU.System.Keybinds.KeybindsByKey[key]) 
		{
			if (v["ID"] == keybind_id) break;
			target_idx++;
		}

		::MSU.System.Keybinds.KeybindsByKey[key].remove(target_idx);
		target_idx = 0;
	}

	::Z.T.UI.deleted_keybinds <- true;
}

// =========================================================================================
// Helper
// =========================================================================================
