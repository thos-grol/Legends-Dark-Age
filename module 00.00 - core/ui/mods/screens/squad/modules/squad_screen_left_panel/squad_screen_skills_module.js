/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			24.01.2017 / Reworked: 26.11.2017
 *  @Description:	Skills Module JS
 */
"use strict";


var SquadScreenSkillsModule = function(_parent, _dataSource)
{
    this.mParent = _parent;
    this.mDataSource = _dataSource;

	// container
	this.mContainer = null;
    this.mListContainer = null;
    this.mListScrollContainer = null;

	// skill rows
	this.mActiveSkillsRow = null;
	this.mPassiveSkillsRow = null;
	this.mStatusEffectsRow = null;

    this.registerDatasourceListener();
};


SquadScreenSkillsModule.prototype.createDIV = function (_parentDiv)
{
	// create: containers
	this.mContainer = $('<div class="skills-module"/>');
    _parentDiv.append(this.mContainer);

    var listContainerLayout = $('<div class="l-list-container"/>');
    this.mContainer.append(listContainerLayout);
    this.mListContainer = listContainerLayout.createList(100, null, true);
    this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// create: skills rows
	this.mActiveSkillsRow = $('<div class="skills-row"/>');
	this.mListScrollContainer.append(this.mActiveSkillsRow);
	this.mPassiveSkillsRow = $('<div class="skills-row"/>');
	this.mListScrollContainer.append(this.mPassiveSkillsRow);
	this.mStatusEffectsRow = $('<div class="skills-row"/>');
	this.mListScrollContainer.append(this.mStatusEffectsRow);
};

SquadScreenSkillsModule.prototype.destroyDIV = function ()
{
    this.mActiveSkillsRow.empty();
    this.mActiveSkillsRow.remove();
    this.mActiveSkillsRow = null;

    this.mPassiveSkillsRow.empty();
    this.mPassiveSkillsRow.remove();
    this.mPassiveSkillsRow = null;

    this.mStatusEffectsRow.empty();
    this.mStatusEffectsRow.remove();
    this.mStatusEffectsRow = null;

    this.mListScrollContainer.empty();
    this.mListScrollContainer = null;
    this.mListContainer.destroyList();
    this.mListContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


SquadScreenSkillsModule.prototype.addSkillsDIV = function (_parentDiv, _entityId, _data, _isSkill)
{
    if (_data === undefined ||_data === null || !jQuery.isArray(_data))
    {
        console.log('ERROR: Failed to add Skills. Reason: Invalid data.');
        return;
    }

    if (_data.length > 0)
    {
        var containerLayout = $('<div class="l-skills-group-container"/>');
        var container = $('<div class="l-skill-groups-container"/>');
        containerLayout.append(container);

        for (var i = 0; i < _data.length; ++i)
        {
            if (!(CharacterScreenIdentifier.Skill.Id in _data[i]) || !(CharacterScreenIdentifier.Skill.ImagePath in _data[i]))
            {
                continue;
            }

            var image = $('<img/>');
            image.attr('src', Path.GFX + _data[i].imagePath);
            container.append(image);

            if (_isSkill === true)
            {
                image.bindTooltip({ contentType: 'skill', entityId: _entityId, skillId: _data[i].id });
            }
            else
            {
                image.bindTooltip({ contentType: 'status-effect', entityId: _entityId, statusEffectId: _data[i].id });
            }
        }

        if (container.children().length > 0)
        {
            _parentDiv.append(containerLayout);
        }
    }
};

SquadScreenSkillsModule.prototype.addSkills = function (_parentDiv, _brotherId, _data, _isSkill)
{
    var self = this;

    _parentDiv.empty();
    jQuery.each(CharacterScreenIdentifier.ItemSlot, function (_index, _value)
    {
        if (_value in _data)
        {
            self.addSkillsDIV(_parentDiv, _brotherId, _data[_value], _isSkill);
        }
    });
};


SquadScreenSkillsModule.prototype.registerDatasourceListener = function()
{
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


SquadScreenSkillsModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
};

SquadScreenSkillsModule.prototype.destroy = function()
{
    this.destroyDIV();
};


SquadScreenSkillsModule.prototype.register = function (_parentDiv)
{
    console.log('SquadScreenSkillsModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Skills Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

SquadScreenSkillsModule.prototype.unregister = function ()
{
    console.log('SquadScreenSkillsModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Skills Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};

SquadScreenSkillsModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


SquadScreenSkillsModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	if (this.mDataSource.isSelectedBrother(_brother) && CharacterScreenIdentifier.Entity.Character.Key in _brother)
	{
        this.onBrotherSelected(_dataSource, _brother);
	}
};

SquadScreenSkillsModule.prototype.onBrotherSelected = function (_dataSource, _brother)
{
	if (_brother !== null && CharacterScreenIdentifier.Entity.Id in _brother)
	{
		if (CharacterScreenIdentifier.SkillTypes.ActiveSkills in _brother)
		{
            this.addSkills(this.mActiveSkillsRow, _brother[CharacterScreenIdentifier.Entity.Id], _brother[CharacterScreenIdentifier.SkillTypes.ActiveSkills], true);
		}

		if (CharacterScreenIdentifier.SkillTypes.PassiveSkills in _brother)
		{
            this.addSkills(this.mPassiveSkillsRow, _brother[CharacterScreenIdentifier.Entity.Id], _brother[CharacterScreenIdentifier.SkillTypes.PassiveSkills], false);
		}

		if (CharacterScreenIdentifier.SkillTypes.StatusEffects in _brother)
		{
            this.addSkills(this.mStatusEffectsRow, _brother[CharacterScreenIdentifier.Entity.Id], _brother[CharacterScreenIdentifier.SkillTypes.StatusEffects], false);
		}
	}
};