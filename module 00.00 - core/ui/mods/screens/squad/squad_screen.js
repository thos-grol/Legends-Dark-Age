/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			24.01.2017 / Reworked: 26.11.2017
 *  @Description:	Character Screen JS
 */
"use strict";

var SquadScreen = function(_isTacticalMode)
{
	MSUUIScreen.call(this);

	this.mSQHandle = null;
	this.mDataSource = new CharacterScreenDatasource(_isTacticalMode);

	// generic containers
	this.mContainer = null;
	this.mBackgroundImage = null;
	this.mCharacterScreenStatuetes = null;
	this.mCharacterScreen = null;
	this.mLeftContentContainer = null;
	this.mRightContentContainer = null;

	// modules
	this.mCharacterPanelModule = null;
	this.mRightPanelModule = null;
	this.mBrothersModule = null;

	this.mPopupDialog = null;


	// contract info display
	this.contract_id = 0;
	this.max_squad_size = 6;
	this.mContractInfoContainer = null;
	this.mInfo_Title = null;
	this.mInfo_Content = null;
	this.mInfo_max_size = null;
	this.mInfo_pay = null;
	this.mInfo_Embark_Button = null;

	this.createModules();
	this.registerDatasourceListener();
};

SquadScreen.prototype = Object.create(MSUUIScreen.prototype);
Object.defineProperty(SquadScreen.prototype, 'constructor', {
    value: SquadScreen,
    enumerable: false,
    writable: true
});


SquadScreen.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

SquadScreen.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
	this.mDataSource.onConnection(this.mSQHandle);

	this.register($('.root-screen'));
};

SquadScreen.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
	this.mDataSource.onDisconnection();

	// remove from DOM as there is no link to a SQ object
	this.unregister();
};


SquadScreen.prototype.onModuleOnConnectionCalled = function (_module)
{
	// check if every module is connected
	/*
	if ((this.mTooltipModule !== null && this.mTooltipModule.isConnected()) )
	{
		this.notifyBackendOnConnected();
	}
	*/
};

SquadScreen.prototype.onModuleOnDisconnectionCalled = function (_module)
{
	// check if every module is disconnected
	/*
	if ((this.mTooltipModule === null && !this.mTooltipModule.isConnected()) )
	{
		this.notifyBackendOnDisconnected();
	}
	*/
};


SquadScreen.prototype.createDIV = function (_parentDiv)
{
	var self = this;
	// create: containers (init hidden!)
	this.mContainer = $('<div class="squad-screen ui-control dialog-modal-background display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	this.mBackgroundImage = this.mContainer.createImage(null, function (_image)
	{
		_image.removeClass('display-none').addClass('display-block');
		_image.fitImageToParent();
	}, function (_image)
	{
		_image.fitImageToParent();
	}, 'display-none');

	this.mCharacterScreenStatuetes = $('<div class="squad-screen-statuetes"/>');
	this.mContainer.append(this.mCharacterScreenStatuetes);

	var parentWidth = this.mContainer.width();
	var parentHeight = this.mContainer.height();
	var width = this.mCharacterScreenStatuetes.width();
	var height = this.mCharacterScreenStatuetes.height();

	if (width > parentWidth)
	{	
		width = width + 32;
		var marginLeft = (parentWidth - width) / 2;

		this.mCharacterScreenStatuetes.css({ 'left': marginLeft, 'margin-left': 0, 'margin-right': 0 });
	}

	if (height > parentHeight)
	{
		height = height + 122;
		var marginTop = (parentHeight - height) / 2;

		this.mCharacterScreenStatuetes.css({ 'top': marginTop, 'margin-top': 0, 'margin_bottom': 0 });
	}

	this.mCharacterScreen = $('<div class="squad-screen-container"/>');
	this.mCharacterScreenStatuetes.append(this.mCharacterScreen);

	this.mLeftContentContainer = $('<div class="l-left-content-container"/>');
	this.mCharacterScreen.append(this.mLeftContentContainer);
	this.mRightContentContainer = $('<div class="l-right-content-container"/>');
	this.mCharacterScreen.append(this.mRightContentContainer);

	this.mContractInfoContainer = $('<div class="contract-info-container"/>');
	this.mCharacterScreen.append(this.mContractInfoContainer);

	this.mInfo_Title = $('<div class="label title-font-big font-bold font-color-brother-name"/>')
		.text('Title');
	this.mContractInfoContainer.append(this.mInfo_Title);

	this.mInfo_Content = $('<div class="content label text-font-normal font-color-white" style=" max-width: 70rem;"/>')
		.text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at pharetra diam. Aenean at leo est. Donec accumsan posuere consequat. Cras dapibus nunc eu tincidunt commodo. Suspendisse eu eros vulputate, euismod dui id, tempus nibh. Pellentesque elementum ultricies mi at elementum. Cras ut nibh quis erat dapibus dapibus id varius arcu. Donec ac elit in lorem eleifend pellentesque a sed tellus. Nulla facilisi. Ut dapibus dolor nec neque pulvinar rutrum. Nullam vitae nisl lorem. Fusce eget volutpat tortor. Suspendisse arcu ligula, sollicitudin at cursus eget, viverra et ante. Mauris feugiat massa nibh, tempus semper nisi mollis eu.')
    this.mContractInfoContainer.append(this.mInfo_Content);

	this.mInfo_max_size = $('<div class="content label text-font-normal font-color-brother-name" style=" max-width: 70rem;"/>')
		.text('Max Size: 6')
    this.mContractInfoContainer.append(this.mInfo_max_size);

	this.mInfo_pay = $('<div class="content label text-font-normal font-color-brother-name" style=" max-width: 70rem;"/>')
		.text('Pay: 600')
    this.mContractInfoContainer.append(this.mInfo_pay);

	this.mInfo_Embark_Button = this.mContractInfoContainer.createTextButton("Embark", function()
	{
		if (self.mSQHandle !== null)
		{
			SQ.call(self.mSQHandle, 'embark', [ self.contract_id, self.mBrothersModule.CHUNK_INDEX ]);
		}
	}, "embark-button", 1);
	this.mContractInfoContainer.hide();
};

