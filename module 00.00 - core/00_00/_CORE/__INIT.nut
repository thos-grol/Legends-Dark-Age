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