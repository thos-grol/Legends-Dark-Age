::mods_hookExactClass("skills/traits/tiny_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.tiny";
		this.m.Name = "Tiny";
		this.m.Icon = "ui/traits/trait_icon_02.png";
		this.m.Description = "Being very short of height, this character is used to slipping through.";
		this.m.Titles = [
			"the Dwarf",
			"the Halfman",
			"the Short"
		];
		this.m.Excluded = [
			//remove Large Tree traits
			"trait.huge",
			"trait.strong",
			"trait.brute",
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
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/strength.png",
				text = ::red("– 20") + " Strength"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.RangedSkill -= 20;
		_properties.MeleeDefense += 10;
	}

	o.onAdded <- function() { }

});

