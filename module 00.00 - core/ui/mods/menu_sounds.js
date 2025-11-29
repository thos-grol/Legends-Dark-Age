// js logic to hook main menu buttons to register sounds
var hk_btn_sounds = 
{
	mSQHandle : null,
	mModID : "hk_btn_sounds",
    mID : "hk_btn_sounds",
    isConnected : function ()
	{
		return this.mSQHandle !== null;
	},
	onConnection : function (_handle)
	{
		this.mSQHandle = _handle
	},
	onDisconnection : function ()
	{
		this.mSQHandle = null;
	},
	setCallbacks : function(_obj){
		_obj.on("click", function(){
			SQ.call(hk_btn_sounds.mSQHandle, 'onButtonClicked');
		})
		_obj.on("mouseenter", function(){
			SQ.call(hk_btn_sounds.mSQHandle, 'onHover')
		})
	},
	registerMenuButtons : function()
	{
		$('[class*="button"]').each(function(){
			if ($(this).data("SoundRegistered") !== true){
				hk_btn_sounds.setCallbacks($(this));
			}
		})
		Screens.MainMenuScreen.getModule("MainMenuModule").show = hk_btn_sounds.MainMenuScreen_show;
	},
	wrapper : function(_func)
	{
		return function()
		{
			var ret = _func.apply(this, arguments);
			ret.data("SoundRegistered", true);
			hk_btn_sounds.setCallbacks(ret);
			return ret;	
		}
	}
};

$.fn.createTextButton = hk_btn_sounds.wrapper($.fn.createTextButton);
$.fn.createCustomButton = hk_btn_sounds.wrapper($.fn.createCustomButton);
$.fn.createTabTextButton = hk_btn_sounds.wrapper($.fn.createTabTextButton);
$.fn.createImageButton = hk_btn_sounds.wrapper($.fn.createImageButton);

// hk_btn_sounds.MainMenuScreen_show = Screens.MainMenuScreen.getModule("MainMenuModule").show;
// Screens.MainMenuScreen.getModule("MainMenuModule").show = function(_animation)
// {
// 	hk_btn_sounds.registerMenuButtons();
// 	return hk_btn_sounds.MainMenuScreen_show.call(this, _animation);
// }

registerScreen("hk_btn_sounds", hk_btn_sounds);	