::mods_hookExactClass("entity/world/attached_location/brewery_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/beer_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("monk_background");
		_list.push("brawler_background");
		_list.push("gambler_background");

		if (_gender)
		{
			_list.push("legend_nun_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/beer_item"
			});
			break;

		default:
			if (_id == "building.specialized_trader")
			{
			}
		}
	}

});
