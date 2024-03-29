::mods_hookExactClass("skills/backgrounds/hunter_background", function(o) {
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
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.ShortbowClassTree
			],
			Magic = []
		};
	}

	o.getTooltip <- function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gains ranged proficiency faster (+10 chance)"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Free Pathfinder"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusBow", true);

		local items = this.getContainer().getActor().getItems();
		items.equip(::new("scripts/items/weapons/hunting_bow"));
		items.equip(::new("scripts/items/ammo/quiver_of_arrows"));

		if (::Math.rand(0, 1) == 0)
		{
			items.addToBag(::new("scripts/items/weapons/knife"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"ragged_surcoat"
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
			]
		]));

		this.m.Container.add(::new("scripts/skills/traits/_ranged_focus"));
		::Z.Perks.add(this.getContainer().getActor(), ::Const.Perks.PerkDefs.Pathfinder, 0);

	}

	o.onChangeAttributes <- function()
	{
		local c = {
			Hitpoints = [
				0,
				0
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
				0,
				0
			]
		};
		return c;
	}

});

