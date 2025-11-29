::mods_hookExactClass("skills/traits/bleeder_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.bleeder";
		this.m.Name = "Bleeder";
		this.m.Icon = "ui/traits/trait_icon_16.png";
		this.m.Description = "This character is prone to bleeding and will do so longer than most others.";
		this.m.Excluded = [
			"trait.tough",
			"trait.iron_jaw",
			"trait.survivor"
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
				text = ::red("+1") + " Bleed Duration"
			},
		];
	}

	o.onUpdate <- function( _properties )
{
	_properties.Hitpoints += -20;
}

});
// FEATURE_8: Curse of Blood

