// Hide.WorldScreenTopbarDayTimeModule_createDIV = WorldScreenTopbarDayTimeModule.prototype.createDIV;
// WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
// {
// 	Hide.WorldScreenTopbarDayTimeModule_createDIV.call(this, _parentDiv);

// 	// $(".topbar-daytime-module .image-container").hide();
// 	// $(".topbar-daytime-module .title-font-small").hide();
// 	// $(".topbar-daytime-module d").hide();

	
// 	// $(".topbar-daytime-module .image-container").hide();

// 	//re-register this listener function once after hooking
// 	if (!Hide.is_init)
// 	{
// 		Hide.is_init = true;

// 		this.mDataSource.removeListener(WorldScreenTopbarDatasourceIdentifier.TimeInformation.Updated, jQuery.proxy(this.onTimeInformation, this));

// 		this.mDataSource.addListener(WorldScreenTopbarDatasourceIdentifier.TimeInformation.Updated, jQuery.proxy(this.onTimeInformation, this));
// 	}

// 	this.mContainer.find('div').hide(); 
// 	$('.text-container').show();
// 	$('.text-container').find('div').show();
// }

NewCampaignMenuModule.prototype.collectSettings = function()
{
	var settings = {};

	settings.companyName			= this.mCompanyName.getInputText();

	settings.banner					= this.mBanners[this.mCurrentBannerIndex];

	settings.combatDifficulty		= 3;
	settings.economicDifficulty		= 3;
	settings.budgetDifficulty		= 3;
	settings.ironman				= false;
	settings.explorationDifficulty	= false;
	settings.lateGameCrisis			= this.mEvil;
	settings.permanentDestruction	= false;
	settings.seed					= this.mSeed.getInputText();

	settings.origin					= this.mScenarios[this.mSelectedScenario].ID;
	return settings;
}