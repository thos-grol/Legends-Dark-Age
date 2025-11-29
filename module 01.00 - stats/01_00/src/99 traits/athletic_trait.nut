::mods_hookExactClass("skills/traits/athletic_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.athletic";
		this.m.Name = "Athletic";
		this.m.Icon = "ui/traits/trait_icon_21.png";
		this.m.Description = "This character is physically fit.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clubfooted",
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
				text = ::green("– 2") + " Fatigue gained for each tile travelled"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MovementFatigueCostAdditional += -2;
		_properties.Stamina += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "EnduranceTree");
	}

});

