::mods_hookExactClass("skills/backgrounds/legend_surgeon_background", function(o) {
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
		r = ::Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/butchers_cleaver"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/vizier_gear"
			],
			[
				2,
				"oriental/cloth_sash"
			],
			[
				3,
				"butcher_apron"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				2,
				""
			],
			[
				1,
				"oriental/vizier_headgear"
			],
			[
				1,
				"oriental/engineer_hat"
			]
		]));
	}

});
