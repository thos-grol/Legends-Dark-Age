::mods_hookExactClass("skills/backgrounds/gambler_background", function(o) {
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
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"noble_tunic"
			],
			[
				1,
				"linen_tunic"
			],
			[
				2,
				""
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				3,
				""
			]
		]));
	}

});

