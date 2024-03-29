this.legend_bandit_warlord <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.BanditWarlord;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditWarlord.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				::Const.World.LocationNames.VillageWestern[::Math.rand(0, ::Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(::Const.Strings.BanditLeaderNames[::Math.rand(0, ::Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditWarlord);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.setArmorSaturation(0.6);
		this.getSprite("shield_icon").setBrightness(0.6);
	}

	function pickOutfit()
	{
		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Body) == null)
		{
			local armor = [
				[
					1,
					"bandit_armor_ultraheavy"
				],
				[
					2,
					"coat_of_plates"
				],
				[
					2,
					"coat_of_scales"
				],
				[
					2,
					"heavy_lamellar_armor"
				],
				[
					1,
					"reinforced_mail_hauberk"
				],
				[
					1,
					"brown_hedgeknight_armor"
				],
				[
					1,
					"northern_mercenary_armor_02"
				]
			];
			local item = ::Const.World.Common.pickArmor(armor);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null)
		{
			local helmet = [
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat_with_closed_mail"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"bascinet_with_mail"
				]
			];
			local item = ::Const.World.Common.pickHelmet(helmet);
			this.m.Items.equip(item);
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

