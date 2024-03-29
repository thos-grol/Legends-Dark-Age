::Const.Strings.PerkName.LegendEscapeArtist = "Escape Artist";
::Const.Strings.PerkDescription.LegendEscapeArtist = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n" + "Escape from anything, perhaps even death..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– 1") + " AP cost for movement skills"
+ "\n"+::MSU.Text.colorGreen("– 100%") + " Fatigue cost for movement skills"
+ "\n"+::MSU.Text.colorGreen("+75") + " Defense when moving"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On turn start:")
+ "\n"+::MSU.Text.colorGreen("Perform a break free action using Attack with a -25 penalty");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendEscapeArtist].Name = ::Const.Strings.PerkName.LegendEscapeArtist;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendEscapeArtist].Tooltip = ::Const.Strings.PerkDescription.LegendEscapeArtist;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendEscapeArtist].Icon = "ui/perks/blend_in_circle.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendEscapeArtist].IconDisabled = "ui/perks/blend_in_circle_bw.png";

this.perk_legend_escape_artist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_escape_artist";
		this.m.Name = ::Const.Strings.PerkName.LegendEscapeArtist;
		this.m.Description = ::Const.Strings.PerkDescription.LegendEscapeArtist;
		this.m.Icon = "ui/perks/net_perk.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null && this.Tactical.State.isScenarioMode())
		{
			return;
		}

		if (this.getContainer().getActor().isPlacedOnMap() && this.Tactical.State.isAutoRetreat() && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())
		{
			_properties.MeleeDefense += 75;
		}
	}

	function onAfterUpdate( _properties )
	{
        local skills = this.getContainer().getSkillsByFunction(function ( _skill )
		{
			return _skill.getID() == "actives.break_free"
			|| _skill.getID() == "actives.legend_climb"
			|| _skill.getID() == "actives.sprint"
			|| _skill.getID() == "actives.footwork"
			|| _skill.getID() == "actives.rotation"

			|| _skill.getID() == "actives.legend_tumble"
			|| _skill.getID() == "actives.legend_evasion"
			|| _skill.getID() == "actives.legend_leap"
			|| _skill.getID() == "actives.charge";
		});

		foreach( s in skills )
		{
			s.m.ActionPointCost -= 1;
			s.m.FatigueCostMult *= 0.0;
		}
	}

	//Autobreak free on turn start
	function onTurnStart()
    {
        local _user = this.getContainer().getActor();
		if ( !_user.getSkills().hasSkill("effects.net")
			&& !_user.getSkills().hasSkill("effects.rooted")
			&& !_user.getSkills().hasSkill("effects.web")
			&& !_user.getSkills().hasSkill("effects.kraken_ensnare")
			&& !_user.getSkills().hasSkill("effects.serpent_ensnare") ) return;

		local skill = _user.getCurrentProperties().getMeleeSkill();
		local toHit = ::Math.min(100, skill - 25);
        local rolled = ::Math.rand(1, 100);

		if (rolled <= toHit)
		{
			::Tactical.EventLog.logEx(
				::Z.Log.display_basic(_user, null, "Breaks Free", true)
				+ ::Z.Log.display_chance(rolled, toHit)
			);

			local SoundOnHitHitpoints = [
				"sounds/combat/break_free_net_01.wav",
				"sounds/combat/break_free_net_02.wav",
				"sounds/combat/break_free_net_03.wav"
			];
			this.Sound.play(SoundOnHitHitpoints[::Math.rand(0, SoundOnHitHitpoints.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			local breakfree_decal = _user.getSkills().getSkillByID("actives.break_free").m.Decal;
			if (breakfree_decal != "")
			{
				local ourTile = _user.getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
				{
					for( local i = 0; i < ::Const.Direction.COUNT; i = i )
					{
						if (!ourTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
							{
								candidates.push(tile);
							}
						}

						i = ++i;
					}
				}
				else
				{
					candidates.push(ourTile);
				}

				if (candidates.len() != 0)
				{
					local tileToSpawnAt = candidates[::Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(breakfree_decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			_user.setDirty(true);
			this.getContainer().removeByID("effects.net");
			this.getContainer().removeByID("effects.rooted");
			this.getContainer().removeByID("effects.web");
			this.getContainer().removeByID("effects.kraken_ensnare");
			this.getContainer().removeByID("effects.serpent_ensnare");
		}
		else
		{
			::Tactical.EventLog.logEx(
				::Z.Log.display_basic(_user, null, "Breaks Free", false)
				+ ::Z.Log.display_chance(rolled, toHit)
			);

			if (this.m.SoundOnMiss.len() != 0)
			this.Sound.play(this.m.SoundOnMiss[::Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);
		}

	}

});

