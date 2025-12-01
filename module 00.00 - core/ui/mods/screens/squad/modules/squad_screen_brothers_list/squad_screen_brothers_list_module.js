/*
 *  @Project:	   Battle Brothers
 *  @Company:	   Overhype Studios
 *
 *  @Copyright:	 (c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:		  24.01.2017 / Reworked: 26.11.2017
 *  @Description:   Brothers List Module JS
 */
"use strict";

// =================================================================================================
// DEF
// =================================================================================================

var SquadScreenBrothersListModule = function(_parent, _dataSource)
{
	this.mParent = _parent;
	this.mDataSource = _dataSource;

	// container
	this.mContainer					 	= null;
	this.mListContainer				 	= null;
	this.mListScrollContainer		  	= null;
	this.mListScrollContainer2		  	= null;
	this.mListScrollContainer2_scroll   = null;

	this.mFrontlineCountLabel		   	= null
	this.mFrontlineCountContainer	   	= null;

	this.mRosterCountLabel			  	= null;
	this.mRosterCountContainer		  	= null;

	this.mStartBattleButton			 	= null;
	this.mStartBattleButtonContainer	= null;

	this.CHUNK_SIZE 					= 27;
	this.STORAGE_SIZE 					= 200;
	this.CHUNK_INDEX 					= 0;
	this.CHUNKS 						= 10;
	this.BROTHERS_TEMP					= null; //stores the temporary bro formation list in memory

	this.mSlots						 	= null;
	this.mNumActive					 	= 0;
	this.mNumActiveMax				  	= 27;

	this.IsMoodVisible					= true;

	// this.EMBARK_BUTTON 					= null;

	this.registerDatasourceListener();
};

// =================================================================================================
// Logic
// =================================================================================================

SquadScreenBrothersListModule.prototype.select_squad = function (_index)
{
	this.CHUNK_INDEX = _index - 1;
	this.onBrothersListLoaded(this.mDataSource, this.BROTHERS_TEMP);

	var buttons = $(".squad-panel .l-button .ui-control");
	buttons.each(function(index, element) {
		var $e = $(this);
		$e.removeClass("select");
		if (index === _index - 1) 
		{
			$e.addClass("select");
		}
	  });
}

SquadScreenBrothersListModule.prototype.update_squads = function (squad_state)
{
	var buttons = $(".squad-panel .l-button .ui-control");
	buttons.each(function(index, element) {
		var $e = $(this);
		$e.removeClass("is-locked");
		if (squad_state[index] === 1) 
		{
			$e.addClass("is-locked");
		}
	  });
}

