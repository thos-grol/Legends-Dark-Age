::mods_hookExactClass("skills/traits/drunkard_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.drunkard";
		this.m.Name = "Drunkard";
		this.m.Icon = "ui/traits/trait_icon_29.png";
		this.m.Description = "There\'s no question what this character spends their crowns on. Expect them to drink heavily before any battle, in secret if need be. ";
		this.m.Titles = [
			"the Drunk",
			"the Drunkard"
		];
		this.m.Excluded = [
			"trait.teamplayer"
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
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+20%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-10[/color] Attack"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.DamageTotalMult *= 1.2;
		_properties.MeleeSkill += -10;
	}

});

