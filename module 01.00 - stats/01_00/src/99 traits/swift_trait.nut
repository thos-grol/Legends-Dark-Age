::mods_hookExactClass("skills/traits/swift_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.swift";
		this.m.Name = "Swift";
		this.m.Icon = "ui/traits/trait_icon_53.png";
		this.m.Description = "This character has impressive reactions...";
		this.m.Titles = [
			"the Swift",
			"Quickfeet"
		];
		this.m.Excluded = [
			"trait.clumsy",
			"trait.fat",
			"trait.clubfooted",
			"trait.predictable",
			"trait.asthmatic"
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
				icon = "ui/icons/ranged_defense.png",
				text = ::green("+20") + " Instinct"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.RangedDefense += 20;
	}

	o.onAdded <- function()
	{
		// local actor = this.getContainer().getActor(); 		
        // ::Z.S.set_trait_tree(actor, "CalmTree");
	}

});

