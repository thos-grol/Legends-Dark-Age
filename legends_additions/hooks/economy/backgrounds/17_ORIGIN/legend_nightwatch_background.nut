::mods_hookExactClass("skills/backgrounds/legend_nightwatch_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 1)
		{
			items.equip(this.new(""));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_sling"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				2,
				"aketon_cap"
			]
		]));
	}

});
