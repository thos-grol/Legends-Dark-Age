// js logic to hook main menu buttons to register sounds
var Button_Sounds = 
{
	mSQHandle : null,
	mModID : "mod_button_sounds",
    mID : "mod_button_sounds",
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
			SQ.call(Button_Sounds.mSQHandle, 'onButtonClicked');
		})
		_obj.on("mouseenter", function(){
			SQ.call(Button_Sounds.mSQHandle, 'onHover')
		})
	},
	registerMenuButtons : function()
	{
		$('[class*="button"]').each(function(){
			if ($(this).data("SoundRegistered") !== true){
				Button_Sounds.setCallbacks($(this));
			}
		})
		Screens.MainMenuScreen.getModule("MainMenuModule").show = Button_Sounds.MainMenuScreen_show;
	},
	wrapper : function(_func)
	{
		return function()
		{
			var ret = _func.apply(this, arguments);
			ret.data("SoundRegistered", true);
			Button_Sounds.setCallbacks(ret);
			return ret;	
		}
	}
};

$.fn.createTextButton = Button_Sounds.wrapper($.fn.createTextButton);
$.fn.createCustomButton = Button_Sounds.wrapper($.fn.createCustomButton);
$.fn.createTabTextButton = Button_Sounds.wrapper($.fn.createTabTextButton);
$.fn.createImageButton = Button_Sounds.wrapper($.fn.createImageButton);

Button_Sounds.MainMenuScreen_show = Screens.MainMenuScreen.getModule("MainMenuModule").show;
Screens.MainMenuScreen.getModule("MainMenuModule").show = function(_animation)
{
	Button_Sounds.registerMenuButtons();
	return Button_Sounds.MainMenuScreen_show.call(this, _animation);
}

registerScreen("mod_button_sounds", Button_Sounds);	