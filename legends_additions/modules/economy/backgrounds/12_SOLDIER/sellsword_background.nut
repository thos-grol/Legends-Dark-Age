::mods_hookExactClass("skills/backgrounds/sellsword_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.CrossbowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"worn_mail_shirt"
			],
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"mail_shirt"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"padded_nasal_helmet"
			],
			[
				1,
				"mail_coif"
			],
			[
				1,
				"closed_mail_coif"
			],
			[
				1,
				"reinforced_mail_coif"
			],
			[
				1,
				"kettle_hat"
			],
			[
				1,
				"padded_kettle_hat"
			],
			[
				1,
				"hood"
			]
		]));
	}

});
