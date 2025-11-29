::mods_hookExactClass("skills/traits/brute_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.brute";
		this.m.Name = "Brute";
		this.m.Icon = "ui/traits/trait_icon_01.png";
		this.m.Description = "This character lacks coordination, but makes up for it in strength.";
		this.m.Titles = [
			"the Bull",
			"the Ox",
			"the Hammer"
		];
		this.m.Excluded = [
			"trait.pragmatic",
			"trait.tiny",
			"trait.fragile",
			"trait.insecure",
			"trait.hesitant",
			"trait.light",
			"trait.frail",
			"trait.bright"
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
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::red("– 10") + " Attack"

			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MeleeSkill += -10;
		_properties.RangedSkill += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		// ::Z.S.set_trait_tree(actor, "LargeTree");
	}

});

