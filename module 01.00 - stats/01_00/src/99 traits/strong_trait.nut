::mods_hookExactClass("skills/traits/strong_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.strong";
		this.m.Name = "Strong";
		this.m.Icon = "ui/traits/trait_icon_15.png";
		this.m.Description = "This character is exceptionally muscled and capable of impressive feats of strength";
		this.m.Titles = [
			"the Strong",
			"the Bull",
			"the Ox",
			"the Bear",
			"the Big"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.fragile",
			"trait.fat",
			"trait.ailing",
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
				id = 10,
				type = "text",
				icon = "ui/icons/strength.png",
				text = ::green("+20") + " Strength"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.RangedSkill += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		// ::Z.S.set_trait_tree(actor, "LargeTree");
	}

});

