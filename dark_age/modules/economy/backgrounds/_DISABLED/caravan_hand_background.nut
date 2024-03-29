::mods_hookExactClass("skills/backgrounds/caravan_hand_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SpearTree,
				::Const.Perks.ShieldTree
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
		r = ::Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/hatchet"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_leather"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"leather_tunic"
			]
		]));
		local item = ::Const.World.Common.pickHelmet([
			[
				1,
				"headscarf"
			],
			[
				1,
				"open_leather_cap"
			]
		]);
		items.equip(item);
	}

});

