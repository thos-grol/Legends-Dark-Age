::mods_hookExactClass("entity/world/settlements/buildings/blackmarket_building", function(o) {

    o.onUpdateShopList = function()
	{
		local list = [
			// {
			// 	R = 50,
			// 	P = 1.0,
			// 	S = "loot/gemstones_item"
			// },
			{
				R = 60,
				P = 2.0,
				S = "misc/scroll"
			},
			{
				R = 60,
				P = 2.0,
				S = "misc/scroll"
			},
			{
				R = 60,
				P = 1.0,
				S = "misc/potion_of_oblivion_item"
			},
			{
				R = 60,
				P = 1.0,
				S = "misc/potion_of_oblivion_fake_item"
			},
			{
				R = 60,
				P = 1.0,
				S = "misc/potion_of_oblivion_fake_item"
			},
			{
				R = 60,
				P = 2.0,
				S = "misc/tome"
			},

			{
				R = 80,
				P = 2.0,
				S = "misc/anatomist/mage_winter_potion_item"
			},
			{
				R = 80,
				P = 2.0,
				S = "misc/anatomist/nachzehrer_potion_item"
			},
			{
				R = 80,
				P = 2.0,
				S = "misc/anatomist/direwolf_potion_item"
			},

			{
				R = 80,
				P = 2.0,
				S = "accessory/ring/cloranthy_ring"
			},
			{
				R = 80,
				P = 2.0,
				S = "accessory/ring/master_ring"
			},
			{
				R = 80,
				P = 2.0,
				S = "accessory/ring/executioner_ring"
			},
			{
				R = 80,
				P = 2.0,
				S = "accessory/ring/slyph_ring"
			},




			{
				R = 0,
				P = 1.0,
				S = "misc/happy_powder_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "misc/happy_powder_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "misc/happy_powder_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "misc/happy_powder_item"
			},


			{
				R = 40,
				P = 1.0,
				S = "ammo/large_quiver_of_bolts"
			},
			{
				R = 40,
				P = 1.0,
				S = "ammo/huge_quiver_of_bolts"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/light_crossbow"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/crossbow"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/heavy_crossbow"
			},

			{
				R = 40,
				P = 1.0,
				S = "ammo/large_powder_bag"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/handgonne"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/named/named_handgonne"
			},
		];

		foreach( i in ::Const.Items.NamedMeleeWeapons )
		{
			if (::Math.rand(1, 100) <= 25)
			{
				list.push({
					R = 60,
					P = 1.0,
					S = i
				});
			}
		}

		foreach( i in ::Const.Items.NamedRangedWeapons )
		{
			if (::Math.rand(1, 100) <= 25)
			{
				list.push({
					R = 60,
					P = 1.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, false);
	}

});