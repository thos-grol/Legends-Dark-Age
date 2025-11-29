::mods_hookExactClass("skills/traits/huge_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.huge";
		this.m.Name = "Huge";
		this.m.Icon = "ui/traits/trait_icon_61.png";
		this.m.Description = "Being particularly huge and burly, this character\'s strikes hurt plenty, but they\'re also a bigger target than most.";
		this.m.Titles = [
			"the Mountain",
			"the Ox",
			"the Bear",
			"the Giant",
			"the Tower",
			"the Bull"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.quick",
			"trait.fragile",
			"trait.light",
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
				id = 11,
				type = "text",
				icon = "ui/icons/strength.png",
				text = ::green("+20") + " Strength"
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
		_properties.MeleeDefense += -10;
		_properties.RangedSkill += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "HealthTree");
		// ::Z.S.set_trait_tree(actor, "LargeTree");
	}

});

