::mods_hookExactClass("skills/traits/sure_footing_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.sure_footing";
		this.m.Name = "Sure Footing";
		this.m.Icon = "ui/traits/trait_icon_05.png";
		this.m.Description = "A sure footing makes it hard to catch this character off balance and land a hit.";
		this.m.Excluded = [
			"trait.clumsy",
			"trait.insecure"
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
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MeleeDefense += 10;
	}

});

