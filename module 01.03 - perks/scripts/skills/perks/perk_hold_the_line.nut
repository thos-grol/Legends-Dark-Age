
this.perk_hold_the_line <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.hold_the_line";
		this.m.Name = ::Const.Strings.PerkName.HoldtheLine;
		this.m.Description = ::Const.Strings.PerkDescription.HoldtheLine;
		this.m.Icon = "ui/perks/hold_the_line.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToKnockBackAndGrab = true;

		// if it's not this character's turn they get advantage on attacks
		// good for ripostes and attacks of oppurtunity
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap()) return;
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null) return;
		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID()) return;
		_properties.Advantage_Attack = true;
	}
});