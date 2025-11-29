::mods_hookBaseClass("entity/tactical/actor", function (o)
{
	o.changeMorale <- function ( _change, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		local oldMoraleState = this.m.MoraleState;
		this.m.MoraleState = _change;
		this.m.FleeingRounds = 0;

		if (this.m.MoraleState == ::Const.MoraleState.Confident && oldMoraleState != ::Const.MoraleState.Confident && "State" in ::World && ::World.State != null && ::World.Ambitions.hasActiveAmbition() && ::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_camaraderie")
		{
			::World.Statistics.getFlags().increment("OathtakersBrosConfident");
		}

		if (oldMoraleState == ::Const.MoraleState.Fleeing && this.m.IsActingEachTurn)
		{
			this.setZoneOfControl(this.getTile(), this.hasZoneOfControl());

			if (this.isPlayerControlled() || !this.isHiddenToPlayer())
			{
				if (_noNewLine)
				{
					::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + " has rallied");
				}
				else
				{
					::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + " has rallied");
				}
			}
		}
		else if (this.m.MoraleState == ::Const.MoraleState.Fleeing)
		{
			this.setZoneOfControl(this.getTile(), this.hasZoneOfControl());
			this.m.Skills.removeByID("effects.shieldwall");
			this.m.Skills.removeByID("effects.spearwall");
			this.m.Skills.removeByID("effects.riposte");
			this.m.Skills.removeByID("effects.return_favor");
			this.m.Skills.removeByID("effects.indomitable");
		}

		local morale = this.getSprite("morale");

		if (::Const.MoraleStateBrush[this.m.MoraleState].len() != 0 && morale != null)
		{
			if (this.m.MoraleState == ::Const.MoraleState.Confident)
			{
				morale.setBrush(this.m.ConfidentMoraleBrush);
			}
			else
			{
				morale.setBrush(::Const.MoraleStateBrush[this.m.MoraleState]);
			}

			morale.Visible = true;
		}
		else
		{
			morale.Visible = false;
		}

		if (this.isPlayerControlled() || !this.isHiddenToPlayer())
		{
			if (_noNewLine)
			{
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + ::Const.MoraleStateEvent[this.m.MoraleState]);
			}
			else
			{
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + ::Const.MoraleStateEvent[this.m.MoraleState]);
			}

			if (_showIconBeforeMoraleIcon != "")
			{
				this.Tactical.spawnIconEffect(_showIconBeforeMoraleIcon, this.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			}

			if (_change > 0)
			{
				this.Tactical.spawnIconEffect(::Const.Morale.MoraleUpIcon, this.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			}
			else
			{
				this.Tactical.spawnIconEffect(::Const.Morale.MoraleDownIcon, this.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			}
		}

		this.m.Skills.update();
		this.setDirty(true);

		if (this.m.MoraleState == ::Const.MoraleState.Fleeing && this.Tactical.TurnSequenceBar.getActiveEntity() != this)
		{
			this.Tactical.TurnSequenceBar.pushEntityBack(this.getID());
		}

		if (this.m.MoraleState == ::Const.MoraleState.Fleeing)
		{
			local actors = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			if (actors != null)
			{
				foreach( a in actors )
				{
					if (a.getID() != this.getID())
					{
						a.onOtherActorFleeing(this);
					}
				}
			}
		}
	};

	while(!("setMoraleState" in o)) o = o[o.SuperName];
	o.setMoraleState = function ( _m )
	{
		if (this.m.Skills.hasSkill("effects.ancient_priest_potion")) return;
		if (this.m.Skills.hasSkill("trait.boss_fearless") && this.getHitpointsPct() > 0.25) return;
		if (this.m.MoraleState == _m) return;


		if (_m == ::Const.MoraleState.Fleeing)
		{
			this.m.Skills.removeByID("effects.shieldwall");
			this.m.Skills.removeByID("effects.spearwall");
			this.m.Skills.removeByID("effects.riposte");
			this.m.Skills.removeByID("effects.return_favor");
			this.m.Skills.removeByID("effects.indomitable");
		}

		this.m.MoraleState = _m;
		local morale = this.getSprite("morale");

		if (::Const.MoraleStateBrush[this.m.MoraleState].len() != 0)
		{
			if (this.m.MoraleState == ::Const.MoraleState.Confident)
			{
				morale.setBrush(this.m.ConfidentMoraleBrush);
			}
			else
			{
				morale.setBrush(::Const.MoraleStateBrush[this.m.MoraleState]);
			}

			morale.Visible = true;
		}
		else
		{
			morale.Visible = false;
		}

		this.m.Skills.update();
	}
});