var Mod_Fast_Travel_Screen = function ()
{
	MSUUIScreen.call(this);
	this.mID = "Mod_Fast_Travel_Screen";
};

var Mod_Transition_Screen = function ()
{
	MSUUIScreen.call(this);
	this.mID = "Mod_Transition_Screen";
};

// =========================================================================================
// Mod_Transition_Screen
// =========================================================================================
var that = null;
Mod_Transition_Screen.prototype = Object.create(MSUUIScreen.prototype);
Object.defineProperty(Mod_Transition_Screen.prototype, 'constructor', {
	value: Mod_Fast_Travel_Screen,
	enumerable: false,
	writable: true
});

Mod_Transition_Screen.prototype.createDIV = function (_parentDiv)
{
	MSUUIScreen.prototype.createDIV.call(this, _parentDiv);
	this.mPopupDialog = null;
	
	this.mContainer = $('<div class="transition-screen dialog-screen ui-control display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
};

Mod_Transition_Screen.prototype.do_transition = function ()
{
	this.show()
	that = this;
	setTimeout(function(){ that.hide() }, 1000);
	setTimeout(function(){ that.transition_callback() }, 1250);
	
};

Mod_Transition_Screen.prototype.transition_callback = function()
{
	SQ.call(Screen_Transition.mSQHandle, 'transition_callback');
};

Mod_Transition_Screen.prototype.destroyDIV = function ()
{
	if (this.mPopupDialog !== null)
	{
		this.mPopupDialog.destroyPopupDialog();
	}
	this.mPopupDialog = null;
	MSUUIScreen.prototype.destroyDIV.call(this);
};


Mod_Transition_Screen.prototype.destroy = function ()
{
	MSUUIScreen.prototype.destroy.call(this);
};

Mod_Transition_Screen.prototype.hide = function()
{
	MSUUIScreen.prototype.hide.call(this);
};

Mod_Transition_Screen.prototype.show = function (_data)
{
	MSUUIScreen.prototype.show.call(this,_data);
};


// =========================================================================================
// Mod_Fast_Travel_Screen
// =========================================================================================

Mod_Fast_Travel_Screen.prototype = Object.create(MSUUIScreen.prototype);
Object.defineProperty(Mod_Fast_Travel_Screen.prototype, 'constructor', {
	value: Mod_Fast_Travel_Screen,
	enumerable: false,
	writable: true
});

Mod_Fast_Travel_Screen.prototype.createDIV = function (_parentDiv)
{
	MSUUIScreen.prototype.createDIV.call(this, _parentDiv);
	this.mPopupDialog = null;
	
	this.mContainer = $('<div class="fast-travel-screen dialog-screen ui-control display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
};


Mod_Fast_Travel_Screen.prototype.ask_travel = function (_immediately)
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

Mod_Fast_Travel_Screen.prototype.destroy = function ()
{
	MSUUIScreen.prototype.destroy.call(this);
};

Mod_Fast_Travel_Screen.prototype.destroyDIV = function ()
{
	if (this.mPopupDialog !== null)
	{
		this.mPopupDialog.destroyPopupDialog();
	}
	this.mPopupDialog = null;
	MSUUIScreen.prototype.destroyDIV.call(this);
};

Mod_Fast_Travel_Screen.prototype.hide = function()
{
	MSUUIScreen.prototype.hide.call(this);
};

Mod_Fast_Travel_Screen.prototype.show = function (_data)
{
	MSUUIScreen.prototype.show.call(this,_data);
};


var Screen_Fast_Travel = new Mod_Fast_Travel_Screen();
registerScreen("Mod_Fast_Travel_Screen", Screen_Fast_Travel);

var Screen_Transition = new Mod_Transition_Screen();
registerScreen("Mod_Transition_Screen", Screen_Transition);



