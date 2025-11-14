//This replaces randomized unit abstract
::mods_hookExactClass("entity/tactical/legend_randomized_unit_abstract", function(o)
{
    o.onInit <- function()
	{
		this.human.onInit();
		if (::Math.rand(0, 3) == 0) { this.setFemale(); }
		else { this.setMale(); }
		this.setAppearance();
	}

    o.create <- function()
	{
		this.human.create();

		local level = ::B[this.m.Type].Level;
		this.getFlags().set("Level", level);
		// this.m.XP = level * 25;
	}

    o.assignRandomEquipment <- function()
	{
		// equips armor
		equip_outfit();

		// equips named gear if champion
		// named armor will overwrite armor
		// named weapon will be flagged for addition later on
		equip_named_gear();

		// equips weapon loadout
		// applies build perks, traits
		if (is_using_build()) init_build();
		else init_random();

		post_init();
	}

});