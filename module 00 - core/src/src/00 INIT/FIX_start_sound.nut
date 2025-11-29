// #0000 Implement Button Sound Hooks - Add button click and hover sounds
::Z.S.play_start <- function ()
{
    this.Sound.play("sounds/ui/start.wav", ::Const.Sound.Volume.Inventory * 10);
}

::mods_hookExactClass("states/main_menu_state", function (o)
{
	local campaign_menu_module_onLoadPressed = o.campaign_menu_module_onLoadPressed;
	o.campaign_menu_module_onLoadPressed = function(_campaignFileName)
	{
		::Z.S.play_start();
		campaign_menu_module_onLoadPressed(_campaignFileName);
	}

	local campaign_menu_module_onStartPressed = o.campaign_menu_module_onStartPressed;
	o.campaign_menu_module_onStartPressed = function(_settings)
	{
		::Z.S.play_start();
		campaign_menu_module_onStartPressed(_settings);
	}

});