SquadScreenBrothersListModule.prototype.onBrothersListLoaded = function (_dataSource, _brothers)
{
	var self = this;
	this.clearBrothersList();

	if (_brothers === null || !jQuery.isArray(_brothers) || _brothers.length === 0) return;
	this.BROTHERS_TEMP = _brothers;

	// modify styles of squad buttons to reflect occupancy or squad/mission status
	// TODO: after mission, squad will be locked, but yellow - meaning non-hostile lock
	$("div.squad-panel div.ui-control").each(function(index, element) {
		// 'this' refers to the current DOM element in the loop
		// 'element' also refers to the current DOM element
		// 'index' is the zero-based index of the element in the selection

		var lcb = self.get_lcb(index);
		var occupied = false;
		for (var i = lcb[0]; i <= lcb[1]; i++)
		{
			if (_brothers[i] !== null) 
			{
				occupied = true;
				break;
			}
		}
	  
		var $currentElement = $(element); //wrap 'element' with jQuery to use jQuery methods on it
		if (!occupied) $currentElement.addClass('is-not-occupied'); 

		// Example: Get the value of an input field
		// var inputValue = $currentElement.val(); 
	});

	var allowReordering = this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash;


	var logical_chunk_bounds = this.get_logical_chunk_bounds();
	console.log("chunk: " + this.CHUNK_INDEX);
	console.log("logical bounds: " + logical_chunk_bounds);

	// NOTE: _brothers is list of actual formation locations
	// we use j for the ui formation index
	// i represents the storage formation index
	var ui_chunk_index = 0;  // 0-26
	for (var i = logical_chunk_bounds[0]; i <= logical_chunk_bounds[1]; i++)
	{
		var brother = _brothers[i];
		if (brother !== null) 
		{
			console.log("Adding formation bro | logical_chunk_index: " + i + ", ui_chunk_index: " + ui_chunk_index);
			console.log(brother);
			var parent_div = this.mSlots[ui_chunk_index];
			this.addBrotherSlotDIV(parent_div, brother, ui_chunk_index, allowReordering);
		}
		ui_chunk_index++;
	}

	var logical_storage_bounds = this.get_logical_storage_bounds();
	for (var i = logical_storage_bounds[0]; i <= logical_storage_bounds[1]; i++)
	{
		var brother = _brothers[i];
		if (brother !== null) 
		{
			var ui_index = this.storage_logical_to_ui(i);
			console.log("Adding storage bro | logical_index: " + i + ", ui_index: " + ui_index);
			console.log(brother);

			this.addBrotherSlotDIV(this.mSlots[ui_index], brother, ui_index, allowReordering);
		}
	}

	if (!allowReordering)
	{
		this.mListScrollContainer.find('.is-brother-slot').each(function (index, element)
		{
			var slot = $(element);

			if (slot.data('child') == null)
			{
				slot.removeClass('display-block');
				slot.addClass('display-none');
			}
			else
			{
				slot.addClass('is-blocked-slot');
			}
		});
	}
	else
	{
		this.updateBlockedSlots();
	}

	var inventoryMode  = _dataSource.getInventoryMode();
	this.updateBrotherSlotLocks(inventoryMode);
	if (inventoryMode === CharacterScreenDatasourceIdentifier.InventoryMode.Ground) this.setBrotherSlotActive(_dataSource.getSelectedBrother());
	this.updateRosterLabel();
};

	SquadScreenBrothersListModule.prototype.clearBrothersList = function ()
	{
		for(var i=0; i != this.mSlots.length; ++i)
		{
			this.mSlots[i].empty();
			this.mSlots[i].data('child', null);
		}

		this.mNumActive = 0;
	};

	SquadScreenBrothersListModule.prototype.get_logical_chunk_bounds = function()
	{
		return [this.CHUNK_INDEX * this.CHUNK_SIZE, (this.CHUNK_INDEX + 1)  * this.CHUNK_SIZE - 1];
	};

	SquadScreenBrothersListModule.prototype.get_lcb = function(chunk_index)
	{
		return [chunk_index * this.CHUNK_SIZE, (chunk_index + 1)  * this.CHUNK_SIZE - 1];
	};

	SquadScreenBrothersListModule.prototype.get_logical_storage_bounds = function()
	{
		return [this.CHUNK_SIZE * 10, this.CHUNK_SIZE * 10 + this.STORAGE_SIZE - 1];
	};

	SquadScreenBrothersListModule.prototype.get_next_logical_storage_index = function(index)
	{
		var lsb = this.get_logical_storage_bounds();
		var start = index;
		if (start === 0) start = lsb[0];
		for (var i = start; i <= lsb[1]; i++)
		{
			var brother = this.BROTHERS_TEMP[i];
			if (brother === null) return i;
		}
		return null;
	}

	SquadScreenBrothersListModule.prototype.storage_logical_to_ui = function(index)
	{
		// ui storage: [27, 27+200)
		// logical storage: [CHUNKSIZE * 10, CHUNKSIZE * 10 + 200)
		//ie. 270 -> 0 + 27 = 27
		return (index - this.CHUNK_SIZE * this.CHUNKS) + this.CHUNK_SIZE;
	};

	SquadScreenBrothersListModule.prototype.storage_ui_to_logical = function(index)
	{
		// ui storage: [27, 27+200)
		// logical storage: [CHUNKSIZE * 10, CHUNKSIZE * 10 + 200)
		// ie. 27 -> 27 - 27 = 0
		// 0 + 270 = 270
		return (index - this.CHUNK_SIZE) + this.CHUNKS * this.CHUNK_SIZE;
	};

	SquadScreenBrothersListModule.prototype.get_logical_index = function(index)
	{
		// 0-27 is the squad window, use squad index to translate
		// ui formation: [0, 27)
		// logical formation: [0, CHUNKSIZE * 10)
		// ui storage: [27, 27+200)
		// logical storage: [CHUNKSIZE * 10, CHUNKSIZE * 10 + 200)

		if (index < this.CHUNK_SIZE) // if it's a_ui squad
		{
			return this.CHUNK_INDEX * this.CHUNK_SIZE + index;
		}
		else // if it's storage
		{
			return this.storage_ui_to_logical(index);
		}
	};

	SquadScreenBrothersListModule.prototype.clear_squad = function()
	{
		var lcb = this.get_logical_chunk_bounds();
		var ui_chunk_index = 0;  // 0-26
		var lsi = 0;
		for (var i = lcb[0]; i <= lcb[1]; i++)
		{
			var brother = this.BROTHERS_TEMP[i];
			if (brother !== null)
			{
				lsi = this.get_next_logical_storage_index(lsi);
				var ui_storage_index = this.storage_logical_to_ui(lsi);
				if (lsi === null) return;
				this.swapSlots(ui_chunk_index, ui_storage_index);
			}
			ui_chunk_index++;
		}
		// get bro
		// get next open slot in storage, do a swap

	};

