::mods_hookExactClass("entity/tactical/actor", function(o)
{
    o.equip_outfit <- function()
	{
        local outfit = ::Const.World.Common.pickOutfit(::B[this.m.Type].Outfit);
        foreach( item in outfit)
        {
            this.m.Items.equip(item);
        }
	}

    o.equip_weapon <- function()
	{
        local loadout = null;
        local is_named = "IsMinibossWeapon" in this.m && this.m.IsMinibossWeapon;

        if (this.getFlags().get("is_using_build"))
        {
            local build = ::B[this.m.Type].Builds[this.getFlags().get("build_id")];
            loadout = (is_named) ? ::MSU.Array.rand(build.NamedLoadout) : ::MSU.Array.rand(build.Loadout);
        }
        else
        {
            loadout = (is_named) ? ::MSU.Array.rand(::B[this.m.Type].NamedLoadout) : ::MSU.Array.rand(::B[this.m.Type].Loadout);
        }

        if (loadout == null) return;
        foreach(item in loadout)
        {
            this.m.Items.equip(::new(item));
        }
        equip_ammo();
	}

	o.equip_named_gear <- function()
	{
		if (!this.m.IsMiniboss)
		{
			this.m.IsMinibossWeapon <- false;
			return;
		}

		local has_loadout = "NamedLoadout" in ::B[this.m.Type];
		local cap = (has_loadout ? 4 : 2);
		local r = ::Math.rand(1, cap);

		//decide what item will be named
		if (r == 1) //helmet
		{
			local named = ::Const.Items.NamedHelmets;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
			this.m.IsMinibossWeapon <- false;
		}
		else if (r == 2) //armor
		{
			local named = ::Const.Items.NamedArmors;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
			this.m.IsMinibossWeapon <- false;
		}
		else
		{
			this.m.IsMinibossWeapon <- true;
		}
	}

    o.equip_ammo <- function()
	{
		local weapon = this.getMainhandItem();
		try {
			if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
				this.m.Items.equip(::new("scripts/items/ammo/powder_bag"));
		} catch (exception){}
	}

});