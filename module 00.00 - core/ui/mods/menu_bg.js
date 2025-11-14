//Replaces the main menu background screen
MainMenuScreen.prototype.show = function (_animate)
{
	this.mMainMenuModule.showMainMenu(false);
	this.mBackgroundImage.attr('src', Path.GFX + 'ui/screens/dark_age.png');
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.notifyBackendOnShown();
};