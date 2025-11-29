::mods_hookExactClass("skills/traits/old_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.old";
		this.m.Name = "Old";
		this.m.Icon = "skills/status_effect_60.png";
		this.m.Description = "Old age has finally caught up with this character.";
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+20[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-20[/color] Health"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-20[/color] Endurance"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-20[/color] Agility"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-1[/color] Vision"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
	}

	o.onUpdate <- function ( _properties )
	{
		_properties.Bravery += 20;
		_properties.Hitpoints -= 20;
		_properties.Stamina -= 20;
		_properties.Initiative -= 20;
		_properties.Vision -= 1;
		_properties.IsContentWithBeingInReserve = true;
	}

});

