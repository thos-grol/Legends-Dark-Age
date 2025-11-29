::mods_hookExactClass("skills/traits/cocky_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.cocky";
		this.m.Name = "Cocky";
		this.m.Icon = "ui/traits/trait_icon_24.png";
		this.m.Description = "All too easy! This character can be a bit too cocky for his own good. ";
		this.m.Titles = [
			"the Brave",
			"the Braggart"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.hesitant",
			"trait.pessimist",
			"trait.dastard",
			"trait.insecure",
			"trait.craven",
			"trait.fainthearted",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+20[/color] Mettle"
				text = ::green("+20") + " Mettle"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::red("– 10") + " Defense"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += 20;
		_properties.MeleeDefense += -10;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "TenaciousTree");
	}

});

