::mods_hookExactClass("skills/traits/insecure_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.insecure";
		this.m.Name = "Insecure";
		this.m.Icon = "ui/traits/trait_icon_03.png";
		this.m.Description = "I can\'t do it! This character could use a bit more self confidence.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.optimist",
			"trait.irrational",
			"trait.determined",
			"trait.sure_footing",
			"trait.cocky",
			"trait.brute",
			"trait.bloodthirsty"
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
				text = ::red("– 10") + " Mettle"

			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will never be of confident morale"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += -10;
	}

});

