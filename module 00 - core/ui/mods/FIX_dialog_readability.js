WorldEventScreen.prototype.createDIV = function (_parentDiv)
{
	// create: containers (init hidden!)
    this.mContainer = $('<div class="world-event-screen ui-control dialog-modal-background-dark display-none opacity-none"/>');
    _parentDiv.append(this.mContainer);

	// create: dialog
	var dialogLayout = $('<div class="l-dialog-container "/>');
    this.mContainer.append(dialogLayout);
    this.mDialogContainer = dialogLayout.createDialog('', null, '', false, 'dialog-new margin-adjustment');


	// create: character overlays
	this.mCharacterOverlayLeft = $('<div class="world-event-character-left"/>');
	dialogLayout.append(this.mCharacterOverlayLeft);
	this.mCharacterOverlayLeft.createImage('', function (_image)
	{
		_image.centerImageWithinParent(0, 0, 1.0, false);
	}, null, 'display-none');

	this.mCharacterOverlayRight = $('<div class="world-event-character-right"/>');
	dialogLayout.append(this.mCharacterOverlayRight);
	this.mCharacterOverlayRight.createImage('', function (_image)
	{
		_image.centerImageWithinParent(0, 0, 1.0, false);
	}, null, 'display-none');

	this.mOverlayMiddle = $('<div class="world-event-overlay-middle"/>');
	dialogLayout.append(this.mOverlayMiddle);
	this.mOverlayMiddle.createImage('', null, null, 'display-none');

    // create: content
    var content = this.mDialogContainer.findDialogContentContainer();

    // create: list
    var listContainerLayout = $('<div class="l-list-container"/>');
    content.append(listContainerLayout);
    this.mListContainer = listContainerLayout.createList(5, null, true);
    this.mListScrollContainer = this.mListContainer.findListScrollContainer();

    // create :footer button bar
    this.mDialogFooterContainer = $('<div class="l-button-container l-dialog-container-custom"/>');
    this.mContainer.append(this.mDialogFooterContainer);

	 // create: containers
    this.mContentContainer = $('<div class="world-event-content"/>');
    //content.append(this.mContentContainer);
    this.mListScrollContainer.append(this.mContentContainer);

	// create: containers
    this.mButtonContainer = $('<div class="world-event-buttons"/>');
	this.mDialogFooterContainer.append(this.mButtonContainer);

    this.mIsVisible = false;
};

WorldEventScreen.prototype.updateHeader = function (_data)
{
    // if(WorldEventIdentifier.Event.Title in _data && _data['title'] !== null)
    // {
    //     this.mDialogContainer.findDialogTitle().html(_data['title']);
    // }

    if(WorldEventIdentifier.Event.HeaderImagePath in _data && _data['headerImagePath'] !== null)
    {
        this.mDialogContainer.findDialogHeaderImage().attr('src', Path.GFX + _data['headerImagePath']);
    }
};

WorldEventScreen.prototype.renderDescription = function (_data)
{
    if (!('text') in _data || _data['text'] === null)
    {
        console.error('Failed to render event description entry. Reason: No text value was given.');
        return;
    }

    var row = $('<div class="row" id="description-' + _data['id'] + '"/>');
    this.mContentContainer.append(row);

    var description = $('<div class="description text-font-medium font-bottom-shadow font-color-description text-font-medium-dialog"/>');
    row.append(description);

    var parsedDescriptionText = XBBCODE.process({
        text: _data['text'],
        removeMisalignedTags: false,
        addInLineBreaks: true
    });
    
    description.html(parsedDescriptionText.html);
};