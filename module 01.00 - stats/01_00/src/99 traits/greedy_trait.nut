::mods_hookExactClass("skills/traits/greedy_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.greedy";
		this.m.Name = "Greedy";
		this.m.Icon = "ui/traits/trait_icon_06.png";
		this.m.Description = "I want more! This character is greedy and will demand a higher payment, as well as being fast to leave you if you ever run out of crowns.";
		this.m.Excluded = [];
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
			}
		];
	}

	o.addTitle <- function()
	{
		this.character_trait.addTitle();
	}

	o.onUpdate <- function( _properties )
	{
		_properties.DailyWageMult *= 1.15;
	}

});

//FEATURE_8: rework + sin of greed