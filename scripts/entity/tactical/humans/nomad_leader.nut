this.nomad_leader <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.NomadLeader;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.NomadLeader.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.SouthernUntidy;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return ::Const.Strings.SouthernNames[::Math.rand(0, ::Const.Strings.SouthernNames.len() - 1)] + " " + ::Const.Strings.NomadChampionTitles[::Math.rand(0, ::Const.Strings.NomadChampionTitles.len() - 1)];
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.NomadLeader);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == ::Const.EntityType.Slave && _victim.isAlliedWith(this)) return;
		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == ::Const.EntityType.Slave && _actor.isAlliedWith(this)) return;
		this.actor.onOtherActorFleeing(_actor);
	}

	function pickOutfit()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local armor = [
				[
					1,
					"oriental/plated_nomad_mail"
				],
				[
					1,
					"oriental/southern_long_mail_with_padding"
				]
			];
			local helmet = [
				[
					4,
					"oriental/southern_helmet_with_coif"
				],
				[
					8,
					"oriental/nomad_reinforced_helmet"
				]
			];
			local outfits = [
				[
					1,
					"southern_knight_outfit_00"
				],
				[
					1,
					"white_nomad_leader_outfit_00"
				]
			];

			foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Body) == null)
		{
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[
					3,
					"oriental/plated_nomad_mail"
				],
				[
					2,
					"oriental/southern_long_mail_with_padding"
				],
				[
					1,
					"theamson_nomad_leader_armor_heavy"
				],
				[
					2,
					"citrene_nomad_leader_armor_00"
				],
				[
					1,
					"southern_knight_armor"
				]
			]));
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null)
		{
			local helmet = [
				[
					4,
					"oriental/southern_helmet_with_coif"
				],
				[
					1,
					"theamson_nomad_leader_helmet_facemask"
				],
				[
					1,
					"theamson_nomad_leader_helmet_heavy"
				],
				[
					8,
					"oriental/nomad_reinforced_helmet"
				]
			];
			helmet.push([
				4,
				"oriental/kamy_southern_helmet"
			]);
			helmet.push([
				4,
				"southern_knight_helmet"
			]);
			this.m.Items.equip(::Const.World.Common.pickHelmet(helmet));
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = ::Math.rand(1, 4);
		if (r == 1) //helmet
		{
			local named = ::Const.Items.NamedSouthernHelmets;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
		}
		else if (r == 2) //armor
		{
			local named = ::Const.Items.NamedSouthernArmors;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

