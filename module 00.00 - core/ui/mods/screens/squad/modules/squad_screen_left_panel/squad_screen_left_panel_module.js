/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			24.05.2017 / Reworked: 26.11.2017
 *  @Description:	Left Panel Module JS
 */
"use strict";


var SquadScreenLeftPanelModule = function(_parent, _dataSource)
{
    this.mParent = _parent;
    this.mDataSource = _dataSource;

	// container
	this.mContainer = null;

	// modules
	this.mHeaderModule = null;
	this.mPaperdollModule = null;
	this.mSkillsModule = null;
	this.mStatsModule = null;

    this.createModules();
};

SquadScreenLeftPanelModule.prototype.createDIV = function (_parentDiv)
{
	this.mContainer = $('<div class="left-panel-module"/>');
    _parentDiv.append(this.mContainer);
};

SquadScreenLeftPanelModule.prototype.destroyDIV = function ()
{
    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


SquadScreenLeftPanelModule.prototype.createModules = function()
{
	this.mCharacterPanelHeaderModule = new SquadScreenLeftPanelHeaderModule(this, this.mDataSource);
	this.mPaperdollModule = new SquadScreenPaperdollModule(this, this.mDataSource);
	this.mSkillsModule = new SquadScreenSkillsModule(this, this.mDataSource);
	this.mStatsModule = new SquadScreenStatsModule(this, this.mDataSource);
};

SquadScreenLeftPanelModule.prototype.registerModules = function ()
{
    this.mCharacterPanelHeaderModule.register(this.mContainer);
    this.mPaperdollModule.register(this.mContainer);
    this.mSkillsModule.register(this.mContainer);
    this.mStatsModule.register(this.mContainer);
};

SquadScreenLeftPanelModule.prototype.unregisterModules = function ()
{
    this.mCharacterPanelHeaderModule.unregister();
    this.mPaperdollModule.unregister();
    this.mSkillsModule.unregister();
    this.mStatsModule.unregister();
};


/*
SquadScreenLeftPanelModule.prototype.setupEventHandler = function ()
{
	this.removeEventHandler();

	this.mCharacterPanelHeaderModule.setupEventHandler();
	this.mPaperdollModule.setupEventHandler();
	this.mSkillsModule.setupEventHandler();
	this.mStatsModule.setupEventHandler();
};

SquadScreenLeftPanelModule.prototype.removeEventHandler = function ()
{
	this.mCharacterPanelHeaderModule.removeEventHandler();
	this.mPaperdollModule.removeEventHandler();
	this.mSkillsModule.removeEventHandler();
	this.mStatsModule.removeEventHandler();
};
*/


SquadScreenLeftPanelModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.registerModules();
};

SquadScreenLeftPanelModule.prototype.destroy = function()
{
    this.unregisterModules();
    this.destroyDIV();
};


SquadScreenLeftPanelModule.prototype.register = function (_parentDiv)
{
    console.log('SquadScreenLeftPanelModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Left Panel Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

SquadScreenLeftPanelModule.prototype.unregister = function ()
{
    console.log('SquadScreenLeftPanelModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Left Panel Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};

SquadScreenLeftPanelModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};