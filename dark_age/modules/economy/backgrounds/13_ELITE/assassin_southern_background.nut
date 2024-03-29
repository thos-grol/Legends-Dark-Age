::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.BowTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,

			],
			Magic = [
				::Const.Perks.AssassinMagicTree
			]
		};


	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 3;
		talents[::Const.Attributes.MeleeDefense] = 3;
		talents[::Const.Attributes.Initiative] = 3;

		local items = this.getContainer().getActor().getItems();
		items.equip(::new("scripts/items/weapons/oriental/qatal_dagger"));


		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/thick_nomad_robe"
			],
			[
				1,
				"oriental/assassin_robe"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/assassin_head_wrap"
			]
		]));
	}

	o.onChangeAttributes = function()
	{
		local c = {
			Hitpoints = [
				15,
				20
			],
			Bravery = [
				20,
				25
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				12,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				20,
				15
			]
		};
		return c;
	}

});

