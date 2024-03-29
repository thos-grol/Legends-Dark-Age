::mods_hookExactClass("entity/world/attached_location/militia_trainingcamp_oriental_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/ammo_small_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (!this.isActive()) return;
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/oriental/padded_vest"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/oriental/spiked_skull_cap_with_mail"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/oriental/southern_light_shield"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "weapons/oriental/saif"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/scimitar"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/oriental/light_southern_mace"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "supplies/ammo_small_item"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 60,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "legend_armor/tabard/legend_southern_tabard"
			});
		}
	}

	o.getNewResources = function()
	{
		return 0;
	}

});

