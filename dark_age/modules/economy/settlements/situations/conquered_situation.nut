::mods_hookExactClass("entity/world/settlements/situations/conquered_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.SellPriceMult *= 0.9;
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.6;
		_modifiers.FoodRarityMult *= 0.9;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
	}

});

