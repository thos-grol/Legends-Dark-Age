::mods_hookExactClass("skills/traits/craven_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.craven";
		this.m.Name = "Craven";
		this.m.Icon = "ui/traits/trait_icon_40.png";
		this.m.Description = "Run for your lives! This character is a craven and will run at the slightest sign of the odds turning against him.\nIt just so happens that running is what he is good at.";
		this.m.Titles = [
			"the Coward",
			"the Craven",
			"Turncoat",
			"the Spineless"
		];
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.fainthearted",
			"trait.deathwish",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.hate_greenskins",
			"trait.hate_undead",
			"trait.hate_beasts"
		];
	}

	o.getTooltip <- function()
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
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::red("– 15") + " Mettle"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::green("+30") + " Defense while retreating"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += -15;
		_properties.IsContentWithBeingInReserve = true;
	}

	o.onBeingAttacked <- function( _attacker, _skill, _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null && this.Tactical.State.isScenarioMode()) return;

		if (this.getContainer().getActor().isPlacedOnMap() && this.Tactical.State.isAutoRetreat() && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())
		{
			_properties.MeleeDefense += 30;
		}
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		// actor.getFlags().set("Devious", true);
	}

});

