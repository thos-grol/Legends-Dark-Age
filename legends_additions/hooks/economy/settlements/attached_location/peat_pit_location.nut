::mods_hookExactClass("entity/world/attached_location/peat_pit_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/peat_bricks_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("daytaler_background");
		_list.push("peddler_background");

		if (_gender)
		{
			_list.push("female_daytaler_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_hoe"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_shovel"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/peat_bricks_item"
			});
		}

		if (_id == "building.specialized_trader")
		{
		}
	}

});