SquadScreenBrothersListModule.prototype.addBrotherSlotDIV = function (_parentDiv, _data, ui_index, _allowReordering)
{
	var self = this;
	var screen = $('.character-screen');

	// create: slot & background layer
	var result = _parentDiv.createListBrother(_data[CharacterScreenIdentifier.Entity.Id]);
	result.attr('id', 'slot-index_' + _data[CharacterScreenIdentifier.Entity.Id]);
	result.data('ID', _data[CharacterScreenIdentifier.Entity.Id]);
	result.data('idx', ui_index);
	result.data('inReserves', _data['inReserves']);

	// console.log(result);

	this.mSlots[ui_index].data('child', result);

	if (ui_index < this.CHUNK_SIZE) ++this.mNumActive;
	if (_allowReordering) // drag handler
	{
		result.drag("start", function (ev, dd)
		{
			// build proxy
			var proxy = $('<div class="ui-control brother is-proxy"/>');
			proxy.appendTo(document.body);
			proxy.data('idx', ui_index);
			var imageLayer = result.find('.image-layer:first');
			if (imageLayer.length > 0)
			{
				imageLayer = imageLayer.clone();
				proxy.append(imageLayer);
			}
			$(dd.drag).addClass('is-dragged');
			return proxy;
		}, { distance: 3 });
		result.drag(function (ev, dd)
		{
			$(dd.proxy).css({ top: dd.offsetY, left: dd.offsetX });
		}, { relative: false, distance: 3 });
		result.drag("end", function (ev, dd)
		{
			var drag = $(dd.drag);
			var drop = $(dd.drop);
			var proxy = $(dd.proxy);
			var allowDragEnd = true;
			if (drop.length === 0 || allowDragEnd === false) // not dropped into anything?
			{
				proxy.velocity("finish", true).velocity({ top: dd.originalY, left: dd.originalX },
				{
					duration: 300,
					complete: function ()
					{
						proxy.remove();
						drag.removeClass('is-dragged');
					}
				});
			}
			else
			{
				proxy.remove();
			}
		}, { drop: '.is-brother-slot' });
	}

	// update image & name
	var character = _data[CharacterScreenIdentifier.Entity.Character.Key];
	var imageOffsetX = (CharacterScreenIdentifier.Entity.Character.ImageOffsetX in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetX] : 0);
	var imageOffsetY = (CharacterScreenIdentifier.Entity.Character.ImageOffsetY in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetY] : 0);

	result.assignListBrotherImage(Path.PROCEDURAL + character[CharacterScreenIdentifier.Entity.Character.ImagePath], imageOffsetX, imageOffsetY, 0.66);
	//result.assignListBrotherName(character[CharacterScreenIdentifier.Entity.Character.Name]);
	//result.assignListBrotherDailyMoneyCost(character[CharacterScreenIdentifier.Entity.Character.DailyMoneyCost]);

	if(CharacterScreenIdentifier.Entity.Character.LeveledUp in character 
		&& character[CharacterScreenIdentifier.Entity.Character.LeveledUp] === true)
	{
		result.assignListBrotherLeveledUp();
	}

	/*if(CharacterScreenIdentifier.Entity.Character.DaysWounded in character && character[CharacterScreenIdentifier.Entity.Character.DaysWounded] === true)
	{
		result.assignListBrotherDaysWounded();
	}*/

	if('inReserves' in character && character['inReserves'] && this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash)
	{
		result.showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
	}
	else if('moodIcon' in character && this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash)
	{
		result.showListBrotherMoodImage(this.IsMoodVisible, character['moodIcon']);
	}

	for(var i = 0; i != _data['injuries'].length && i < 3; ++i)
	{
		result.assignListBrotherStatusEffect(_data['injuries'][i].imagePath, _data[CharacterScreenIdentifier.Entity.Id], _data['injuries'][i].id)
	}

	if(_data['injuries'].length <= 2 && _data['stats'].hitpoints < _data['stats'].hitpointsMax)
	{
		result.assignListBrotherDaysWounded();
	}

	result.assignListBrotherClickHandler(function (_brother, _event)
	{
		var data = _brother.data('brother');
		self.mDataSource.selectedBrotherById(data.id);
	});
};

