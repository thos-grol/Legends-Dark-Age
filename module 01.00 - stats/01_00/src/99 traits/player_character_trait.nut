::mods_hookExactClass("skills/traits/player_character_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.player";
		this.m.Name = "Avatar";
		this.m.Icon = "ui/traits/trait_icon_63.png";
		this.m.Description = "This is your avatar. Die and it's game over.";
		this.m.Order = ::Const.SkillOrder.Trait - 1;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.loyal",
			"trait.disloyal",
			"trait.greedy"
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
				icon = "ui/icons/special.png",
				text = ::green("Immune to charm effects.")
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::green("Will never desert the company.")
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		
	}

});

