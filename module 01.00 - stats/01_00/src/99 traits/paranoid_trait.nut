::mods_hookExactClass("skills/traits/paranoid_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.paranoid";
		this.m.Name = "Paranoid";
		this.m.Icon = "ui/traits/trait_icon_55.png";
		this.m.Description = "This character is extra cautious and reluctant to move ahead.";
		this.m.Titles = [
			"the Crazy",
			"the Paranoid"
		];
		this.m.Excluded = [
			"trait.optimist",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.ambitious",
			"trait.seductive",
			"trait.natural"
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
				icon = "ui/icons/melee_defense.png",
				text = ::green("+10") + " Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::red("– 20") + " Agility"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.Initiative += -20;
	}

	o.onAdded <- function()
	{
		// local actor = this.getContainer().getActor(); 		
        // ::Z.S.set_trait_tree(actor, "CalmTree");
	}

});