// =================================================================================================
// Logic t2
// =================================================================================================

SquadScreenBrothersListModule.prototype.createBrotherSlots = function (_parentDiv, _parentDiv2)
{
	var self = this;

	this.mSlots = []; //creates ui slots
	for (var i = 0; i < this.CHUNK_SIZE + this.STORAGE_SIZE; i++) {
		this.mSlots.push(null);
	}

	var dropHandler = function (ev, dd)
	{
		var drag = $(dd.drag);
		var drop = $(dd.drop);
		var proxy = $(dd.proxy);

		if (   proxy === undefined 
			|| proxy.data('idx') === undefined 
			|| drop === undefined 
			|| drop.data('idx') === undefined
		) return false;
		

		drag.removeClass('is-dragged');
		if (drag.data('idx') == drop.data('idx')) return false;

		
		if (self.mParent.data_squad_state !== null && self.mParent.data_squad_state[self.CHUNK_INDEX] === 1) return false;

		
		if (self.mNumActive >= self.mNumActiveMax 
			&& drag.data('idx') > 27 && drop.data('idx') <= 27 
			&& self.mSlots[drop.data('idx')].data('child') == null)
		{
			return false;
		}

		// // always keep at least 1 in formation
		// if (self.mNumActive == 1 && drag.data('idx') <= 27 && drop.data('idx') > 27 && self.mSlots[drop.data('idx')].data('child') == null)
		// {
		// 	return false;
		// }

		// do the swapping
		self.swapSlots(drag.data('idx'), drop.data('idx'));
	};

	for (var i = 0; i < this.CHUNK_SIZE + this.STORAGE_SIZE; ++i)
	{
		if(i < this.CHUNK_SIZE)
		{
			this.mSlots[i] = $('<div class="ui-control is-brother-slot is-roster-slot"/>');
			_parentDiv.append(this.mSlots[i]);
		}
		else
		{
			this.mSlots[i] = $('<div class="ui-control is-brother-slot is-reserve-slot"/>');
			_parentDiv2.append(this.mSlots[i]);
		}
		

		this.mSlots[i].data('idx', i);
		this.mSlots[i].data('child', null);
		this.mSlots[i].drop("end", dropHandler);
	}
}

SquadScreenBrothersListModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	if (_brother !== null &&
		CharacterScreenIdentifier.Entity.Id in _brother &&
		CharacterScreenIdentifier.Entity.Character.Key in _brother &&
		CharacterScreenIdentifier.Entity.Character.Name in _brother[CharacterScreenIdentifier.Entity.Character.Key] &&
		CharacterScreenIdentifier.Entity.Character.ImagePath in _brother[CharacterScreenIdentifier.Entity.Character.Key])
	{
		this.updateBrotherSlot(_brother);
	}
};

	SquadScreenBrothersListModule.prototype.updateBrotherSlot = function (_data)
	{
		var check_other_list = false;
		var slot = this.mListScrollContainer.find('#slot-index_' + _data[CharacterScreenIdentifier.Entity.Id] + ':first');
		if (slot.length === 0) check_other_list = true;

		if (check_other_list)
		{
			slot = this.mListScrollContainer2.find('#slot-index_' + _data[CharacterScreenIdentifier.Entity.Id] + ':first');
			if (slot.length === 0) return;
		}

		// update image & name
		var character = _data[CharacterScreenIdentifier.Entity.Character.Key];
		var imageOffsetX = (CharacterScreenIdentifier.Entity.Character.ImageOffsetX in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetX] : 0);
		var imageOffsetY = (CharacterScreenIdentifier.Entity.Character.ImageOffsetY in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetY] : 0);

		slot.assignListBrotherImage(Path.PROCEDURAL + character[CharacterScreenIdentifier.Entity.Character.ImagePath], imageOffsetX, imageOffsetY, 0.66);
		slot.assignListBrotherName(character[CharacterScreenIdentifier.Entity.Character.Name]);
		slot.assignListBrotherDailyMoneyCost(character[CharacterScreenIdentifier.Entity.Character.DailyMoneyCost]);

		if(this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash)
		{
			if(character['inReserves'])
			{
				slot.showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
			}
			else
			{
				slot.showListBrotherMoodImage(this.IsMoodVisible, character['moodIcon']);
			}
		}

		slot.removeListBrotherStatusEffects();

		for (var i = 0; i != _data['injuries'].length && i < 6; ++i)
		{
			slot.assignListBrotherStatusEffect(_data['injuries'][i].imagePath, character[CharacterScreenIdentifier.Entity.Id], _data['injuries'][i].id)
		}

		if (_data['injuries'].length <= 2 && _data['stats'].hitpoints < _data['stats'].hitpointsMax)
		{
			slot.assignListBrotherDaysWounded();
		}

		if (CharacterScreenIdentifier.Entity.Character.LeveledUp in character && character[CharacterScreenIdentifier.Entity.Character.LeveledUp] === false)
		{
			slot.removeListBrotherLeveledUp();
		}

		/*
		var imageContainer = slot.find('.l-brother-slot-image:first');
		if (imageContainer.length > 0)
		{
			var image = imageContainer.find('img:first');
			if (image.length > 0)
			{
				image.attr('src', Path.PROCEDURAL + _brother.character.imagePath);
			}
		}

		// update text
		var textContainer = slot.find('.l-brother-slot-text:first');
		if (textContainer.length > 0)
		{
			textContainer.html(_brother.character.name);
		}
		*/
	};


