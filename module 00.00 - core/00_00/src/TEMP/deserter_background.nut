::mods_hookExactClass("skills/backgrounds/deserter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::new("scripts/items/weapons/militia_spear"));

		r = ::Math.rand(0, 3);
		if (r == 0)
		{
			items.equip(::new("scripts/items/shields/wooden_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"padded_surcoat"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				2,
				""
			]
		]));
	}

	// o.onChangeAttributes <- function()
	// {
	// 	local c = {
	// 		Hitpoints = [0,0],
	// 		Bravery = [0,0],
	// 		Stamina = [0,0],
	// 		MeleeSkill = [0,0],
	// 		RangedSkill = [0,0],
	// 		MeleeDefense = [0,0],
	// 		RangedDefense = [0,0],
	// 		Initiative = [0,0]
	// 	};
	// 	return c;
	// }
});
