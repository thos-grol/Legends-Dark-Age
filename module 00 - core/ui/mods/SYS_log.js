TacticalScreenTopbarEventLogModule.prototype.createDIV = function (_parentDiv)
{
    this.mMaxVisibleEntries = 150;
	this.mNormalHeight = '13.0rem';

    var grandpa = _parentDiv.parent();
	_parentDiv.css('opacity', '0');

	var newlog = $('<div class="new-log-container"/>');
	grandpa.append(newlog);
	var width = Math.max(200, Math.min(grandpa.parent().width() / 3.5, 800));
	newlog.css('width', width);
	newlog.css('background-size', newlog.width() + " " + newlog.height());
	
	var self = this;

	// create: container
	this.mContainer = $('<div class="topbar-event-log-module"/>');
	newlog.append(this.mContainer);

	// create: log container
	var eventLogsContainerLayout = $('<div class="l-event-logs-container"/>');
	eventLogsContainerLayout.css('width', newlog.width() - 50);

	this.mContainer.append(eventLogsContainerLayout);
	this.mEventsListContainer = eventLogsContainerLayout.createList(15);
	this.mEventsListScrollContainer = this.mEventsListContainer.findListScrollContainer();

	this.mEventsListContainer.css('background-size', newlog.width() - 65, + " " + newlog.height());

	// create: button
	var layout = $('<div class="l-expand-button"/>');
	this.mContainer.append(layout);
	this.ExpandButton = layout.createImageButton(Path.GFX + Asset.BUTTON_OPEN_EVENTLOG, function ()
	{
		self.expand(!self.mIsExpanded);
	}, '', 6);
	//this.ExpandButton.css('z-index', '9999999');
	this.expand(false);
};

TacticalScreenTopbarEventLogModule.prototype.createEventLogEntryDIV = function (_text)
{
	if (_text === null || typeof(_text) != 'string')
	{
		return null;
	}

	var entry = $('<div class="entry font-color-ink"></div>');
	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	entry.html(parsedText.html);
	return entry;
};

TacticalScreenTopbarEventLogModule.prototype.createEventLogEntryDIV_indent = function (_text)
{
	if (_text === null || typeof(_text) != 'string')
	{
		return null;
	}

	var entry = $('<div class="entry2 font-color-ink"></div>');
	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	entry.html(parsedText.html);
	return entry;
};

TacticalScreenTopbarEventLogModule.prototype.createEventLogEntryDIV_title = function (_text)
{
	if (_text === null || typeof(_text) != 'string')
	{
		return null;
	}

	var entry = $('<div class="entry3 font-color-ink"></div>');
	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	entry.html(parsedText.html);
	return entry;
};

TacticalScreenTopbarEventLogModule.prototype.log = function (_text)
{
	var entry = this.createEventLogEntryDIV(_text);
	if (entry !== null)
	{
		this.mEventsListScrollContainer.append(entry);
		//this.mEventsListContainer.scrollListToElement(entry);
		this.mEventsListContainer.scrollListToBottom();
	}
};

TacticalScreenTopbarEventLogModule.prototype.log_indent = function (_text)
{
	var entry = this.createEventLogEntryDIV_indent(_text);
	if (entry !== null)
	{
		this.mEventsListScrollContainer.append(entry);
		//this.mEventsListContainer.scrollListToElement(entry);
		this.mEventsListContainer.scrollListToBottom();
	}
};

TacticalScreenTopbarEventLogModule.prototype.log_title = function (_text)
{
	var entry = this.createEventLogEntryDIV_title(_text);
	if (entry !== null)
	{
		this.mEventsListScrollContainer.append(entry);
		//this.mEventsListContainer.scrollListToElement(entry);
		this.mEventsListContainer.scrollListToBottom();
	}
};