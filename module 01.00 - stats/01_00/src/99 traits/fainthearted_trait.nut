::mods_hookExactClass("skills/traits/fainthearted_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fainthearted";
		this.m.Name = "Fainthearted";
		this.m.Icon = "ui/traits/trait_icon_41.png";
		this.m.Description = "This character needs some warm words and a pat on the back from time to time.";
		this.m.Titles = [
			"the Chicken",
			"the Meek"
		];
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.craven",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.iron_jaw",
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
				text = ::green("– 10") + " Mettle"

			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += -10;
	}

});

