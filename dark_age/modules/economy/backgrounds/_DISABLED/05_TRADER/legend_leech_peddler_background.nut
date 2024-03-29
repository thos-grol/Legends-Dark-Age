::mods_hookExactClass("skills/backgrounds/legend_leech_peddler_background", function(o) {
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
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new(""));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"thick_dark_tunic"
			],
			[
				1,
				"linen_tunic",
				::Math.rand(6, 7)
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				2,
				"feathered_hat"
			],
			[
				3,
				"headscarf"
			]
		]));
	}

});

