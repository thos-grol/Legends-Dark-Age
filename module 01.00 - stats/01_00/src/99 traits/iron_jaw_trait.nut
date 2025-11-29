::mods_hookExactClass("skills/traits/iron_jaw_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.iron_jaw";
		this.m.Name = "Iron Jaw";
		this.m.Icon = "ui/traits/trait_icon_44.png";
		this.m.Description = "This character shakes off hits that would cripple a lesser man.";
		this.m.Titles = [
			"Ironjaw",
			"the Rock",
			"the Stallion"
		];
		this.m.Excluded = [
			"trait.fragile",
			"trait.fainthearted",
			"trait.bleeder",
			"trait.tiny",
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
				text = ::green("+25%") + " Injury Resistance"

			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.25;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "HealthTree");
	}

	

});

