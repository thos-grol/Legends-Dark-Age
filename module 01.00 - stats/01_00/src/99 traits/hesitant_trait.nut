::mods_hookExactClass("skills/traits/hesitant_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.hesitant";
		this.m.Name = "Slow";
		this.m.Icon = "ui/traits/trait_icon_25.png";
		this.m.Description = "Umm... well... maybe. This character is slow to act. But, they are also observant.";
		this.m.Titles = [
			"the Slow"
		];
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.deathwish",
			"trait.cocky",
			"trait.quick",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.impatient"
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
				text = ::red("– 20") + " Agility"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Initiative += -20;
	}

	o.onAdded <- function()
	{
		// local actor = this.getContainer().getActor();
		// ::Z.S.set_trait_tree(actor, "CalmTree");
	}

});

