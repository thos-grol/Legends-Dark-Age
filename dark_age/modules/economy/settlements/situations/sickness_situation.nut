::mods_hookExactClass("entity/world/settlements/situations/sickness_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.MedicalPriceMult *= 3.0;
		_modifiers.RecruitsMult *= 0.25;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
	}

});

