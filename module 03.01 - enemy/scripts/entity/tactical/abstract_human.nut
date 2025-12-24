this.abstract_human <- this.inherit("scripts/entity/tactical/human", {
	function onInit()
	{
		this.human.onInit();
		if (::Math.rand(0, 3) == 0) { this.setFemale(); }
		else { this.setMale(); }
		this.setAppearance();
	}
	
	function create()
	{
		this.human.create();

		local level = ::B[this.m.Type].Level;
		this.getFlags().set("Level", level);
	}

	function assignRandomEquipment()
	{
		// equips armor
		equip_outfit();

		// equips named gear if champion
		// named armor will overwrite armor
		// named weapon will be flagged for addition later on
		equip_named_gear();

		// equips weapon loadout
		// applies build perks, traits
		// if (is_using_build()) init_build();
		// else init_random();

		post_init();
	}
	
	// Can override setfemale/male if we want southern units etc. Enemy defaults are setMale anyways
	// Defaulting to 1 in 4 chance of female
    function setFemale()
    {
        this.setGender(1);
    }

    function setMale()
    {
		this.setGender(0);
    }
});
