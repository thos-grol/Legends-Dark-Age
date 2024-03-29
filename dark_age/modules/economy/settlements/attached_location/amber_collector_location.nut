::mods_hookExactClass("entity/world/attached_location/amber_collector_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/amber_shards_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (!this.isActive()) return;
		_list.push("thief_background");
		_list.push("thief_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
			case "building.marketplace":
				_list.push({
					R = 0,
					P = 1.0,
					S = "trade/amber_shards_item"
				});
			break;
		}
	}

});