SquadScreen.prototype.destroyDIV = function ()
{
	this.mRightContentContainer.empty();
	this.mRightContentContainer = null;
	this.mLeftContentContainer.empty();
	this.mLeftContentContainer = null;

	this.contract_id = 0;
	this.max_squad_size = 6;
	this.mContractInfoContainer.empty();
	this.mContractInfoContainer = null;
	this.mInfo_Title.empty();
	this.mInfo_Title = null;
	this.mInfo_Content.empty();
	this.mInfo_Content = null;
	this.mInfo_max_size.empty();
	this.mInfo_max_size = null;
	this.mInfo_pay.empty();
	this.mInfo_pay = null;
	this.mInfo_Embark_Button.empty();
	this.mInfo_Embark_Button = null;
	
	this.mContractInfoContainer.empty();
	this.mContractInfoContainer = null;


	this.mCharacterScreen.empty();
	this.mCharacterScreen = null;

	this.mBackgroundImage.empty();
	this.mBackgroundImage = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};



SquadScreen.prototype.createModules = function()
{
	this.mCharacterPanelModule = new SquadScreenLeftPanelModule(this, this.mDataSource);
	this.mRightPanelModule = new SquadScreenRightPanelModule(this, this.mDataSource);
	this.mBrothersModule = new SquadScreenBrothersListModule(this, this.mDataSource);
};

SquadScreen.prototype.registerModules = function ()
{
	this.mCharacterPanelModule.register(this.mLeftContentContainer);
	this.mRightPanelModule.register(this.mRightContentContainer);
	this.mBrothersModule.register(this.mRightContentContainer);
};

SquadScreen.prototype.unregisterModules = function ()
{
	this.mCharacterPanelModule.unregister();
	this.mRightPanelModule.unregister();
	this.mBrothersModule.unregister();
};


/*
SquadScreen.prototype.setupEventHandler = function ()
{
	this.mCharacterPanelModule.setupEventHandler();
	this.mRightPanelModule.setupEventHandler();
	this.mBrothersModule.setupEventHandler();
};

SquadScreen.prototype.removeEventHandler = function ()
{
	this.mCharacterPanelModule.removeEventHandler();
	this.mRightPanelModule.removeEventHandler();
	this.mBrothersModule.removeEventHandler();
};
*/

SquadScreen.prototype.registerDatasourceListener = function()
{
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));
};


SquadScreen.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.registerModules();
};

SquadScreen.prototype.destroy = function()
{
	this.unregisterModules();
	this.destroyDIV();
};


SquadScreen.prototype.register = function (_parentDiv)
{
	console.log('SquadScreen::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Character Screen. Reason: Screen is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);

		this.notifyBackendOnConnected();
	}
};

SquadScreen.prototype.unregister = function ()
{
	console.log('SquadScreen::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Character Screen. Reason: Screen is not initialized.');
		return;
	}

	this.notifyBackendOnDisconnected();

	this.destroy();
};


SquadScreen.prototype.showBackgroundImage = function ()
{
	// show background image - Only in Battle Preparation mode
	if (this.mDataSource.getInventoryMode() === CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation)
	{
		//this.mBackgroundImage.attr('src', ''); // NOTE: Reset img src otherwise Chrome will use the cached one..
		this.mBackgroundImage.attr('src', Path.GFX + Asset.BACKGROUND_INVENTORY);
	}
	else
	{
		this.mBackgroundImage.attr('src', ''); // NOTE: Reset img src otherwise Chrome will use the cached one..
		this.mBackgroundImage.removeClass('display-block').addClass('display-none');
	}
};

