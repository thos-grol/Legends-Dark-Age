this.la_nachzerer <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Head = 1
	},

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Ghoul);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_ghoul_body_03");
		body.varySaturation(0.25);
		body.varyColor(0.06, 0.06, 0.06);
		this.m.Head = this.Math.rand(1, 3);
		local head = this.addSprite("head");
		head.setBrush("bust_ghoul_03_head_0" + this.m.Head)
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_ghoul_03_injured");
		injury.Visible = false;
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(-7, 14));

		this.getFlags().add("ghoul");
		this.getFlags().add("undead");
		this.getFlags().add("immunity_overwhelm");
		this.getFlags().set("bleed_aura", 15);

		//Skills
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_escape_artist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
        this.m.Skills.add(this.new("scripts/skills/traits/boss_fearless_trait")); //doesn't run until 25% hp

		this.m.Skills.add(this.new("scripts/skills/perks/perk_nachzerer_hair_armor")); // hair armor nullifies damage for x hits.

		//will swallow bro, damaging them and healing the damage dealt. Has a chance to miss. If the swallowed bro dies,
		//will heal temp injuries, and gain 2 charges of hair armor.
		//this.m.Skills.add(this.new("scripts/skills/actives/nachzerer_swallow_whole"));

		//jumps to tile with corpse within 4 range. Feast on the corpse, healing temp injuries, regaining health, and gaining 2 charges of hair armor.
		//this.m.Skills.add(this.new("scripts/skills/actives/nachzerer_gruesome_feast"));

		//this.m.Skills.add(this.new("scripts/skills/actives/nachzerer_claws")); //claws that inflict bleeding
		this.m.Skills.add(this.new("scripts/skills/actives/nachzerer_claws_swipe")); //claw swing that hits 3 enemies and knocks them back.
        this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy")); // buffs damage on kill
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		

		//this.m.Skills.add(this.new("scripts/skills/actives/nachzerer_leap")); //leap skill when surrounded, perform a claw attack on the target.
		
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.Ghoul;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Ghoul.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(35, -26);
		this.m.DecapitateBloodAmount = 1.5;
		this.m.BloodPoolScale = 1.33;
		this.m.ConfidentMoraleBrush = "icon_confident_undead";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/ghoul_hurt_01.wav",
			"sounds/enemies/ghoul_hurt_02.wav",
			"sounds/enemies/ghoul_hurt_03.wav",
			"sounds/enemies/ghoul_hurt_04.wav",
			"sounds/enemies/ghoul_hurt_05.wav",
			"sounds/enemies/ghoul_hurt_06.wav",
			"sounds/enemies/ghoul_hurt_07.wav",
			"sounds/enemies/ghoul_hurt_08.wav",
			"sounds/enemies/ghoul_hurt_09.wav",
			"sounds/enemies/ghoul_hurt_10.wav",
			"sounds/enemies/ghoul_hurt_11.wav",
			"sounds/enemies/ghoul_hurt_12.wav",
			"sounds/enemies/ghoul_hurt_13.wav",
			"sounds/enemies/ghoul_hurt_14.wav",
			"sounds/enemies/ghoul_hurt_15.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghoul_death_01.wav",
			"sounds/enemies/ghoul_death_02.wav",
			"sounds/enemies/ghoul_death_03.wav",
			"sounds/enemies/ghoul_death_04.wav",
			"sounds/enemies/ghoul_death_05.wav",
			"sounds/enemies/ghoul_death_06.wav",
			"sounds/enemies/ghoul_death_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/ghoul_flee_01.wav",
			"sounds/enemies/ghoul_flee_02.wav",
			"sounds/enemies/ghoul_flee_03.wav",
			"sounds/enemies/ghoul_flee_04.wav",
			"sounds/enemies/ghoul_flee_05.wav",
			"sounds/enemies/ghoul_flee_06.wav",
			"sounds/enemies/ghoul_flee_07.wav",
			"sounds/enemies/ghoul_flee_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/ghoul_idle_01.wav",
			"sounds/enemies/ghoul_idle_02.wav",
			"sounds/enemies/ghoul_idle_03.wav",
			"sounds/enemies/ghoul_idle_04.wav",
			"sounds/enemies/ghoul_idle_05.wav",
			"sounds/enemies/ghoul_idle_06.wav",
			"sounds/enemies/ghoul_idle_07.wav",
			"sounds/enemies/ghoul_idle_08.wav",
			"sounds/enemies/ghoul_idle_09.wav",
			"sounds/enemies/ghoul_idle_10.wav",
			"sounds/enemies/ghoul_idle_11.wav",
			"sounds/enemies/ghoul_idle_12.wav",
			"sounds/enemies/ghoul_idle_13.wav",
			"sounds/enemies/ghoul_idle_14.wav",
			"sounds/enemies/ghoul_idle_15.wav",
			"sounds/enemies/ghoul_idle_16.wav",
			"sounds/enemies/ghoul_idle_17.wav",
			"sounds/enemies/ghoul_idle_18.wav",
			"sounds/enemies/ghoul_idle_19.wav",
			"sounds/enemies/ghoul_idle_20.wav",
			"sounds/enemies/ghoul_idle_21.wav",
			"sounds/enemies/ghoul_idle_22.wav",
			"sounds/enemies/ghoul_idle_23.wav",
			"sounds/enemies/ghoul_idle_24.wav",
			"sounds/enemies/ghoul_idle_25.wav",
			"sounds/enemies/ghoul_idle_26.wav",
			"sounds/enemies/ghoul_idle_27.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/ghoul_grows_01.wav",
			"sounds/enemies/ghoul_grows_02.wav",
			"sounds/enemies/ghoul_grows_03.wav",
			"sounds/enemies/ghoul_grows_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other2] = [
			"sounds/enemies/ghoul_death_fullbelly_01.wav",
			"sounds/enemies/ghoul_death_fullbelly_02.wav",
			"sounds/enemies/ghoul_death_fullbelly_03.wav"
		];
		this.m.SoundPitch = 0.9;
		local onArmorHitSounds = this.getItems().getAppearance().ImpactSound;
		onArmorHitSounds[this.Const.BodyPart.Body] = this.Const.Sound.ArmorLeatherImpact;
		onArmorHitSounds[this.Const.BodyPart.Head] = this.Const.Sound.ArmorLeatherImpact;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/la_nachzerer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(0, 100) < 50;
		local isResurrectable = _fatalityType != this.Const.FatalityType.Decapitated;
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");

		if (_tile != null)
		{
			local decal;
			local skin = this.getSprite("body");
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					sprite_head.getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-45, 10), 55.0, sprite_head.getBrush().Name + "_bloodpool");

				foreach( sprite in decap )
				{
					sprite.Color = skin.Color;
					sprite.Saturation = skin.Saturation;
					sprite.Scale = 0.9;
					sprite.setBrightness(0.9);
				}
			}
			else
			{
				decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = skin.Color;
				decal.Saturation = skin.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.Value = 2.0;
			corpse.IsResurrectable = false;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					if (this.Const.DLC.Unhold)
					{
						local r = this.Math.rand(1, 100);
						local loot;

						if (r <= 35)
						{
							loot = this.new("scripts/items/misc/ghoul_teeth_item");
						}
						else if (r <= 70)
						{
							loot = this.new("scripts/items/misc/ghoul_horn_item");
						}
						else
						{
							loot = this.new("scripts/items/misc/ghoul_brain_item");
						}

						loot.drop(_tile);
					}
					else
					{
						local loot = this.new("scripts/items/misc/ghoul_teeth_item");
						loot.drop(_tile);
					}

					i = ++i;
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAfterDeath( _tile )
	{
        local skill = this.getSkills().getSkillByID("actives.nachzerer_swallow_whole");
		//TODO: drop swallowed items if any
		
		if (skill.getSwallowedEntity() != null)
		{
			local e = skill.getSwallowedEntity();
			this.Tactical.addEntityToMap(e, _tile.Coords.X, _tile.Coords.Y);
			e.getFlags().set("Devoured", false);
			local slime = e.getSprite("dirt");
			slime.setBrush("bust_slime");
			slime.Visible = true;
		}
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("body_blood").setHorizontalFlipping(flip);
	}

});

