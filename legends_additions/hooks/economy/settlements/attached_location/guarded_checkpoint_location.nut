::mods_hookExactClass("entity/world/attached_location/guarded_checkpoint_location.nut", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("deserter_background");
		_list.push("sellsword_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/padded_surcoat"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/gambeson"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/aketon_cap"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "helmets/full_aketon_cap"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/billhook"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/military_cleaver"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_train"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/boar_spear"
			});
			break;

		default:
			switch(_id)
			{
			case "building.specialized_trader":
				break;

			default:
				switch(_id)
				{
				case "building.weaponsmith":
					break;

				default:
					if (_id == "building.armorsmith")
					{
					}
				}
			}
		}
	}

	o.getNewResources = function()
	{
		return 0;
	}

});
