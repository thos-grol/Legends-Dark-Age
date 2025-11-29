::mods_hookExactClass("skills/traits/asthmatic_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.asthmatic";
		this.m.Name = "Asthmatic";
		this.m.Icon = "ui/traits/trait_icon_22.png";
		this.m.Description = "Being short of breath and prone to coughing, this character takes longer to recover from fatigue than others.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.athletic",
			"trait.iron_lungs",
			"trait.swift"
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
				icon = "ui/icons/fatigue.png",
				text = ::red("– 20") + " Endurance"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::red("– 5") + " Fatigue Recovery"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.FatigueRecoveryRate += -5;
		_properties.Stamina += -20;
	}

});

//FEATURE_8: Compatible with curse of sickness.
