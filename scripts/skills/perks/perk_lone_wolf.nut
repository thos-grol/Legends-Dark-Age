::Const.Strings.PerkName.LoneWolf = "Lone Wolf";
::Const.Strings.PerkDescription.LoneWolf = "Dog or Wolf?"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "With no ally within 2 tiles:")
+ "\n"+::MSU.Text.colorGreen("+15%") + " Melee Skill"
+ "\n"+::MSU.Text.colorGreen("+15%") + " Ranged Skill"
+ "\n"+::MSU.Text.colorGreen("+15%") + " Melee Defense"
+ "\n"+::MSU.Text.colorGreen("+15%") + " Ranged Defense"
+ "\n"+::MSU.Text.colorGreen("+15%") + " Resolve";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LoneWolf].Name = ::Const.Strings.PerkName.LoneWolf;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LoneWolf].Tooltip = ::Const.Strings.PerkDescription.LoneWolf;

this.perk_lone_wolf <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.lone_wolf";
		this.m.Name = this.Const.Strings.PerkName.LoneWolf;
		this.m.Description = this.Const.Strings.PerkDescription.LoneWolf;
		this.m.Icon = "ui/perks/perk_37.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return;

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local isAlone = true;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap()) continue;
			if (ally.getTile().getDistanceTo(myTile) <= 2)
			{
				isAlone = false;
				break;
			}
		}

		if (isAlone)
		{
			_properties.MeleeSkillMult *= 1.15;
			_properties.RangedSkillMult *= 1.15;
			_properties.MeleeDefenseMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
			_properties.BraveryMult *= 1.15;
		}
	}

});
