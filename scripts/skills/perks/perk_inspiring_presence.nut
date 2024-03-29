::Const.Strings.PerkName.InspiringPresence = "Teamwork Exercises";
::Const.Strings.PerkDescription.InspiringPresence = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n" + "Work as a team, fight as a team..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– 75%") + " chance of friendly fire between units in the company. " + ::MSU.Text.colorRed("Is cancelled if this unit dies")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Hold the Line\' (9 AP, 25 Fat, 2 Charges):")
+ "\n" + ::MSU.Text.color(::Z.Color.Blue, "For allied units within 4 tiles:")
+ "\n"+::MSU.Text.colorGreen("+25%" + " damage reduction")
+ "\n"+::MSU.Text.colorGreen("+Displacement Immunity")
+ "\n"+::MSU.Text.colorGreen("+Shieldwall")

+ "\n\n" + ::MSU.Text.colorRed("There can only be one commander in the party. Will refund this perk if any other unit has it.");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.InspiringPresence].Name = ::Const.Strings.PerkName.InspiringPresence;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.InspiringPresence].Tooltip = ::Const.Strings.PerkDescription.InspiringPresence;

this.perk_inspiring_presence <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.inspiring_presence";
		this.m.Name = ::Const.Strings.PerkName.InspiringPresence;
		this.m.Description = ::Const.Strings.PerkDescription.InspiringPresence;
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_hold_the_line"))
			this.m.Container.add(::new("scripts/skills/actives/legend_hold_the_line"));

		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
		if (actor.getFaction() != ::Const.Faction.Player) return;

		local playerRoster = this.World.getPlayerRoster().getAll();
		foreach( bro in playerRoster )
		{
			if (bro.getID() == actor.getID()) continue;
			if (bro.getSkills().hasSkill("perk.inspiring_presence"))
			{
				bro.m.Skills.removeByID("perk.inspiring_presence");
				bro.m.PerkPoints += 1;
				bro.m.PerkPointsSpent -= 1;

				if (bro.getFlags().has("Destiny"))
					bro.getFlags().remove("Destiny");
				break;
			}
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_hold_the_line");

		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;


	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		local actor = this.getContainer().getActor();
		// local resolve = actor.getCurrentProperties().getBravery();

		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (!ally.getSkills().hasSkill("effects.teamwork"))
				ally.getSkills().add(::new("scripts/skills/effects/teamwork_effect"));
		}
	}

	function onDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();

		local has_replacement = false;
		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getID() == actor.getID()) continue;
			if (ally.getSkills().hasSkill("perk.inspiring_presence"))
				has_replacement = true;
		}

		if (has_replacement) return;

		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getSkills().hasSkill("effects.teamwork"))
				ally.getSkills().removeByID("effects.teamwork");
		}

	}

});

