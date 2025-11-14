::mods_hookBaseClass("entity/tactical/actor", function (o)
{
	// overwrite all hooks to implement base fn hook
	while(!("kill" in o)) o = o[o.SuperName];
	o.kill <- function ( _killer = null, _skill = null, _fatalityType = ::Const.FatalityType.None, _silent = false )
	{
		if (!this.isAlive()) return;
		if (_killer != null && !_killer.isAlive()) _killer = null;
		if (this.m.IsMiniboss && !this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("GiveMeThat", 1, 1);

			if (!this.Tactical.State.isScenarioMode() && ::World.Retinue.hasFollower("follower.bounty_hunter"))
			{
				::World.Retinue.getFollower("follower.bounty_hunter").onChampionKilled(this);
			}
		}

		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.getID() == "actives.deathblow")
		{
			this.updateAchievement("Assassin", 1, 1);
		}

		this.m.IsDying = true;
		local isReallyDead = this.isReallyKilled(_fatalityType);

		if (!isReallyDead)
		{
			_fatalityType = ::Const.FatalityType.Unconscious;
			this.logDebug(this.getName() + " is unconscious.");
		}
		else
		{
			this.logDebug(this.getName() + " has died.");
		}

		if (!_silent)
		{
			this.playSound(::Const.Sound.ActorEvent.Death, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.Death] * this.m.SoundVolumeOverall, this.m.SoundPitch);
		}

		local myTile = this.isPlacedOnMap() ? this.getTile() : null;
		local tile = this.findTileToSpawnCorpse(_killer);
		this.m.Skills.onDeath(_fatalityType);
		this.onDeath(_killer, _skill, tile, _fatalityType);
		
		// hk - imprint corpse for necro system
		::Z.S.imprint_corpse(this, tile);

		// hk - drop loot
		::Z.S.drop_loot(this, tile);

		if (!this.Tactical.State.isFleeing() && _killer != null)
		{
			_killer.onActorKilled(this, tile, _skill);
		}

		// hk implement log changes
		if (_killer != null && !_killer.isHiddenToPlayer() && !this.isHiddenToPlayer())
		{
			if (isReallyDead)
			{
				if (_killer.getID() != this.getID())
				{
					::Z.S.log_kill(this);
				}
				else
				{
					::Z.S.log_kill(this);
				}
			}
			else if (_killer.getID() != this.getID())
			{
				::Z.S.log_kill(this);
			}
			else
			{
				::Z.S.log_kill(this);
			}
		}

		if (!this.Tactical.State.isFleeing() && myTile != null)
		{
			local actors = this.Tactical.Entities.getAllInstances();

			foreach( i in actors )
			{
				foreach( a in i )
				{
					if (a.getID() != this.getID() && a.isPlacedOnMap())
					{
						a.onOtherActorDeath(_killer, this, _skill);
					}
				}
			}
		}

		if (!this.isHiddenToPlayer())
		{
			if (tile != null)
			{
				if (_fatalityType == ::Const.FatalityType.Decapitated)
				{
					this.spawnDecapitateSplatters(tile, 1.0 * this.m.DecapitateBloodAmount);
				}
				else if (_fatalityType == ::Const.FatalityType.Smashed && (this.getFlags().has("human") || this.getFlags().has("zombie_minion")))
				{
					this.spawnSmashSplatters(tile, 1.0);
				}
				else
				{
					this.spawnBloodSplatters(tile, ::Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);

					if (!this.getTile().isSameTileAs(tile))
					{
						this.spawnBloodSplatters(this.getTile(), ::Const.Combat.BloodSplattersAtOriginalPosMult);
					}
				}
			}
			else if (myTile != null)
			{
				this.spawnBloodSplatters(this.getTile(), ::Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);
			}
		}

		if (tile != null)
		{
			this.spawnBloodPool(tile, ::Math.rand(::Const.Combat.BloodPoolsAtDeathMin, ::Const.Combat.BloodPoolsAtDeathMax));
		}

		this.m.IsTurnDone = true;
		this.m.IsAlive = false;

		if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
		{
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		}

		if (!this.Tactical.State.isScenarioMode())
		{
			::World.Contracts.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			::World.Events.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			::World.Assets.getOrigin().onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
			{
				if (_killer == null || _killer.getID() == this.getID())
				{
					this.Sound.play(::Const.Sound.ArenaFlee[::Math.rand(0, ::Const.Sound.ArenaFlee.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
				else
				{
					this.Sound.play(::Const.Sound.ArenaKill[::Math.rand(0, ::Const.Sound.ArenaKill.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
			}
		}

		if (this.isPlayerControlled())
		{
			if (isReallyDead)
			{
				if (this.isGuest())
				{
					::World.getGuestRoster().remove(this);
				}
				else
				{
					::World.getPlayerRoster().remove(this);
				}
			}

			if (this.Tactical.Entities.getHostilesNum() != 0)
			{
				this.Tactical.Entities.setLastCombatResult(::Const.Tactical.CombatResult.PlayerDestroyed);
			}
			else
			{
				this.Tactical.Entities.setLastCombatResult(::Const.Tactical.CombatResult.EnemyDestroyed);
			}
		}
		else
		{
			if (!this.Tactical.State.isAutoRetreat())
			{
				this.Tactical.Entities.setLastCombatResult(::Const.Tactical.CombatResult.EnemyDestroyed);
			}

			if (_killer != null && _killer.isPlayerControlled() && !this.Tactical.State.isScenarioMode() && ::World.FactionManager.getFaction(this.getFaction()) != null && !::World.FactionManager.getFaction(this.getFaction()).isTemporaryEnemy())
			{
				::World.FactionManager.getFaction(this.getFaction()).addPlayerRelation(::Const.World.Assets.RelationUnitKilled);
			}
		}

		if (isReallyDead)
		{
			if (!this.Tactical.State.isScenarioMode() && this.isPlayerControlled() && !this.isGuest())
			{
				local roster = ::World.getPlayerRoster().getAll();

				foreach( bro in roster )
				{
					if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
					{
						if (::World.Assets.getOrigin().getID() != "scenario.manhunters" || this.getBackground().getID() != "background.slave" || bro.getBackground().getID() == "background.slave")
						{
							bro.worsenMood(::Const.MoodChange.BrotherDied, this.getName() + " died in battle");
						}
					}
				}
			}

			this.die();
		}
		else
		{
			this.removeFromMap();
		}

		if (this.m.Items != null)
		{
			this.m.Items.onActorDied(tile);

			if (isReallyDead)
			{
				this.m.Items.setActor(null);
			}
		}

		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.getFaction() == ::Const.Faction.PlayerAnimals && _skill != null && _skill.getID() == "actives.wardog_bite")
		{
			this.updateAchievement("WhoLetTheDogsOut", 1, 1);
		}

		this.onAfterDeath(myTile);
	};



	//implement legends kill hook
	local kill = o.kill;
	o.kill <- function (_killer = null, _skill = null, _fatalityType = ::Const.FatalityType.None, _silent = false) {
		if (this.getFlags().has("tail")) // ignore killer when is tail
			kill(null, _skill, _fatalityType, _silent);
		else
			kill(_killer, _skill, _fatalityType, _silent);
	};
});