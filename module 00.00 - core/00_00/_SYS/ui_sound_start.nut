// hk purpose
// - play custom start sound on start or load
::mods_hookExactClass("states/main_menu_state", function (o)
{
	local campaign_menu_module_onStartPressed = o.campaign_menu_module_onStartPressed;
	o.campaign_menu_module_onStartPressed = function(_settings)
	{
		// hk
		// - play custom start sound on start
		::Z.S.play_start();

		// hk end
		campaign_menu_module_onStartPressed(_settings);
	}

	local campaign_menu_module_onLoadPressed = o.campaign_menu_module_onLoadPressed;
	o.campaign_menu_module_onLoadPressed = function(_campaignFileName)
	{
		// hk
		// - play custom start sound on load
		::Z.S.play_start();

		// hk end
		campaign_menu_module_onLoadPressed(_campaignFileName);
	}
});