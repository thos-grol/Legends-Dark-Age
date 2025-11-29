::mods_hookExactClass("skills/traits/dumb_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.dumb";
		this.m.Name = "Dumb";
		this.m.Icon = "ui/traits/trait_icon_17.png";
		this.m.Description = "Umm, what? This character isn\'t the brightest, and new concepts take a while to really stick with him.";
		this.m.Titles = [
			"the Slow",
			"the Idiot",
			"the Odd"
		];
		this.m.Excluded = [
			"trait.bright",
			"trait.aspiring",
			"trait.sophisticated",
			"trait.teamplayer"
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
				icon = "ui/icons/xp_received.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-50%[/color] Experience Gain"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.XPGainMult *= 0.5;
	}

});

