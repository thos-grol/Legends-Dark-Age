::mods_hookExactClass("skills/traits/determined_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.determined";
		this.m.Name = "Determined";
		this.m.Icon = "ui/traits/trait_icon_31.png";
		this.m.Description = "Don\'t worry, I got this. This character shows a formidable amount of self-confidence.";
		this.m.Excluded = [
			"trait.weasel",
			"trait.dastard",
			"trait.insecure",
			"trait.fainthearted",
			"trait.craven",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.double_tongued"
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
				icon = "ui/icons/bravery.png",
				text = ::green("+10") + " Mettle"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will start combat at confident morale if permitted by mood"
			}
		];
	}

	o.onCombatStarted <- function()
	{
		local actor = this.getContainer().getActor();

		if (actor.getMoodState() >= ::Const.MoodState.Neutral && actor.getMoraleState() < ::Const.MoraleState.Confident)
		{
			actor.setMoraleState(::Const.MoraleState.Confident);
		}
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Bravery += 10;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		::Z.S.set_trait_tree(actor, "TenaciousTree");

	}

});

