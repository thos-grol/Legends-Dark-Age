::Const.Strings.PerkName.InspiringPresence = "Teamwork Exercises";
::Const.Strings.PerkDescription.InspiringPresence = "Work as a team, fight as a team..."
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "[u]Destiny[/u]")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("– 75%") + " chance of friendly fire between units in the company. " + ::MSU.Text.colorRed("Is cancelled if this unit dies")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Hold the Line\'[/u] (9 AP, 25 Fat, 2 Charges):")
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]For allied units within 4 tiles:[/u]")
+ "\n"+::MSU.Text.colorGreen("+25%" + " damage reduction")
+ "\n"+::MSU.Text.colorGreen("+Displacement Immunity")
+ "\n"+::MSU.Text.colorGreen("+Shieldwall")

+ "\n\n" + ::MSU.Text.colorRed("There can only be one commander in the party. Will refund this perk if any other unit has it.")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "You may only pick 1 destiny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.InspiringPresence].Name = ::Const.Strings.PerkName.InspiringPresence;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.InspiringPresence].Tooltip = ::Const.Strings.PerkDescription.InspiringPresence;

this.perk_inspiring_presence <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.inspiring_presence";
		this.m.Name = this.Const.Strings.PerkName.InspiringPresence;
		this.m.Description = this.Const.Strings.PerkDescription.InspiringPresence;
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local playerRoster = this.World.getPlayerRoster().getAll();
		foreach( bro in playerRoster )
		{
			if (bro.getID() == actor.getID()) continue;
			if (bro.getSkills().hasSkill("perk.trial_by_fire"))
			{
				bro.m.Skills.removeByID("perk.trial_by_fire");
				bro.m.PerkPoints += 1;
				bro.m.PerkPointsSpent -= 1;
			}
			break;
		}

		if (!this.m.Container.hasSkill("actives.legend_hold_the_line"))
			this.m.Container.add(this.new("scripts/skills/actives/legend_hold_the_line"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_hold_the_line");
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

		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getSkills().hasSkill("effects.teamwork"))
				ally.getSkills().removeByID("effects.teamwork");
		}

	}

});

