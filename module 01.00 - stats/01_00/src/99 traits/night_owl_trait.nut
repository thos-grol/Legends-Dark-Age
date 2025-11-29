::mods_hookExactClass("skills/traits/night_owl_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.night_owl";
		this.m.Name = "Night Owl";
		this.m.Icon = "ui/traits/trait_icon_57.png";
		this.m.Description = "Some characters adapt to low light conditions better than others, and this individual is especially good at it. Halves the usual night penalties";
		this.m.Titles = [
			"Night Owl",
			"Eagle Eyes"
		];
		this.m.Excluded = [
			"trait.short_sighted",
			"trait.night_blind"
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
				icon = "ui/icons/vision.png",
				text = ::green("+1") + " Vision during Nighttime"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		if (this.getContainer().hasSkill("special.night"))
		{
			_properties.Vision += 1;
		}
	}

});

//FEATURE_8: this is more of a mutant effect