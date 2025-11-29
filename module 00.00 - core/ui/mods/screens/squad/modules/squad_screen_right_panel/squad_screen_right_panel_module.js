/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			26.05.2017 / Reworked: 26.11.2017
 *  @Description:	Character Right Panel Module JS
 */
"use strict";

var SquadScreenRightPanelModule = function(_parent, _dataSource)
{
    this.mParent = _parent;
    this.mDataSource = _dataSource;

	// container
	this.mContainer = null;

	// modules
	this.mHeaderModule = null;
	this.mInventoryModule = null;
    this.mPerksModule = null;

    this.createModules();
};

SquadScreenRightPanelModule.prototype.createDIV = function (_parentDiv)
{
	// create: container
	this.mContainer = $('<div class="right-panel-module"/>');
    _parentDiv.append(this.mContainer);
};

SquadScreenRightPanelModule.prototype.destroyDIV = function ()
{
    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


SquadScreenRightPanelModule.prototype.createModules = function()
{
	this.mHeaderModule = new SquadScreenRightPanelHeaderModule(this, this.mDataSource);
	this.mInventoryModule = new SquadScreenInventoryListModule(this, this.mDataSource);
    this.mPerksModule = new SquadScreenPerksModule(this, this.mDataSource);
};

SquadScreenRightPanelModule.prototype.registerModules = function ()
{
    this.mHeaderModule.register(this.mContainer);
    this.mInventoryModule.register(this.mContainer);
    this.mPerksModule.register(this.mContainer);

    this.setupEventHandler();
};

SquadScreenRightPanelModule.prototype.unregisterModules = function ()
{
    this.removeEventHandler();

    this.mHeaderModule.unregister();
    this.mInventoryModule.unregister();
    this.mPerksModule.unregister();
};


SquadScreenRightPanelModule.prototype.setupEventHandler = function ()
{
	this.removeEventHandler();

	this.mHeaderModule.setOnSwitchToInventoryCallback(jQuery.proxy(this.switchToInventory, this));
	this.mHeaderModule.setOnSwitchToPerksCallback(jQuery.proxy(this.switchToPerks, this));

	this.mHeaderModule.selectInventoryPanel();
};

SquadScreenRightPanelModule.prototype.removeEventHandler = function ()
{
	this.mHeaderModule.setOnSwitchToInventoryCallback(null);
	this.mHeaderModule.setOnSwitchToPerksCallback(null);
};


SquadScreenRightPanelModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.registerModules();
};

SquadScreenRightPanelModule.prototype.destroy = function()
{
    this.unregisterModules();
    this.destroyDIV();
};


SquadScreenRightPanelModule.prototype.register = function (_parentDiv)
{
    console.log('SquadScreenRightPanelModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Right Panel Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

SquadScreenRightPanelModule.prototype.unregister = function ()
{
    console.log('SquadScreenRightPanelModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Right Panel Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};


SquadScreenRightPanelModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


/*
SquadScreenRightPanelModule.prototype.toggleFilterPanel = function ()
{
	if (this.mInventoryModule.isVisible())
	{
		this.mInventoryModule.toggleFilterPanel();
	}
};
*/

SquadScreenRightPanelModule.prototype.switchToInventory = function ()
{
	this.mPerksModule.hide();
	this.mInventoryModule.show();
};

SquadScreenRightPanelModule.prototype.switchToPerks = function ()
{
    this.mInventoryModule.hide();
    this.mPerksModule.show();
};