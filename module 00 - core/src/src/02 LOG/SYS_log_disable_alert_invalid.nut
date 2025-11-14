::mods_hookExactClass("states/tactical_state", function (o)
{
	o.executeEntitySkill = function( _activeEntity, _targetTile )
	{
		local skill = _activeEntity.getSkills().getSkillByID(this.m.SelectedSkillID);

		if (skill != null && skill.isUsable() && skill.isAffordable())
		{
			if (_targetTile == null || skill.isTargeted() && this.wasInCameraMovementMode()) return;

			if (skill.isUsableOn(_targetTile))
			{
				if (!_targetTile.IsEmpty)
				{
					local targetEntity = _targetTile.getEntity();

					if (this.Tactical.getCamera().Level < _targetTile.Level)
					{
						this.Tactical.getCamera().Level = this.Tactical.getCamera().getBestLevelForTile(_targetTile);
					}

					if (this.isKindOf(targetEntity, "actor"))
					{
						this.logDebug("[" + _activeEntity.getName() + "] executes skill [" + skill.getName() + "] on target [" + targetEntity.getName() + "]");
					}
				}

				skill.use(_targetTile);

				if (_activeEntity.isAlive())
				{
					this.Tactical.TurnSequenceBar.updateEntity(_activeEntity.getID());
				}

				this.Tooltip.reload();
				this.Tactical.TurnSequenceBar.deselectActiveSkill();
				this.Tactical.getHighlighter().clear();
				this.m.CurrentActionState = null;
				this.m.SelectedSkillID = null;
				this.updateCursorAndTooltip();
			}
			else
			{
				this.Cursor.setCursor(::Const.UI.Cursor.Denied);
			}
		}
	}
});