this.flaw_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.flaw";
		this.m.Name = "Flaw";
		this.m.Icon = "ui/perks/flaw.png";
		this.m.IconMini = "flaw_mini";
		this.m.Overlay = "flaw";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.can_reset = false;
	}

	function getDescription()
	{
		return "This character has a flaw that can be taken advantage of.";
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
		];
	}

	function getEffectDurationString()
	{
		local ret = "";

		if (this.m.TurnsLeft == 2)
		{
			ret = "two turns";
		}
		else
		{
			ret = "one turn";
		}

		return ret;
	}

	function getLogEntryOnAdded( _user, _victim )
	{
		return _user + " has dazed " + _victim + " for " + this.getEffectDurationString();
	}

	function onAdded()
	{
		this.m.TurnsLeft = 2;
		local actor = this.getContainer().getActor();
		if (actor == null) return;
		if (!actor.isAlive() || actor.isDying()) return;
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 2;
		local actor = this.getContainer().getActor();
		if (actor == null) return;
		if (!actor.isAlive() || actor.isDying()) return;
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += -10;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

