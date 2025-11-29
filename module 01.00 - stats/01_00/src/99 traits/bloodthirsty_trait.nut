::mods_hookExactClass("skills/traits/bloodthirsty_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.bloodthirsty";
		this.m.Name = "Bloodthirsty";
		this.m.Icon = "ui/traits/trait_icon_42.png";
		this.m.Description = "This character is prone to excessive violence and cruelty towards enemies. An opponent isn\'t good enough dead, their head needs to be on a spike!";
		this.m.Titles = [
			"the Butcher",
			"the Mad",
			"the Cruel"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.fainthearted",
			"trait.hesistant",
			"trait.craven",
			"trait.insecure",
			"trait.craven",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.teamplayer",

			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
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
				text = ::green("+50%") + " Fatality chance."
			}
		];
	}

	o.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		_properties.FatalityChanceMult *= 1.50;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		// actor.getFlags().set("Vicious", true);
	}

});