SquadScreenBrothersListModule.prototype.swapSlots = function (a_ui, b_ui)
{
	// a_ui and b_ui are logical ui indices. get logical indices
	var self = this;
	
	var a_log = this.get_logical_index(a_ui);
	var b_log = this.get_logical_index(b_ui);

	var result = {};
	result.a_ui = a_ui;
	result.b_ui = b_ui;
	result.a_log = a_log;
	result.b_log = b_log;
	console.log(result);

	if(this.mSlots[b_ui].data('child') == null) // dragging into empty slot
	{
		var A_DATA = this.mSlots[a_ui].data('child');
		A_DATA.data('idx', b_ui);
		A_DATA.appendTo(this.mSlots[b_ui]);
		this.mSlots[b_ui].data('child', A_DATA);
		this.mSlots[a_ui].data('child', null);

		if (a_ui < this.CHUNK_SIZE && b_ui >= this.CHUNK_SIZE) --this.mNumActive;
		else if (a_ui >= this.CHUNK_SIZE && b_ui < this.CHUNK_SIZE) ++this.mNumActive;

		this.updateBlockedSlots();
		this.mDataSource.swapBrothers(a_log, b_log);

		// SquadScreenDatasource.prototype.swapBrothers = function (a_ui, b_ui)
		// {
		// 	var tmp = this.mBrothersList[a_ui];
		// 	this.mBrothersList[a_ui] = this.mBrothersList[b_ui];
		// 	this.mBrothersList[b_ui] = tmp;
		// }

		// SquadScreenDatasource.prototype.notifyBackendUpdateRosterPosition = function (_id, _pos)
		// {
		// 	SQ.call(this.mSQHandle, 'onUpdateRosterPosition', [ _id, _pos ]);
		// };

		// function onUpdateRosterPosition( _data )
		// {
		// 	this.Tactical.getEntityByID(_data[0]).setPlaceInFormation(_data[1]);
		// }

		// SquadScreenDatasource.prototype.setSelectedBrotherIndex = function (_rosterPosition, _withoutNotify)
		// {
		// 	this.mSelectedBrotherIndex = _rosterPosition;

		// 	// notify every listener
		// 	if (_withoutNotify === undefined || _withoutNotify !== true)
		// 	{
		// 		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.ListLoaded, this.mBrothersList);
		// 		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Selected, this.getSelectedBrother());
		// 	}
		// };

		// SquadScreenDatasource.prototype.getSelectedBrotherIndex = function ()
		// {
		// 	return this.mSelectedBrotherIndex;
		// };

		this.mDataSource.notifyBackendUpdateRosterPosition(A_DATA.data('ID'), b_log);

		if(this.mDataSource.getSelectedBrotherIndex() == a_log)
		{
			this.mDataSource.setSelectedBrotherIndex(b_log, true);
		}

	}
	else // swapping two full slots
	{
		var A_DATA = this.mSlots[a_ui].data('child');
		var B_DATA = this.mSlots[b_ui].data('child');

		A_DATA.data('idx', b_ui);
		B_DATA.data('idx', a_ui);

		B_DATA.detach();

		A_DATA.appendTo(this.mSlots[b_ui]);
		this.mSlots[b_ui].data('child', A_DATA);

		B_DATA.appendTo(this.mSlots[a_ui]);
		this.mSlots[a_ui].data('child', B_DATA);

		this.mDataSource.swapBrothers(a_log, b_log);
		this.mDataSource.notifyBackendUpdateRosterPosition(A_DATA.data('ID'), b_log);
		this.mDataSource.notifyBackendUpdateRosterPosition(B_DATA.data('ID'), a_log);

		if (this.mDataSource.getSelectedBrotherIndex() == a_log)
		{
			this.mDataSource.setSelectedBrotherIndex(b_log, true);
		}
		else if (this.mDataSource.getSelectedBrotherIndex() == b_log)
		{
			this.mDataSource.setSelectedBrotherIndex(a_log, true);
		}
	}

	if (a_ui < this.CHUNK_SIZE || b_ui < this.CHUNK_SIZE)
	{
		$("div.squad-panel div.ui-control").each(function(index, element) {
			// 'this' refers to the current DOM element in the loop
			// 'element' also refers to the current DOM element
			// 'index' is the zero-based index of the element in the selection
			if (index != self.CHUNK_INDEX) return;
	
			var lcb = self.get_lcb(index);
			var occupied = false;
			for (var i = lcb[0]; i <= lcb[1]; i++)
			{
				if (self.BROTHERS_TEMP[i] !== null) 
				{
					occupied = true;
					break;
				}
			}
		  
			var $currentElement = $(element); //wrap 'element' with jQuery to use jQuery methods on it
			if (!occupied) 
			{
				$currentElement.addClass('is-not-occupied'); 
			}
			else
			{
				$currentElement.removeClass('is-not-occupied'); 
			}
	
			// Example: Get the value of an input field
			// var inputValue = $currentElement.val(); 
		});
	}

	this.updateRosterLabel();
}

