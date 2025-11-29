::mods_hookExactClass("skills/traits/fragile_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fragile";
		this.m.Name = "Fragile";
		this.m.Icon = "ui/traits/trait_icon_04.png";
		this.m.Description = "With a physique like an eggshell, this guy is not the natural born brawler.";
		this.m.Excluded = [
			"trait.huge",
			"trait.tough",
			"trait.strong",
			"trait.brawler",
			"trait.gluttonous",
			"trait.brute",
			"trait.iron_jaw"
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

			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Hitpoints += -20;
	}

});

