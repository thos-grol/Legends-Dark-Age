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
			try {
				SQ.call(hk_btn_sounds.mSQHandle, 'onButtonClicked');
			} catch (error) {}
		})
		_obj.on("mouseenter", function(){
			try {
				SQ.call(hk_btn_sounds.mSQHandle, 'onHover')
			} catch (error) {}
		})
	},
	wrapper : function(_func)
	{
		return function()
		{
			var ret = _func.apply(this, arguments);
			hk_btn_sounds.setCallbacks(ret);
			return ret;	
		}
	}
};

$.fn.createTextButton = hk_btn_sounds.wrapper($.fn.createTextButton);
$.fn.createCustomButton = hk_btn_sounds.wrapper($.fn.createCustomButton);
$.fn.createTabTextButton = hk_btn_sounds.wrapper($.fn.createTabTextButton);
$.fn.createImageButton = hk_btn_sounds.wrapper($.fn.createImageButton);

registerScreen("hk_btn_sounds", hk_btn_sounds);	