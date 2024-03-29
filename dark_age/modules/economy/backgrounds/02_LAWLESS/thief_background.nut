::mods_hookExactClass("skills/backgrounds/thief_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.DeviousTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,

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
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/dagger"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				1,
				"headscarf"
			]
		]));

		::Z.Perks.add(this.getContainer().getActor(), ::Const.Perks.PerkDefs.QuickHands, 0);
	}

	o.onChangeAttributes <- function()
	{
		local c = {
			Hitpoints = [
				-20,
				-20,
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				40,
				40
			]
		};
		return c;
	}

});

