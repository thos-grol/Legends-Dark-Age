::mods_hookExactClass("skills/traits/clumsy_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.clumsy";
		this.m.Name = "Clumsy";
		this.m.Icon = "ui/traits/trait_icon_36.png";
		this.m.Description = "This character is clumsy and can be as dangerous for himself as to his opponent. However, it's usually these kinds of people that have unusual fortune.";
		this.m.Excluded = [
			"trait.weasel",
			"trait.dexterous",
			"trait.sure_footing",
			"trait.swift",
			"trait.lucky"
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
				text = ::red("– 10") + " Attack"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MeleeSkill += -10;
	}

	o.onAdded <- function()
	{
		local lucky = ::Legends.Traits.get(this, ::Legends.Trait.Lucky);
		if (lucky == null)
		{
			::Legends.Traits.grant(this, ::Legends.Trait.Lucky);
		}
		else
		{
			lucky.upgrade();
		}
	}

});

