::mods_hookExactClass("skills/traits/night_blind_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.night_blind";
		this.m.Name = "Night Blind";
		this.m.Icon = "ui/traits/trait_icon_56.png";
		this.m.Description = "During nighttime this character has to be tied to a flock, because he won\'t be able to see even his own nose.";
		this.m.Excluded = [
			"trait.eagle_eyes",
			"trait.night_owl"
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
				text = ::red("– 2") + " Vision during Nighttime"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		if (this.getContainer().hasSkill("special.night"))
		{
			_properties.Vision -= 2;
		}
	}

});

//TODO: added to lowborn backgrounds at 80% chance
//TODO: anatomist background can cure nightblindness - event

