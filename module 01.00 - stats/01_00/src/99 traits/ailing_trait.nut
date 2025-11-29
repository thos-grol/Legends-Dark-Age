::mods_hookExactClass("skills/traits/ailing_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.ailing";
		this.m.Name = "Ailing";
		this.m.Icon = "ui/traits/trait_icon_59.png";
		this.m.Description = "This character is always pale and sickly, which makes him particularly susceptible to poisons.";
		this.m.Titles = [
			"the Pale",
			"the Sickly",
			"the Ailing"
		];
		this.m.Excluded = [
			"trait.tough",
			"trait.iron_jaw",
			"trait.survivor",
			"trait.strong",
			"trait.athletic",
			"trait.iron_lungs",
			"trait.lucky",
			"trait.clubfooted"
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
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::red("– 20") + " Health"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::red("+1") + " Poison Duration"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Hitpoints += -20;
	}

});

//FEATURE_8: Compatible with curse of sickness.
