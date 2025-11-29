::mods_hookExactClass("skills/traits/quick_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.quick";
		this.m.Name = "Quick";
		this.m.Icon = "ui/traits/trait_icon_18.png";
		this.m.Description = "Already there! This character is quick to act, often before opponents do.";
		this.m.Titles = [
			"the Quick"
		];
		this.m.Excluded = [
			"trait.huge",
			"trait.hesitant",
			"trait.clubfooted",
			"trait.slack",
			"trait.heavy",
			"trait.frail"
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
				icon = "ui/icons/initiative.png",
				text = ::green("+20") + " Agility"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Initiative += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "AgilityTree");

	}

});

