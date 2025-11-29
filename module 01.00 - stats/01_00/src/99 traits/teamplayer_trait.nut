::mods_hookExactClass("skills/traits/teamplayer_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.teamplayer";
		this.m.Name = "Team Player";
		this.m.Icon = "ui/traits/trait_icon_58.png";
		this.m.Description = "This character makes sure to always announce their intentions to his brothers-in-arms. In fact, they\'ll never shut the hell up. At least it reduces the chance of accidents happening.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.drunkard",
			"trait.dumb",
			"trait.impatient",
			"trait.slack",
			"trait.double_tongued",
			"trait.bright",
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
				text = "Gives the commander perk tree. It is impossible to obtain otherwise"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::green("+20") + " Mettle"

			}
		];
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		// actor.getFlags().set("Commander", true);
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += 20;
	}

});