SquadScreen.prototype.show = function (_data)
{
	var self = this;

	if (_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.mDataSource.loadFromData(_data);
	}
	else
	{
		//this.mDataSource.loadPerkTreesOnce();
		this.mDataSource.loadBrothersList();
		this.mDataSource.loadStashList();
	}

	this.contract_id = 0;
	this.max_squad_size = 6;
	this.mContractInfoContainer.hide();

	if ('squad_state' in _data)
	{
		this.data_squad_state = _data.squad_state;
		console.log(this.data_squad_state);
		//TODO: set squad states
	}

    if ('contract_info' in _data)
	{
		console.log(_data.contract_info);

		// return [
		// 	::Z.T.CONTRACT_INFO_BUFFER.ID, 0
		// 	::Z.T.CONTRACT_INFO_BUFFER.Name, 1
		// 	::Z.T.CONTRACT_INFO_BUFFER.Description, 2
		// 	::Z.T.CONTRACT_INFO_BUFFER.Pay, 3
		// 	::Z.T.CONTRACT_INFO_BUFFER.Bro_Limit, 4
		// ]

		this.contract_id = _data.contract_info[0];
		this.mInfo_Title.text(_data.contract_info[1]);
		this.mInfo_Content.text(_data.contract_info[2]);
		this.mInfo_pay.text("Pay: " + _data.contract_info[3]);
		this.max_squad_size = _data.contract_info[4];
		this.mInfo_max_size.text("Max Party Size: " + _data.contract_info[4]);
		// this.mInfo_Embark_Button = null;
		this.mContractInfoContainer.show();
	}

	var parentWidth = this.mContainer.width();
	var parentHeight = this.mContainer.height();
	var width = this.mCharacterScreenStatuetes.width();
	var height = this.mCharacterScreenStatuetes.height();

	this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
			$(this).removeClass('display-none').addClass('display-block');
			self.notifyBackendOnAnimating();
			self.showBackgroundImage();
		},
		complete: function()
		{
			self.notifyBackendOnShown();
		}
	});
};

SquadScreen.prototype.hide = function ()
{
	var self = this;

	this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
			self.notifyBackendOnAnimating();
		},
		complete: function()
		{
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendOnHidden();
		}
	});
};


SquadScreen.prototype.onInventoryModeUpdated = function (_dataSource, _inventoryMode)
{
	switch(_inventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		{
			this.mCharacterScreen.addClass('is-battle-preparation');
		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			this.mCharacterScreen.removeClass('is-battle-preparation');
		} break;
	}
};


SquadScreen.prototype.getModule = function (_name)
{
	switch(_name)
	{
		case 'DataSource': return this.mDataSource;
		default: return null;
	}
};

SquadScreen.prototype.getModules = function ()
{
	return [
		{ name: 'DataSource', module: this.mDataSource }
	];
};


SquadScreen.prototype.notifyBackendOnConnected = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenConnected');
	}
};

SquadScreen.prototype.notifyBackendOnDisconnected = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenDisconnected');
	}
};

SquadScreen.prototype.notifyBackendOnShown = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenShown');
	}
};

SquadScreen.prototype.notifyBackendOnHidden = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenHidden');
	}
};

SquadScreen.prototype.notifyBackendOnAnimating = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenAnimating');
	}
};


// legends

SquadScreen.prototype.openUrl = function(_data)
{
	if (_data === undefined || _data === null || !jQuery.isArray(_data) || _data.length == 0)
		return;

	openURL(_data[0]);

	if (_data.length > 1 && _data[1] !== undefined && typeof _data[1] == "string")
		this.openPopupDialog(_data[1]);
};

SquadScreen.prototype.openPopupDialog = function(_text)
{
	var self = this;

	this.mPopupDialog = $('.squad-screen').createPopupDialog('Notice', null, null, 'notice-popup-dialog');
	this.mPopupDialog.addPopupDialogOkButton(function(_dialog) {
		self.mPopupDialog = null;
		_dialog.destroyPopupDialog();
	});

	// make the content
	var result = $('<div class="notice-popup-container"/>');
	var row = $('<div class="row"/>');
		row.appendTo(result);

	var label = $('<div class="text-font-normal font-color-label"></div>');
		label.appendTo(row);

	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	label.html(parsedText.html);
	// the end of the content

	this.mPopupDialog.addPopupDialogContent(result);
};



registerScreen("SquadScreen", new SquadScreen());