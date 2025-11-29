/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			26.01.2017 / Reworked: 26.11.2017
 *  @Description:	Character Right Panel Header Module JS
 */
"use strict";

var SquadScreenRightPanelHeaderModule = function(_parent, _dataSource)
{
    this.mParent = _parent;
    this.mDataSource = _dataSource;

	// header: containers
	this.mContainer = null;

	// header: buttons
	//this.mToggleSearchButton = null;
	this.mSwitchToInventoryButton = null;
	this.mSwitchToPerksButton = null;
	this.mCloseButton = null;

	// button: callbacks
	this.mOnToggleFilterCallback = null;
	this.mOnSwitchToInventoryCallback = null;
	this.mOnSwitchToPerksCallback = null;

    this.registerDatasourceListener();
};


SquadScreenRightPanelHeaderModule.prototype.createDIV = function (_parentDiv)
{
    var self = this;

	// create: container
	this.mContainer = $('<div class="right-panel-header-module"/>');
    _parentDiv.append(this.mContainer);

	var leftButtonContainer = $('<div class="buttons-container is-left"/>');
	this.mContainer.append(leftButtonContainer);
	var middleButtonContainer = $('<div class="buttons-container is-middle"/>');
	this.mContainer.append(middleButtonContainer);
	var rightButtonContainer = $('<div class="buttons-container is-right"/>');
	this.mContainer.append(rightButtonContainer);

	// create: buttons
	//this.mToggleSearchButton = this.createImageButtonDIV(leftButtonContainer, 'search-button', Path.GFX + Asset.BUTTON_SEARCH);
    
    var layout = $('<div class="l-button is-inventory"/>');
    middleButtonContainer.append(layout);
    this.mSwitchToInventoryButton = layout.createTabTextButton("Stash", function()
	{
        if (self.mOnSwitchToInventoryCallback !== null && jQuery.isFunction(self.mOnSwitchToInventoryCallback))
        {
            self.mOnSwitchToInventoryCallback();
        }
    }, null, 'tab-button', 7);

    layout = $('<div class="l-button is-perks"/>');
    middleButtonContainer.append(layout);
    this.mSwitchToPerksButton = layout.createTabTextButton("Perks", function()
	{
        if (self.mOnSwitchToPerksCallback !== null && jQuery.isFunction(self.mOnSwitchToPerksCallback))
        {
            self.mOnSwitchToPerksCallback();
        }
    }, null, 'tab-button', 7);

    layout = $('<div class="l-button is-close"/>');
    rightButtonContainer.append(layout);
    this.mCloseButton = layout.createImageButton(Path.GFX + Asset.BUTTON_QUIT, function ()
	{
        self.mDataSource.notifyBackendCloseButtonClicked();
    }, '', 6);
};

SquadScreenRightPanelHeaderModule.prototype.destroyDIV = function ()
{
    this.mSwitchToInventoryButton.remove();
    this.mSwitchToInventoryButton = null;
    this.mSwitchToPerksButton.remove();
    this.mSwitchToPerksButton = null;
    this.mCloseButton.remove();
    this.mCloseButton = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


SquadScreenRightPanelHeaderModule.prototype.registerDatasourceListener = function()
{
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


SquadScreenRightPanelHeaderModule.prototype.bindTooltips = function ()
{
	this.mSwitchToInventoryButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.InventoryButton });
    this.mSwitchToPerksButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.PerksButton });
    this.mCloseButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.CloseButton });
};

SquadScreenRightPanelHeaderModule.prototype.unbindTooltips = function ()
{
	this.mSwitchToInventoryButton.unbindTooltip();
    this.mSwitchToPerksButton.unbindTooltip();
    this.mCloseButton.unbindTooltip();
};


SquadScreenRightPanelHeaderModule.prototype.setOnToggleFilterCallback = function(_callback)
{
	this.mOnToggleFilterCallback = _callback;
};

SquadScreenRightPanelHeaderModule.prototype.setOnSwitchToInventoryCallback = function(_callback)
{
	this.mOnSwitchToInventoryCallback = _callback;
};

SquadScreenRightPanelHeaderModule.prototype.setOnSwitchToPerksCallback = function(_callback)
{
	this.mOnSwitchToPerksCallback = _callback;
};


SquadScreenRightPanelHeaderModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

SquadScreenRightPanelHeaderModule.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


SquadScreenRightPanelHeaderModule.prototype.register = function (_parentDiv)
{
    console.log('SquadScreenRightPanelHeaderModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Right Panel Header Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

SquadScreenRightPanelHeaderModule.prototype.unregister = function ()
{
    console.log('SquadScreenRightPanelHeaderModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Right Panel Header Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};

SquadScreenRightPanelHeaderModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


SquadScreenRightPanelHeaderModule.prototype.toggleFilterPanel = function ()
{
	if (this.mOnToggleFilterCallback !== null) {
		this.mOnToggleFilterCallback();
	}
};

SquadScreenRightPanelHeaderModule.prototype.selectInventoryPanel = function ()
{
    try {
        this.mSwitchToInventoryButton.selectTabTextButton(true);
    } catch (error) { }
};

SquadScreenRightPanelHeaderModule.prototype.selectPerksPanel = function ()
{
    this.mSwitchToPerksButton.selectTabTextButton(true);
};


SquadScreenRightPanelHeaderModule.prototype.updateButtonsByBrother = function (_brother)
{
    var perkPoints = this.mDataSource.getBrotherPerkPoints(_brother);
    if (perkPoints > 0)
    {
        this.mSwitchToPerksButton.findButtonText().html('Perks (<span class="font-bold font-color-positive-value">' + perkPoints + '</span>)');
    }
    else
    {
        this.mSwitchToPerksButton.findButtonText().html('Perks');
    }
};

SquadScreenRightPanelHeaderModule.prototype.updateButtonsByInventoryMode = function (_inventoryMode)
{
    switch(_inventoryMode)
    {
        case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
        case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
        {
            this.mSwitchToInventoryButton.findButtonText().html('Stash');
        } break;
        case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
        {
            this.mSwitchToInventoryButton.findButtonText().html('Ground');
        } break;
    }
};


SquadScreenRightPanelHeaderModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode)
{
    this.updateButtonsByInventoryMode(_mode);
};

SquadScreenRightPanelHeaderModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	this.onBrotherSelected(_dataSource, _brother);
};

SquadScreenRightPanelHeaderModule.prototype.onBrotherSelected = function (_dataSource, _brother)
{
	if (_brother !== null)
    {
        this.updateButtonsByBrother(_brother);
    }
};

