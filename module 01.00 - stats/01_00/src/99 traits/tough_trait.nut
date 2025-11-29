::mods_hookExactClass("skills/traits/tough_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.tough";
		this.m.Name = "Tough";
		this.m.Icon = "ui/traits/trait_icon_14.png";
		this.m.Description = "This character is tough as nails, shrugging off hits and blows.";
		this.m.Titles = [
			"the Rock",
			"the Bull",
			"the Ox",
			"the Bear"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.fragile",
			"trait.bleeder",
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
				icon = "ui/icons/health.png",
				text = ::green("+20") + " Health"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Hitpoints += 20;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "HealthTree");
	}

});

