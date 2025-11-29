::mods_hookExactClass("entity/tactical/actor", function(o)
{
    o.post_init <- function(){}

    o.init_build <- function()
	{
		// equip weapons
		equip_weapon();
        
		// add traits and perks
        // init_traits();
        // local trees = init_trees();
		// local build = ::B[this.m.Type].Builds[this.getFlags().get("build_id")];
		// foreach(entry in build.Pattern)
		// {
        //     add_perk(entry, trees);
		// }

		// //build add levelups
		// init_levelups(build.LevelUps);
	}

    o.init_random <- function()
	{
		// equip weapons
		equip_weapon();
        
		// add traits and perks
        // init_traits();
        // local trees = init_trees();
        // foreach(entry in ::B[this.m.Type].Pattern)
		// {
        //     add_perk(entry, trees);
		// }

		// //add level ups
        // //FEATURE_1: random level ups just use secondary and primary traits
		// init_levelups(::B[this.m.Type].LevelUps);
	}

    // =============================================================================================
    // Build - Helpers
    // =============================================================================================

    o.is_using_build <- function()
    {
        local yes = "Builds" in ::B[this.m.Type]
                && "BuildsChance" in ::B[this.m.Type]
                && ::Math.rand(1,100) <= ::B[this.m.Type].BuildsChance;
        
        this.getFlags().set("is_using_build", yes);
        if (yes)
        {
            local build = ::MSU.Table.randValue(::B[this.m.Type].Builds);
            this.getFlags().set("build_id", build.Name);
        }
        return yes;
    }

    o.init_traits <- function()
	{
		if (this.getFlags().get("is_using_build"))
        {
            local build = ::B[this.m.Type].Builds[this.getFlags().get("build_id")];
            foreach(trait in build.Traits)
            {
                ::Legends.Traits.grant(this, trait);
            }
        }
        else
        {
            local max_traits = 2;
            local ids_excluded = {};

            while(max_traits > 0)
            {
                local trait_def = ::MSU.Table.randValue(::DEF.C.Traits_Character);
                local id = ::Legends.Traits.getID(trait_def);

                if (id in ::DEF.C.Traits_AI_Blacklisted) continue;
                if (id in ids_excluded) continue;

                local trait = ::Legends.Traits.grant(this, trait_def);
                foreach(_id in trait.m.Excluded)
                {
                    ids_excluded[_id] <- 0;
                }
                ids_excluded[id] <- 0;
                max_traits--;
            }
        }
        
        if (::Math.rand(1,100) <= 10)
        {
            local lucky = ::Legends.Traits.get(this, ::Legends.Trait.Lucky);
            if (lucky == null)
            {
                ::Legends.Traits.grant(this, ::Legends.Trait.Lucky);
            }
            else
            {
                lucky.upgrade();
            }
        }
	}

    o.init_trees <- function()
	{
		local RET = {
            armor = null,
			weapon = null,
			trait_1 = null,
			trait_2 = null,
		};

		// select armor tree
		local weight_armor = this.getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;

		if (weight_armor <= 20) RET.armor = ::Const.Perks.LightArmorTree.Tree;
        else if (weight_armor <= 40) RET.armor = ::Const.Perks.MediumArmorTree.Tree;
        else RET.armor = ::Const.Perks.HeavyArmorTree.Tree;

        // stop here if is using build
        // other trees will be unused
        if (this.getFlags().get("is_using_build")) return RET;


        // select weapon tree
		local weapon = this.getMainhandItem();
		if (weapon != null && "m" in weapon)
		{
			RET.weapon = ::Z.S.Perks_getWeaponPerkTree(weapon)[0].Tree;
		}

		//select trait trees
        local trait_trees = [];
        for (local i = 0; i < 2; i = ++i)
        {
            local _exclude = [];
            foreach (tt in trait_trees)
            {
                _exclude.push(tt.ID);
            }
            local t = ::Const.Perks.TraitsTrees.get_random(_exclude, this.getFlags(), i);
            trait_trees.push(t);
        }
        RET.trait_1 = trait_trees[0];
		RET.trait_2 = trait_trees[1];

		return RET;
	}

    o.init_levelups <- function(_source)
	{
		//ie. entry = ["Ranged Defense", 9, 1, 3],
        //(_times, _stars_min, _stars_max)
        foreach(entry in _source)
		{
			switch(entry[0])
			{
				case "Health":
				level_health(entry[1], entry[2], entry[3]);
				break;

				case "Fatigue":
				level_endurance(entry[1], entry[2], entry[3]);
				break;

				case "Resolve":
				level_mettle(entry[1], entry[2], entry[3]);
				break;

				case "Initiative":
				level_agility(entry[1], entry[2], entry[3]);
				break;

				case "Melee Skill":
				level_attack(entry[1], entry[2], entry[3]);
				break;

				case "Ranged Skill":
				level_strength(entry[1], entry[2], entry[3]);
				break;

				case "Melee Defense":
				level_defense(entry[1], entry[2], entry[3]);
				break;

				case "Ranged Defense":
				level_instinct(entry[1], entry[2], entry[3]);
				break;
			}
		}
	}

	
    
});