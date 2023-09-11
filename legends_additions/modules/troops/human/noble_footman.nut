::Const.Tactical.Actor.Footman = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/noble_footman", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Footman);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}

		shield.setFaction(banner);
		this.m.Items.equip(shield);
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"seedmaster_noble_armor"
			],
			[
				1,
				"citreneking_noble_armor"
			]
		]));
		local helmet;

		if (banner <= 4)
		{
			helmet = this.Const.World.Common.pickHelmet([
				[
					5,
					"kettle_hat"
				],
				[
					5,
					"rondel_helm"
				],
				[
					4,
					"scale_helm"
				],
				[
					4,
					"kettle_hat_with_mail"
				],
				[
					3,
					"padded_kettle_hat"
				],
				[
					3,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					2,
					"mail_coif"
				],
				[
					1,
					"heavy_noble_house_helmet_00"
				]
			]);
		}
		else if (banner <= 7)
		{
			helmet = this.Const.World.Common.pickHelmet([
				[
					5,
					"rondel_helm"
				],
				[
					4,
					"padded_flat_top_helmet"
				],
				[
					3,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					3,
					"mail_coif"
				],
				[
					2,
					"flat_top_helmet"
				],
				[
					2,
					"scale_helm"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"heavy_noble_house_helmet_00"
				]
			]);
		}
		else
		{
			helmet = this.Const.World.Common.pickHelmet([
				[
					5,
					"nasal_helmet"
				],
				[
					5,
					"padded_nasal_helmet"
				],
				[
					4,
					"nasal_helmet_with_mail"
				],
				[
					3,
					"mail_coif"
				],
				[
					2,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					1,
					"heavy_noble_house_helmet_00"
				]
			]);
		}

		if (helmet != null)
		{
			if ("setPlainVariant" in helmet)
			{
				helmet.setPlainVariant();
			}

			this.m.Items.equip(helmet);
		}
	}

});

