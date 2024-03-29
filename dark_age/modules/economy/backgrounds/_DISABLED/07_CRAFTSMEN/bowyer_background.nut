//disabled
::mods_hookExactClass("skills/backgrounds/bowyer_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.BowTree,
				::Const.Perks.HammerTree
			],
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/hunting_bow"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/short_bow"));
		}

		items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"apron"
			]
		]));
		local item = ::Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				2,
				""
			]
		]);
		items.equip(item);
	}

});

