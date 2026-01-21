::mods_hookExactClass("entity/tactical/actor", function(o)
{
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		local c = this.getSkills();
		// hk - add character system
		c.add(this.new("scripts/skills/special/log_system"));
		c.add(this.new("scripts/skills/special/character_system"));
		c.add(this.new("scripts/skills/special/bag_system"));
	}
});

::mods_hookExactClass("entity/tactical/human", function(o)
{
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		local c = this.getSkills();
		c.removeByID("actives.hand_to_hand");
		::Legends.Actives.grant(this, ::Legends.Active.H2H);
	}
});

::mods_hookExactClass("entity/tactical/player", function (o){

	//hk - we add system/monitoring skills to character here
	o.onInit = function ()
	{
		this.human.onInit();

		local c = this.getSkills();
		c.add(this.new("scripts/skills/special/stats_collector"));
		c.add(this.new("scripts/skills/special/mood_check"));
		c.add(this.new("scripts/skills/special/weapon_breaking_warning"));
		c.add(this.new("scripts/skills/special/no_ammo_warning"));
		c.add(this.new("scripts/skills/effects/battle_standard_effect"));
		c.add(this.new("scripts/skills/actives/break_ally_free_skill"));
		c.add(this.new("scripts/skills/special/c_system"));

		if (this.Const.DLC.Unhold)
		{
			c.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.setFaction(this.Const.Faction.Player);
		this.m.Items.setUnlockedBagSlots(2);
		c.add(this.new("scripts/skills/special/bag_fatigue"));

		// hk - add legends stuff we want to keep
		::Legends.Effects.grant(this, ::Legends.Effect.LegendRealmOfNightmares);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendGrapple);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendKick);
		this.setDiscovered(true);
	}

	// sets up character's stats, traits, and perks
	o.setStartValuesEx <- function ( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		local background = init_background(_backgrounds, _gender);
		
		// hk - Add traits before trees, so traits can determine trait trees.
		if (_addTraits) pick_traits(background);

		// build perk trees
		local attributes = background.buildPerkTree();
		this.m.StarWeights = background.buildAttributes(null, attributes);
		background.buildDescription();

		// add equipment?
		if (_addEquipment) background.addEquipment();
		
		// other setuo
		if (this.getFlags().has("PlayerZombie")) background.setAppearance("zombie");
		else if (this.getFlags().has("PlayerSkeleton")) background.setAppearance("skeleton");
		else background.setAppearance();

		background.buildDescription(true);
		this.m.Skills.update();

		local p = this.m.CurrentProperties;
		this.m.Hitpoints = p.Hitpoints;

		if (_addTraits)
		{
			this.fillTalentValues(3);
            if (this.m.Attributes.len() == 0)
            {
                this.m.Attributes.resize(::Const.Attributes.COUNT);
                for( local i = 0; i != ::Const.Attributes.COUNT; i = ++i )
                {
                    this.m.Attributes[i] = [];
                }
            }
		}
	}


	// 	// =========================================================================================
	// 	// Helper fns
	// 	// =========================================================================================

	o.init_background <- function(_backgrounds, _gender = -1)
	{
		local background = ::new("scripts/skills/backgrounds/" + ::MSU.Array.rand(_backgrounds));
		background.setGender(_gender);
		local c = this.getSkills();
		c.add(background);

		background.buildDescription();
		this.setGender((background.isBackgroundType(::Const.BackgroundType.Female) ? 1 : 0));
		
		return background;
	}

	o.pick_traits <- function(_background)
	{
		local max_traits = 2;
		
		// add guaranteed traits
		if (_background.m.IsGuaranteed.len() > 0)
		{
			max_traits = max_traits - _background.m.IsGuaranteed.len();
			foreach(trait_id in _background.m.IsGuaranteed)
			{
				local trait_def = ::DEF.C.map_ids_traits[trait_id];
				::Legends.Traits.grant(this, trait_def);
			}
		}

		if(max_traits <= 0) return;
		
		// roll random traits
		local traits_filtered = [];
		foreach(trait_def in ::DEF.C.Traits_Character)
		{
			if (_background.isExcluded(::Legends.Traits.getID(trait_def))) continue;
			traits_filtered.push(trait_def);
			// try 
			// {
			// 	if (_background.isExcluded(::Legends.Traits.getID(trait_def))) continue;
			// 	traits_filtered.push(trait_def);
			// }
			// catch(exception)
			// {
			// 	::MSU.Log.printData( trait_def, 2);
			// 	throw exception;
			// }
		}

		local traits_picked = [];
		while(max_traits > 0 && traits_filtered.len() > 0)
		{
			local idx = ::Math.rand(0, traits_filtered.len() - 1);
			local trait_def = traits_filtered[idx];
			traits_filtered.remove(idx);

			if(traits_picked.len() == 0)
			{
				traits_picked.push(::Legends.Traits.grant(this, trait_def));
				max_traits--;
			}
			else
			{
				local valid_trait = true;
				foreach(trait in traits_picked)
				{
					local id = ::Legends.Traits.getID(trait_def);
					if(trait.getID() == id || trait.isExcluded(id))
					{
						valid_trait = false;
						break;
					}
				}

				if(valid_trait)
				{
					::Legends.Traits.grant(this, trait_def);
					max_traits--;
				}

			}
			
		}
	}

	// sets the talent values based on traits
    // we don't depend on talent values anymore
    o.fillTalentValues <- function( _num, _force = false )
	{
		this.m.Talents.resize(::Const.Attributes.COUNT, 0);
	}
	// o.fillTalentValues <- function( _num, _force = false )
	// {
	// 	this.m.Talents.resize(::Const.Attributes.COUNT, 0);
	// 	if (this.getBackground() != null && this.getBackground().isBackgroundType(::Const.BackgroundType.Untalented) && !_force) return;
	// 	local talents = this.getTalents();

	// 	local main_stat = ::DEF.C.Traits_map_id_stat[this.getFlags().get("main_trait")];
	// 	talents[main_stat] = ::Math.rand(1,3);

	// 	local secondary_stat = ::DEF.C.Traits_map_id_stat[this.getFlags().get("secondary_trait")];
	// 	talents[secondary_stat] = ::Math.rand(1,3);
	// }

});