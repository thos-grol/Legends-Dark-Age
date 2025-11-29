::mods_hookExactClass("skills/traits/fearless_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fearless";
		this.m.Name = "Fearless";
		this.m.Icon = "ui/traits/trait_icon_30.png";
		this.m.Description = "There are a lot of old friends to meet in the afterlife. This character is not afraid of death.";
		this.m.Titles = [
			"the Fearless"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.insecure",
			"trait.craven",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.brave",
			"trait.superstitious",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.slack"
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
				icon = "ui/icons/bravery.png",
				text = ::green("+20") + " Mettle"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "TenaciousTree");
	}

});

