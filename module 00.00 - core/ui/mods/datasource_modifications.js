// Set campaign defaults
CharacterScreenDatasource.prototype.class_button_activate = function ()
{
	var self = this;
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
	this.notifyBackend_class_activate(activeCharacterID, function (data)
	{
		if (data === undefined || data === null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to commit level up stat increase values. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			// find the brother and update him
			if (CharacterScreenIdentifier.Entity.Id in data)
			{
				self.updateBrother(data);
			}
			else
			{
				console.error('ERROR: Failed to commit level up stat increase values. Invalid data result.');
			}
		}
	});
};

CharacterScreenDatasource.prototype.notifyBackend_class_activate = function (_brotherId, _callback)
{
	SQ.call(this.mSQHandle, 'on_class_added', [_brotherId], _callback);
};

CharacterScreenDatasource.prototype.notifyBackend_add_weapon_tree = function (_brotherId, _callback)
{
	var self = this;
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
	SQ.call(this.mSQHandle, 'on_add_weapon_tree', activeCharacterID, function (_data) {
		self.updateBrother(_data);
	});
};