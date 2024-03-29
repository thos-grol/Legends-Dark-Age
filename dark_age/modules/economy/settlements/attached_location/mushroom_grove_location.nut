::mods_hookExactClass("entity/world/attached_location/mushroom_grove_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/pickled_mushrooms_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("wildman_background");
		_list.push("wildman_background");
		//_list.push("legend_herbalist_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 20,
				P = 0.9,
				S = "legend_armor/cloth/legend_apron"
			});
			_list.push({
				R = 10,
				P = 0.9,
				S = "weapons/legend_sickle"
			});
			_list.push({
				R = 20,
				P = 0.9,
				S = "supplies/medicine_small_item"
			});

			if (_id == "building.weaponsmith")
			{
				_list.push({
					R = 30,
					P = 1.0,
					S = "weapons/named/legend_named_sickle"
				});
			}
		}
	}

});

