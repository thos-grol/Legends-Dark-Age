::mods_hookExactClass("skills/traits/dexterous_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.dexterous";
		this.m.Name = "Dexterous";
		this.m.Icon = "ui/traits/trait_icon_34.png";
		this.m.Description = "A dexterous character has an easier time hitting their opponent";
		this.m.Excluded = [
			"trait.clumsy",
			"trait.hesitant"
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
				icon = "ui/icons/melee_skill.png",
				text = ::green("+10") + " Attack"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MeleeSkill += 10;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "AgilityTree");

	}

});

