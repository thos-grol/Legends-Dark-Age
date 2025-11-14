// #0003 - Set up basic World UI
// - remove day circle + speed controls,
// - remove time of day message, just keep day,

var Hide = {
	is_init : false,
};
WorldScreenTopbarDayTimeModule.prototype.onTimeInformation = function (_datasource, _data)
{
	if (_data === undefined || _data === null || typeof(_data) !== "object" ||
		(!(WorldScreenTopbarIdentifier.TimeInformation.Day in _data) || typeof(_data[WorldScreenTopbarIdentifier.TimeInformation.Day]) !== "number") ||
		(!(WorldScreenTopbarIdentifier.TimeInformation.Time in _data) || typeof(_data[WorldScreenTopbarIdentifier.TimeInformation.Time]) !== "string") ||
		(!(WorldScreenTopbarIdentifier.TimeInformation.Degree in _data) || typeof(_data[WorldScreenTopbarIdentifier.TimeInformation.Degree]) !== "number")
		)
	{
		console.error('ERROR: Failed to query time information data. Reason: Invalid result.');
		return;
	}

	this.mDayTimeText.html('Day ' + _data[WorldScreenTopbarIdentifier.TimeInformation.Day]);
};

Hide.WorldScreenTopbarDayTimeModule_createDIV = WorldScreenTopbarDayTimeModule.prototype.createDIV;
WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
{
	Hide.WorldScreenTopbarDayTimeModule_createDIV.call(this, _parentDiv);

	// $(".topbar-daytime-module .image-container").hide();
	// $(".topbar-daytime-module .title-font-small").hide();
	// $(".topbar-daytime-module d").hide();

	
	// $(".topbar-daytime-module .image-container").hide();

	//re-register this listener function once after hooking
	if (!Hide.is_init)
	{
		Hide.is_init = true;

		this.mDataSource.removeListener(WorldScreenTopbarDatasourceIdentifier.TimeInformation.Updated, jQuery.proxy(this.onTimeInformation, this));

		this.mDataSource.addListener(WorldScreenTopbarDatasourceIdentifier.TimeInformation.Updated, jQuery.proxy(this.onTimeInformation, this));
	}

	this.mContainer.find('div').hide(); 
	$('.text-container').show();
	$('.text-container').find('div').show();
}



// WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
// {
// 	var self = this;

// 	// create: containers
// 	this.mContainer = $('<div class="topbar-daytime-module ui-control"></div>');
//     _parentDiv.append(this.mContainer);

// 	var textContainer = $('<div class="text-container"></div>');
// 	this.mContainer.append(textContainer);
// 	var imageContainer = $('<div class="image-container"></div>');
// 	this.mContainer.append(imageContainer);

//     this.mDayTimeText = $('<div class="text title-font-small font-bold font-bottom-shadow font-color-title"></div>');
//     textContainer.append(this.mDayTimeText);

//     this.mDayTimeImage = $('<img/>');
//     this.mDayTimeImage.attr('src', Path.GFX + Asset.IMAGE_DAY_TIME);
//     imageContainer.append(this.mDayTimeImage);

//     /*this.mDayTimeImage.on("click", function ()
//     {
//     	self.notifyBackendPauseButtonPressed();
//     });*/

//     var layout = $('<div class="l-pause-button"/>');
//     this.mContainer.append(layout);
//     this.mTimePauseButton = layout.createImageButton(Path.GFX + Asset.BUTTON_PAUSE_DISABLED, function ()
//     {
//     	self.notifyBackendTimePauseButtonPressed();

//     	self.mTimePauseButton.changeButtonImage(Path.GFX + Asset.BUTTON_PAUSE);
//     	self.mTimeNormalButton.changeButtonImage(Path.GFX + Asset.BUTTON_PLAY_DISABLED);
//     	self.mTimeFastButton.changeButtonImage(Path.GFX + Asset.BUTTON_FAST_FORWARD_DISABLED);
//     }, '', 10);

//     var layout = $('<div class="l-normal-time-button"/>');
//     this.mContainer.append(layout);
//     this.mTimeNormalButton = layout.createImageButton(Path.GFX + Asset.BUTTON_PLAY_DISABLED, function ()
//     {
//     	self.notifyBackendTimeNormalButtonPressed();

//     	self.mTimePauseButton.changeButtonImage(Path.GFX + Asset.BUTTON_PAUSE_DISABLED);
//     	self.mTimeNormalButton.changeButtonImage(Path.GFX + Asset.BUTTON_PLAY);
//     	self.mTimeFastButton.changeButtonImage(Path.GFX + Asset.BUTTON_FAST_FORWARD_DISABLED);
//     }, '', 10);

//     var layout = $('<div class="l-fast-time-button"/>');
//     this.mContainer.append(layout);
//     this.mTimeFastButton = layout.createImageButton(Path.GFX + Asset.BUTTON_FAST_FORWARD_DISABLED, function ()
//     {
//     	self.notifyBackendTimeFastButtonPressed();

//     	self.mTimePauseButton.changeButtonImage(Path.GFX + Asset.BUTTON_PAUSE_DISABLED);
//     	self.mTimeNormalButton.changeButtonImage(Path.GFX + Asset.BUTTON_PLAY_DISABLED);
//     	self.mTimeFastButton.changeButtonImage(Path.GFX + Asset.BUTTON_FAST_FORWARD);
//     }, '', 10);
    
//     this.mPausedDiv = $('<div class="display-none title-font-very-big paused-label font-color-title font-shadow-silhouette">PAUSED</div>');
//     this.mPausedSpacebarDiv = $('<div class="display-none text-font-small paused-spacebar-label font-color-title font-shadow-silhouette">(Press Spacebar)</div>');
// 	_parentDiv.append(this.mPausedDiv);
// 	_parentDiv.append(this.mPausedSpacebarDiv);
// };
