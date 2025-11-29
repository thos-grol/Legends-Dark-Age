// !! For core core stuff, see scripts/config

// Fixes some AI crashes
::Const.AI.ParallelizationMode = false;

//This file hooks the menu state to load things late
::mods_hookExactClass("states/main_menu_state", function (o)
{
    o.post_init <- function()
	{
	}

	local onInit = o.onInit;
	o.onInit <- function()
	{
		onInit();
		post_init();
	}

});