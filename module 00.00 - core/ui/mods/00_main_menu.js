// Set Main Menu Defaults
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