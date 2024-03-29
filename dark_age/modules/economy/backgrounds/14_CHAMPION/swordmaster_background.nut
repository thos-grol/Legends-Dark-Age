//disabled
::mods_hookExactClass("skills/backgrounds/swordmaster_background", function(o) {
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

		if (::Const.DLC.Unhold)
		{
			r = ::Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(::new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(::new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 2)
			{
				items.equip(::new("scripts/items/weapons/fencing_sword"));
			}
		}
		else
		{
			r = ::Math.rand(0, 1);

			if (r == 0)
			{
				items.equip(::new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(::new("scripts/items/weapons/arming_sword"));
			}
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_leather"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic"
			],
			[
				1,
				"padded_surcoat"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				67,
				""
			],
			[
				33,
				"greatsword_hat"
			]
		]));
	}

});

