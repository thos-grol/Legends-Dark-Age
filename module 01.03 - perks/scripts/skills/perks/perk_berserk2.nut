
this.perk_berserk2 <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "perk.berserk2";
		this.m.Name = ::Const.Strings.PerkName.Berserk2;
		this.m.Description = ::Const.Strings.PerkDescription.Berserk2;
		this.m.Icon = "ui/perks/berserk.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();

		if (actor.isAlliedWith(_targetEntity)) return;
		if (!this.m.IsSpent && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID())
		{
			this.m.IsSpent = true;
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - 15));
			actor.setDirty(true);
			this.spawnIcon(this.m.Overlay, this.m.Container.getActor().getTile());
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.1;
	}
});