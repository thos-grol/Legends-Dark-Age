::mods_hookExactClass("skills/traits/brave_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.brave";
		this.m.Name = "Brave";
		this.m.Icon = "ui/traits/trait_icon_37.png";
		this.m.Description = "Just keep on going. This character will bravely venture into the unknown.";
		this.m.Titles = [
			"the Brave",
			"the Hero"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.insecure",
			"trait.craven",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.fearless",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins"
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
				text = ::green("+10") + " Mettle"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += 10;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "TenaciousTree");
	}

});

