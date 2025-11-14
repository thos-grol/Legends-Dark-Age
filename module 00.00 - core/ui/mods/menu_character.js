CharacterScreen.prototype.createModules = function()
{
	this.mCharacterPanelModule = new CharacterScreenLeftPanelModule(this, this.mDataSource);
	this.mRightPanelModule = new CharacterScreenRightPanelModule(this, this.mDataSource);
	
    this.mBrothersModule = new CharacterScreenBrothersListModule(this, this.mDataSource);

    this.mBrothersModuleStorage = new CharacterScreenBrothersStorageListModule(this, this.mDataSource);
};