// =================================================================================================
// Logic t3
// =================================================================================================

SquadScreenBrothersListModule.prototype.selectBrotherSlot = function (_brotherId)
{
	var slot = this.mListScrollContainer.find('#slot-index_' + _brotherId + ':first');
	if (slot.length > 0)
	{
		slot.addClass('is-selected');
	}

	slot = this.mListScrollContainer2.find('#slot-index_' + _brotherId + ':first');
	if (slot.length > 0)
	{
		slot.addClass('is-selected');
	}
};

SquadScreenBrothersListModule.prototype.setBrotherSlotActive = function (_brother)
{
	if (_brother === null || !(CharacterScreenIdentifier.Entity.Id in _brother))
	{
		return;
	}

	this.removeCurrentBrotherSlotSelection();
	this.selectBrotherSlot(_brother[CharacterScreenIdentifier.Entity.Id]);
};

SquadScreenBrothersListModule.prototype.showBrotherSlotLock = function(_brotherId, _showLock)
{
	var slot = this.mListScrollContainer.find('#slot-index_' + _brotherId + ':first');
	if (slot.length === 0) return;
	slot.showListBrotherLockImage(_showLock);
};

SquadScreenBrothersListModule.prototype.updateBrotherSlotLocks = function(_inventoryMode)
{
	switch(_inventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		{
			var brothersList = this.mDataSource.getBrothersList();
			if (brothersList === null || !jQuery.isArray(brothersList))
			{
				return;
			}

			for (var i = 0; i < brothersList.length; ++i)
			{
				var brother = brothersList[i];
				if (brother !== null && CharacterScreenIdentifier.Entity.Id in brother)
				{
					this.showBrotherSlotLock(brother[CharacterScreenIdentifier.Entity.Id], false);
				}
			}

		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			var brothersList = this.mDataSource.getBrothersList();
			if (brothersList === null || !jQuery.isArray(brothersList))
			{
				return;
			}

			for (var i = 0; i < brothersList.length; ++i)
			{
				var brother = brothersList[i];
				this.showBrotherSlotLock(brother[CharacterScreenIdentifier.Entity.Id], !this.mDataSource.isSelectedBrother(brother));
			}
		} break;
	}

	// start battle button
	switch (_inventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		{
			this.mStartBattleButtonContainer.removeClass('display-none').addClass('display-block');
			break;
		} 
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			this.mStartBattleButtonContainer.removeClass('display-block').addClass('display-none');
			break;
		} 
	}
};

