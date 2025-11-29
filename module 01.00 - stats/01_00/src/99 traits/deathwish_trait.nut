::mods_hookExactClass("skills/traits/deathwish_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.deathwish";
		this.m.Name = "Deathwish";
		this.m.Icon = "ui/traits/trait_icon_13.png";
		this.m.Description = "I\'m not dead yet! This character doesn\'t care about receiving injuries and will fight on regardless.";
		this.m.Titles = [
			"the Mad",
			"the Odd",
			"the Fearless"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.craven",
			"trait.survivor",

			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
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
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::green("+10") + " Mettle"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.Bravery += 10;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		// actor.getFlags().set("Vicious", true);
	}

});

