::mods_hookExactClass("entity/world/attached_location/orchard_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/dried_fruits_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("daytaler_background");
		_list.push("farmhand_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/dried_fruits_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/legend_fresh_fruit_item"
			});
		}
	}

});

