::mods_hookExactClass("skills/backgrounds/anatomist_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.BowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r <= 2)
		{
			items.equip(::new("scripts/items/weapons/dagger"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/butchers_cleaver"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				2,
				"undertaker_apron"
			],
			[
				2,
				"wanderers_coat"
			],
			[
				1,
				"reinforced_leather_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				2,
				"undertaker_hat"
			],
			[
				2,
				"physician_mask"
			],
			[
				1,
				"masked_kettle_helmet"
			]
		]));
	}

});

