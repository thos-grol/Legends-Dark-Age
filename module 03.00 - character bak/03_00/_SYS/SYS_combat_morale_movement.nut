//hk - this hook adds a new property IsAffectedByApproachingEnemies to determine immunity to this type of morale check
::mods_hookBaseClass("entity/tactical/actor", function (o)
{
    o.onMovementFinish <- function ( _tile )
	{
		this.m.IsMoving = true;
		this.updateVisibility(_tile, this.m.CurrentProperties.getVision(), this.getFaction());

		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getID())
		{
			this.Tactical.TurnSequenceBar.getActiveEntity().updateVisibilityForFaction();
		}

		this.setZoneOfControl(_tile, this.hasZoneOfControl());

		if (!this.m.IsExertingZoneOfOccupation)
		{
			_tile.addZoneOfOccupation(this.getFaction());
			this.m.IsExertingZoneOfOccupation = true;
		}

		if (::Const.Tactical.TerrainEffect[_tile.Type].len() > 0 && !this.m.Skills.hasSkill(::Const.Tactical.TerrainEffectID[_tile.Type]))
		{
			this.m.Skills.add(this.new(::Const.Tactical.TerrainEffect[_tile.Type]));
		}

		if (_tile.IsHidingEntity)
		{
			this.m.Skills.add(this.new(::Const.Movement.HiddenStatusEffect));
		}

		local numOfEnemiesAdjacentToMe = _tile.getZoneOfControlCountOtherThan(this.getAlliedFactions());

		if (this.m.CurrentMovementType == ::Const.Tactical.MovementType.Default)
		{
			if (this.m.MoraleState != ::Const.MoraleState.Fleeing)
			{
				for( local i = 0; i != 6; i = ++i )
				{
					if (!_tile.hasNextTile(i))
					{
					}
					else
					{
						local otherTile = _tile.getNextTile(i);

						if (!otherTile.IsOccupiedByActor)
						{
						}
						else
						{
							if (this.m.CurrentProperties.IsAffectedByApproachingEnemies)
                            {

                            }
                            local otherActor = otherTile.getEntity();
							local numEnemies = otherTile.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

							if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
							{
								//hk - IsAffectedByApproachingEnemies
								if (this.m.CurrentProperties.IsAffectedByApproachingEnemies)
								{
									local difficulty = ::Math.maxf(10.0, 50.0 - this.getXPValue() * 0.1);
									otherActor.checkMorale(-1, difficulty);
								}
								otherActor.m.MaxEnemiesThisTurn = numEnemies;
							}
						}
					}
				}
			}
		}
		else if (this.m.CurrentMovementType == ::Const.Tactical.MovementType.Involuntary)
		{
			if (this.m.MaxEnemiesThisTurn < numOfEnemiesAdjacentToMe)
			{
				//hk - IsAffectedByApproachingEnemies
				if (this.m.CurrentProperties.IsAffectedByApproachingEnemies)
				{
					local difficulty = 40.0;
					this.checkMorale(-1, difficulty);
				}
			}
		}

		this.m.CurrentMovementType = ::Const.Tactical.MovementType.Default;
		this.m.MaxEnemiesThisTurn = ::Math.max(1, numOfEnemiesAdjacentToMe);

		if (this.isPlayerControlled() && this.getMoraleState() > ::Const.MoraleState.Breaking && this.getMoraleState() != ::Const.MoraleState.Ignore && (_tile.SquareCoords.X == 0 || _tile.SquareCoords.Y == 0 || _tile.SquareCoords.X == 31 || _tile.SquareCoords.Y == 31))
		{
			//hk - IsAffectedByApproachingEnemies
			if (this.m.CurrentProperties.IsAffectedByApproachingEnemies)
			{
				local change = this.getMoraleState() - ::Const.MoraleState.Breaking;
				this.checkMorale(-change, -1000);
			}
		}

		if (this.m.IsEmittingMovementSounds && ::Const.Tactical.TerrainMovementSound[_tile.Subtype].len() != 0)
		{
			local sound = ::Const.Tactical.TerrainMovementSound[_tile.Subtype][::Math.rand(0, ::Const.Tactical.TerrainMovementSound[_tile.Subtype].len() - 1)];
			this.Sound.play("sounds/" + sound.File, sound.Volume * ::Const.Sound.Volume.TacticalMovement * ::Math.rand(90, 100) * 0.01, this.getPos(), sound.Pitch * ::Math.rand(95, 105) * 0.01);
		}

		this.spawnTerrainDropdownEffect(_tile);

		if (_tile.Properties.Effect != null && _tile.Properties.Effect.IsAppliedOnEnter)
		{
			_tile.Properties.Effect.Callback(_tile, this);
		}

		this.m.Skills.onMovementFinished();
		this.m.Items.onMovementFinished();
		this.setDirty(true);
		this.m.IsMoving = false;
	}

});