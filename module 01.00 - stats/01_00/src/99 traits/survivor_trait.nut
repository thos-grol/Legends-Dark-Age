::mods_hookExactClass("skills/traits/survivor_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.survivor";
		this.m.Name = "Survivor";
		this.m.Icon = "ui/traits/trait_icon_43.png";
		this.m.Description = "Why won\'t you just stay dead? This character is a survivor and will outlive most of their peers.";
		this.m.Titles = [
			"the Survivor",
			"the Lucky",
			"the Blessed"
		];
		this.m.Excluded = [
			"trait.bleeder",
			"trait.pessimist",
			"trait.deathwish",
			"trait.ailing"
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
				icon = "ui/icons/special.png",
				text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]+100%[/color] chance to survive if struck down and not killed by a fatality"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.SurviveWithInjuryChanceMult *= 2.0;
	}

	o.onAdded <- function()
	{
		// local actor = this.getContainer().getActor(); 		
        // ::Z.S.set_trait_tree(actor, "CalmTree");
	}

});

