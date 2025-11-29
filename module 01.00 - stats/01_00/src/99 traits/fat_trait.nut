::mods_hookExactClass("skills/traits/fat_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fat";
		this.m.Name = "Fat";
		this.m.Icon = "ui/traits/trait_icon_10.png";
		this.m.Description = "This character is more interested in pork chops than exercising, and will run out of breath more easily. Better bring extra provisions when traveling with this character and expect them to leave fast if you ever run out of provisions entirely.";
		this.m.Titles = [
			"the Fat",
			"the Ox",
			"the Mountain",
			"the Pig",
			"the Swine"
		];
		this.m.Excluded = [
			"trait.athletic",
			"trait.swift",
			"trait.quick",
			"trait.strong",
			"trait.spartan",
			"trait.swift",
			"trait.iron_lungs",
			"trait.fragile",
			"trait.light"
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::red("– 20") + " Endurance"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = ::red("+4") + " Daily Food Cost"
			},
		];
	}

	o.onAdded <- function()
	{
		if (!this.m.IsNew) return;

		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "HealthTree");


		if (actor.getEthnicity() == 1)
		{
			actor.getSprite("body").setBrush("bust_naked_body_southern_02");
		}
		else
		{
			actor.getSprite("body").setBrush("bust_naked_body_02");
		}
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Hitpoints += 20;
		_properties.Stamina -= 20;
	}

});

