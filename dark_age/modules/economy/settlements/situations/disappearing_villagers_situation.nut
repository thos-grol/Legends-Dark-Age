::mods_hookExactClass("entity/world/settlements/situations/disappearing_villagers_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RarityMult *= 1.1;
		_modifiers.RecruitsMult *= 0.7;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";


	}

});

