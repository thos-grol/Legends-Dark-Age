//Disabled
::mods_hookExactClass("skills/backgrounds/legend_inventor_background", function(o) {
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
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"apron"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"mouth_piece"
			],
			[
				1,
				"headscarf"
			]
		]));
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_stick"));
		}
	}

});