SquadScreenBrothersListModule.prototype.onBrothersSettingsChanged = function (_dataSource, _data)
{
	this.updateRosterLabel(_data);
};

SquadScreenBrothersListModule.prototype.onBrotherSelected = function (_dataSource, _brother)
{
	if (_brother !== null && CharacterScreenIdentifier.Entity.Id in _brother)
	{
		this.removeCurrentBrotherSlotSelection();
		this.selectBrotherSlot(_brother[CharacterScreenIdentifier.Entity.Id]);
	}
};



// =================================================================================================
// Helper
// =================================================================================================



// =================================================================================================
// Unimportant
// =================================================================================================

SquadScreenBrothersListModule.prototype.toggleMoodVisibility = function ()
{
	this.IsMoodVisible = !this.IsMoodVisible;

	for(var i = 0; i < this.mSlots.length; ++i)
	{
		if(this.mSlots[i].data('child') != null)
		{
			if ((this.mSlots[i]).data('child').data('inReserves'))
			{
				this.mSlots[i].data('child').showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
			}
			else 
			{
				this.mSlots[i].data('child').showListBrotherMoodImage(this.IsMoodVisible);
			}
		}
	}

	return this.IsMoodVisible;
};


SquadScreenBrothersListModule.prototype.updateRosterLabel = function (_data)
{
	this.mRosterCountLabel.html('' + this.get_brother_count() + '/' + 120);
	this.mFrontlineCountLabel.html('' + this.mNumActive + '/' + 27);

	this.mParent.update_embark_button_state();
};

	SquadScreenBrothersListModule.prototype.get_brother_count = function ()
	{
		if (this.BROTHERS_TEMP === null) return 0;

		var count = 0;
		for(var i=0; i < this.BROTHERS_TEMP.length; i++)
		{
			var brother = this.BROTHERS_TEMP[i];
			if (brother !== null) count++;
		}
		return count;
	}

// =================================================================================================
// Boilerplate
// =================================================================================================

SquadScreenBrothersListModule.prototype.registerDatasourceListener = function()
{
	//this.mDataSource.addListener(ErrorCode.Key, jQuery.proxy(this.onDataSourceError, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.ListLoaded, jQuery.proxy(this.onBrothersListLoaded, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.SettingsChanged, jQuery.proxy(this.onBrothersSettingsChanged, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));
};

SquadScreenBrothersListModule.prototype.createScrollContainerThing = function (_parentDiv, _mainContainer, _scroll)
{
	_mainContainer.appendTo(_parentDiv);
	_scroll.appendTo(_mainContainer);
	_mainContainer.aciScrollBar({
			delta: 1,
			lineDelay: 0,
			lineTimer: 0,
			pageDelay: 0,
			pageTimer: 0,
			bindKeyboard: false,
			resizable: false,
			smoothScroll: false
   });
}

SquadScreenBrothersListModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers
	this.mContainer = $('<div class="brothers-list-module"/>');
	_parentDiv.append(this.mContainer);

	var listContainerLayout = $('<div class="l-list-container"/>');
	this.mContainer.append(listContainerLayout);
	this.mListScrollContainer = listContainerLayout;

	var listContainerLayout2 = $('<div class="l-list-container2"/>');
	// this.mContainer.append(listContainerLayout2);
	this.mListScrollContainer2 = listContainerLayout2;
	this.mListScrollContainer2_scroll = $('<div class="l-list-container2-scroll"/>');
	this.createScrollContainerThing(this.mContainer, listContainerLayout2, this.mListScrollContainer2_scroll);

	


	this.mFrontlineCountContainer = $('<div class = "frontline-count-container"/>');
	this.mContainer.append(this.mFrontlineCountContainer);
	var frontlineSizeImage = $('<img/>');
	frontlineSizeImage.attr('src', Path.GFX + Legends.ICON_ASSET_FRONTLINE);
	this.mFrontlineCountContainer.append(frontlineSizeImage);
	this.mFrontlineCountLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
	this.mFrontlineCountContainer.append(this.mFrontlineCountLabel);
	this.mFrontlineCountContainer.bindTooltip({ contentType: 'ui-element', elementId: "stash.CurrentRoster" });

	this.mRosterCountContainer = $('<div class="roster-count-container"/>');
	this.mContainer.append(this.mRosterCountContainer);
	var rosterSizeImage = $('<img/>');
	rosterSizeImage.attr('src', Path.GFX + Asset.ICON_ASSET_BROTHERS); // ICON_DAMAGE_DEALT
	this.mRosterCountContainer.append(rosterSizeImage);
	this.mRosterCountLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
	this.mRosterCountContainer.append(this.mRosterCountLabel);
	this.mRosterCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Stash.ActiveRoster });

	// create empty slots
	this.createBrotherSlots(this.mListScrollContainer, this.mListScrollContainer2_scroll);

	// =============================================================================================

	// =============================================================================================

	// start battle
	this.mStartBattleButtonContainer = $('<div class="l-start-battle-button"/>');
	this.mContainer.append(this.mStartBattleButtonContainer);
	this.mStartBattleButton = this.mStartBattleButtonContainer.createTextButton("Start Battle", function ()
	{
		self.mDataSource.notifyBackendStartBattleButtonClicked();
	}, '', 1);

	////////////////////////////////////////////////////////////////////////////////////////////////

	this.mSquadPanel = $('<div class="squad-panel"/>');
	this.mContainer.append(this.mSquadPanel);

	for (var i = 0; i < this.CHUNKS; i++) 
	{
		var button_template = $('<div class="l-button"/>');
		(function(index) { 
			button_template.createTextButton(""+(index+1), function ()
			{
				self.select_squad(index + 1);
			}, '', 3);
		})(i);
		this.mSquadPanel.append(button_template);
	}

	var squad_layout_11 = $('<div class="x-button"/>');
	this.mSquadPanel.append(squad_layout_11);
	this.BUTTON_SQUAD_11 = squad_layout_11.createTextButton("X", function ()
	{
		self.clear_squad();
	}, '', 3);
};

SquadScreenBrothersListModule.prototype.destroyDIV = function ()
{
	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	/*this.mListContainer.destroyList();
	this.mListContainer = null;*/

	this.mListScrollContainer2.empty();
	this.mListScrollContainer2 = null;

	

	this.mSlots = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

SquadScreenBrothersListModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

SquadScreenBrothersListModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};

SquadScreenBrothersListModule.prototype.register = function (_parentDiv)
{
	console.log('SquadScreenBrothersListModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Brothers Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

SquadScreenBrothersListModule.prototype.unregister = function ()
{
	console.log('SquadScreenBrothersListModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Brothers Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

SquadScreenBrothersListModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};

SquadScreenBrothersListModule.prototype.show = function ()
{
	this.mContainer.removeClass('display-none').addClass('display-block');
};

SquadScreenBrothersListModule.prototype.hide = function ()
{
	this.mContainer.removeClass('display-block').addClass('display-none');
};

SquadScreenBrothersListModule.prototype.isVisible = function ()
{
	return this.mContainer.hasClass('display-block');
};

SquadScreenBrothersListModule.prototype.updateBlockedSlots = function ()
{
	var self = this;

	this.mListScrollContainer.find('.is-blocked-slot').each(function (index, element)
	{
		var slot = $(element);
		slot.removeClass('is-blocked-slot');
	});
	   
	this.mListScrollContainer.find('.is-roster-slot').each(function (index, element)
	{
		var slot = $(element);

		if (slot.data('child') != null || self.mNumActive >= self.mNumActiveMax)
		{
		   // slot.addClass('is-blocked-slot');
		}
	});

	this.mListScrollContainer.find('.is-reserve-slot').each(function (index, element)
	{
		var slot = $(element);

		if (slot.data('child') != null)
		{
		   // slot.addClass('is-blocked-slot');
		}
	});
}

SquadScreenBrothersListModule.prototype.removeCurrentBrotherSlotSelection = function ()
{
	this.mListScrollContainer.find('.is-selected').each(function (index, element)
	{
		var slot = $(element);
		slot.removeClass('is-selected');
	});

	this.mListScrollContainer2.find('.is-selected').each(function (index, element)
	{
		var slot = $(element);
		slot.removeClass('is-selected');
	});
};

SquadScreenBrothersListModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode)
{
	this.updateBrotherSlotLocks(_mode);
};

SquadScreenBrothersListModule.prototype.bindTooltips = function ()
{
	
};

SquadScreenBrothersListModule.prototype.unbindTooltips = function ()
{
	
};
