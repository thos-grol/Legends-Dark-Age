//This file hooks the traits, stats, perks init for player characters
::mods_hookExactClass("entity/tactical/player", function (o){

	// this is the function that sets up character's stats, traits, and perks
	o.setStartValuesEx <- function ( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		local background = init_background(_backgrounds, _gender);
		
		// hk - Add traits before trees, so traits can determine trait trees.
		if (_addTraits) pick_traits(background);

		// build perk trees
		local attributes = background.buildPerkTree();
		if (this.getFlags().has("PlayerZombie")) 
            this.m.StarWeights = background.buildAttributes("zombie", attributes);
		else if (this.getFlags().has("PlayerSkeleton")) 
            this.m.StarWeights = background.buildAttributes("skeleton", attributes);
		else this.m.StarWeights = background.buildAttributes(null, attributes);
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

		// build talent stars
		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		}
	}


	// 	// =========================================================================================
	// 	// Helper fns
	// 	// =========================================================================================

	o.init_background <- function(_backgrounds, _gender = -1)
	{
		if (this.isSomethingToSee() && ::World.getTime().Days >= 7)
		{
			_backgrounds = ::Const.CharacterPiracyBackgrounds;
		}

		local background = ::new("scripts/skills/backgrounds/" + ::MSU.Array.rand(_backgrounds));
		this.m.Skills.add(background);

		background.buildDescription();

		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled") 
		{
			background.setGender(_gender);
		}
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
	o.fillTalentValues <- function( _num, _force = false )
	{
		this.m.Talents.resize(::Const.Attributes.COUNT, 0);
		if (this.getBackground() != null && this.getBackground().isBackgroundType(::Const.BackgroundType.Untalented) && !_force) return;
		local talents = this.getTalents();

		local main_stat = ::DEF.C.Traits_map_id_stat[this.getFlags().get("main_trait")];
		talents[main_stat] = ::Math.rand(1,3);

		local secondary_stat = ::DEF.C.Traits_map_id_stat[this.getFlags().get("secondary_trait")];
		talents[secondary_stat] = ::Math.rand(1,3);
	}

});

::mods_hookExactClass("entity/tactical/player", function(o)
{
	o.onInit <- function()
	{
		this.human.onInit();
		this.m.Skills.add(this.new("scripts/skills/special/stats_collector"));
		// this.m.Skills.add(this.new("scripts/skills/special/mood_check"));
		this.m.Skills.add(this.new("scripts/skills/special/weapon_breaking_warning"));
		this.m.Skills.add(this.new("scripts/skills/special/no_ammo_warning"));
		this.m.Skills.add(this.new("scripts/skills/effects/battle_standard_effect"));
		this.m.Skills.add(this.new("scripts/skills/actives/break_ally_free_skill"));

		if (::Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.setFaction(::Const.Faction.Player);
		this.m.Items.setUnlockedBagSlots(2);
		this.m.Skills.add(this.new("scripts/skills/special/bag_fatigue"));
		this.setDiscovered(true);
	}
});


::mods_hookExactClass("entity/tactical/actor", function ( o )
{
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		if (!::Legends.Effects.has(this, ::Legends.Effect.MoodCheck))
			::Legends.Effects.grant(this, ::Legends.Effect.MoodCheck); // details
		
		if (!::Legends.Effects.has(this, ::Legends.Effect.FollowUpProccerEffect))
			::Legends.Effects.grant(this, ::Legends.Effect.FollowUpProccerEffect);
		
		if (!::Legends.Effects.has(this, ::Legends.Effect.NoKillstealing))
			::Legends.Effects.grant(this, ::Legends.Effect.NoKillstealing);

		modify_injury_immunity();
	}

	o.modify_injury_immunity <- function()
	{
		//add injury immunity
		local flags = this.getFlags();
		if (!flags.has("undead")) return;

		if (flags.has("ghost") || flags.has("ghoul") || flags.has("vampire")) 
		{
			this.m.ExcludedInjuries.extend([
				"injury.bruised_leg",
				"injury.broken_nose",
				"injury.severe_concussion",
				"injury.crushed_windpipe",
				"injury.cut_artery",
				"injury.exposed_ribs",
				"injury.ripped_ear",
				"injury.split_nose",
				"injury.pierced_cheek",
				"injury.grazed_neck",
				"injury.cut_throat",
				"injury.grazed_kidney",
				"injury.pierced_lung",
				"injury.grazed_neck",
				"injury.cut_throat",
				"injury.crushed_windpipe",
				"injury.inhaled_flames"
			]);
			return;
		}

		::Legends.Effects.grant(actor, ::Legends.Effect.Undead);

		if (flags.has("skeleton"))
		{
			this.m.ExcludedInjuries.extend([
				"injury.sprained_ankle",
				"injury.deep_abdominal_cut",
				"injury.cut_leg_muscles",
				"injury.cut_achilles_tendon",
				"injury.deep_chest_cut",
				"injury.pierced_leg_muscles",
				"injury.pierced_chest",
				"injury.pierced_side",
				"injury.pierced_arm_muscles",
				"injury.stabbed_guts",
				"injury.bruised_leg",
				"injury.broken_nose",
				"injury.severe_concussion",
				"injury.crushed_windpipe",
				"injury.cut_artery",
				"injury.exposed_ribs",
				"injury.ripped_ear",
				"injury.split_nose",
				"injury.pierced_cheek",
				"injury.grazed_neck",
				"injury.cut_throat",
				"injury.grazed_kidney",
				"injury.pierced_lung",
				"injury.grazed_neck",
				"injury.cut_throat",
				"injury.crushed_windpipe",
				"injury.inhaled_flames"
			]);
		}
	}
});