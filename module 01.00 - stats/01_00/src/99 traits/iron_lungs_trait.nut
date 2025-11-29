::mods_hookExactClass("skills/traits/iron_lungs_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.iron_lungs";
		this.m.Name = "Iron Lungs";
		this.m.Icon = "ui/traits/trait_icon_33.png";
		this.m.Description = "This character will rarely run out of breath, whether swinging a heavy weapon or running across all the battlefield.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.fat",
			"trait.gluttonous",
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
				icon = "ui/icons/fatigue.png",
				text = ::green("+20") + " Endurance"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::green("+5") + " Fatigue Recovery"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.FatigueRecoveryRate += 5;
		_properties.Stamina += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "EnduranceTree");
	}

});

