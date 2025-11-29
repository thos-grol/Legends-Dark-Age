//This file hooks the traits, stats, perks init for player characters


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