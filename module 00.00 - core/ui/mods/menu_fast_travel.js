var hk_screen_fast_travel = function ()
{
	MSUUIScreen.call(this);
	this.mID = "hk_screen_fast_travel";
};

var hk_screen_transition = function ()
{
	MSUUIScreen.call(this);
	this.mID = "hk_screen_transition";
};

// =========================================================================================
// hk_screen_transition
// =========================================================================================
var that = null;
hk_screen_transition.prototype = Object.create(MSUUIScreen.prototype);
Object.defineProperty(hk_screen_transition.prototype, 'constructor', {
	value: hk_screen_fast_travel,
	enumerable: false,
	writable: true
});

hk_screen_transition.prototype.createDIV = function (_parentDiv)
{
	MSUUIScreen.prototype.createDIV.call(this, _parentDiv);
	this.mPopupDialog = null;
	
	this.mContainer = $('<div class="transition-screen dialog-screen ui-control display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
};

hk_screen_transition.prototype.do_transition = function ()
{
	this.show()
	that = this;
	setTimeout(function(){ that.hide() }, 1000);
	setTimeout(function(){ that.transition_callback() }, 1250);
	
};

hk_screen_transition.prototype.transition_callback = function()
{
	SQ.call(Screen_Transition.mSQHandle, 'transition_callback');
};

hk_screen_transition.prototype.destroyDIV = function ()
{
	if (this.mPopupDialog !== null)
	{
		this.mPopupDialog.destroyPopupDialog();
	}
	this.mPopupDialog = null;
	MSUUIScreen.prototype.destroyDIV.call(this);
};


hk_screen_transition.prototype.destroy = function ()
{
	MSUUIScreen.prototype.destroy.call(this);
};

hk_screen_transition.prototype.hide = function()
{
	MSUUIScreen.prototype.hide.call(this);
};

hk_screen_transition.prototype.show = function (_data)
{
	MSUUIScreen.prototype.show.call(this,_data);
};


// =========================================================================================
// hk_screen_fast_travel
// =========================================================================================

hk_screen_fast_travel.prototype = Object.create(MSUUIScreen.prototype);
Object.defineProperty(hk_screen_fast_travel.prototype, 'constructor', {
	value: hk_screen_fast_travel,
	enumerable: false,
	writable: true
});

hk_screen_fast_travel.prototype.createDIV = function (_parentDiv)
{
	MSUUIScreen.prototype.createDIV.call(this, _parentDiv);
	this.mPopupDialog = null;
	
	this.mContainer = $('<div class="fast-travel-screen dialog-screen ui-control display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
};


hk_screen_fast_travel.prototype.ask_travel = function (_immediately)
{
	this.show()
	//$.fn.createPopupDialog = function(_title, _subTitle, _headerImagePath, _classes, _modalBackground)
	// this.mPopupDialog = $('.character-screen').createPopupDialog('Notice', null, null, 'notice-popup-dialog');
	this.mPopupDialog = $('.fast-travel-screen').createPopupDialog('Travel', null, null, 'fast-travel-popup');

	this.mPopupDialog.addPopupDialogOkButton(function (_dialog)
	{
		Screen_Fast_Travel.hide()
		SQ.call(Screen_Fast_Travel.mSQHandle, 'do_travel');
		_dialog.destroyPopupDialog();
	});

	this.mPopupDialog.addPopupDialogCancelButton(function (_dialog)
	{
		Screen_Fast_Travel.hide()
		_dialog.destroyPopupDialog();
	});


	var result = $('<div class="fast-travel-container"/>');

	var textLabel = $('<div class="label text-font-medium font-color-description font-style-normal">You can only travel to settlements within 1 day of walking.</div>');
	result.append(textLabel);

	this.mPopupDialog.addPopupDialogContent(result);
};

hk_screen_fast_travel.prototype.destroy = function ()
{
	MSUUIScreen.prototype.destroy.call(this);
};

hk_screen_fast_travel.prototype.destroyDIV = function ()
{
	if (this.mPopupDialog !== null)
	{
		this.mPopupDialog.destroyPopupDialog();
	}
	this.mPopupDialog = null;
	MSUUIScreen.prototype.destroyDIV.call(this);
};

hk_screen_fast_travel.prototype.hide = function()
{
	MSUUIScreen.prototype.hide.call(this);
};

hk_screen_fast_travel.prototype.show = function (_data)
{
	MSUUIScreen.prototype.show.call(this,_data);
};


var Screen_Fast_Travel = new hk_screen_fast_travel();
registerScreen("hk_screen_fast_travel", Screen_Fast_Travel);

var Screen_Transition = new hk_screen_transition();
registerScreen("hk_screen_transition", Screen_Transition);



