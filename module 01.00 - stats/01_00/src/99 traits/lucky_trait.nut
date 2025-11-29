//cursed item with bound by life must roll serialization id
//curse - bound by life -> effect that kills unit on combat start if they are missing the item
	//addserialized stacking effect (bound by death) - if player is missing item id on combat start, kill them

//curse trait, cursed trait

//effect has cursed points. onadded if cursedtrait dne add it.
	//cursedtrait onupdate - checks amount of curse points. if curse points not enough, -10 max hp for each curse point over. if max hp not enough, kill character

::mods_hookExactClass("skills/traits/lucky_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.lucky";
		this.m.Name = "Lucky";
		this.m.Icon = "ui/traits/trait_icon_54.png";
		this.m.Description = "Fate is certainty while luck is uncertainty. This character is has strong luck, blessed by the powers of Destiny.";
		this.m.Titles = [
			"the Lucky",
			"the Blessed"
		];
		this.m.Excluded = [
			"trait.pessimist",
			"trait.clumsy",
			"trait.ailing",
			"trait.clubfooted"
		];
	}

	o.onUpdate <- function( _properties )
	{
		_properties.RerollDefenseChance += getRerollChance();
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Lucky")) return;

		local tier = 1; //Lucky
		local roll = ::Math.rand(1, 100);
		if (roll <= 1) tier = 4; //Heaven Defying Fortune
		else if (roll <= 5) tier = 3; //Chosen
		else if (roll <= 20) tier = 2; //Fortunate
		actor.getFlags().set("Lucky", tier);
	}

	o.upgrade <- function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Lucky", ::Math.min(4, actor.getFlags().getAsInt("Lucky") + 1));
	}

	o.getRerollChance <- function()
	{
		local actor = this.getContainer().getActor();
		local luck_tier = getAdjustedLuckTier(actor.getFlags().getAsInt("Lucky"));

		switch(luck_tier)
		{
			case 0:
				return 0;
			case 1:
				return 10;
			case 2:
				return 30;
			case 3:
				return 50;
			case 4:
				return 90;
		}
	}

	o.getAdjustedLuckTier <- function(luck_tier)
	{
		local curse = getCursePoints();

		if (luck_tier == 4)
		{
			local luck = 8 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 8);
			if (curse == 0) return luck_tier;
		}

		if (luck_tier == 3)
		{
			local luck = 4 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 4);
			if (curse == 0) return luck_tier;
		}

		if (luck_tier == 2)
		{
			local luck = 2 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 2);
			if (curse == 0) return luck_tier;
		}

		if (luck_tier == 1)
		{
			local luck = 1 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 1);
			if (curse == 0) return luck_tier;
		}

		return luck_tier;
	}

	o.getLuckyPoints <- function()
	{
		local actor = this.getContainer().getActor();
		switch(actor.getFlags().getAsInt("Lucky"))
		{
			case 1:
				return 1;
			case 2:
				return 3;
			case 3:
				return 7;
			case 4:
				return 15;
		}
	}

	o.getCursePoints <- function()
	{
		local actor = this.getContainer().getActor();
		local curse = actor.getSkills().getSkillByID("effects.cursed");
		if (curse == null) return 0;
		return curse.getCursePoints();
	}

	o.getName <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Lucky")) return "Minor Luck";
		switch(actor.getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Minor Luck"
			case 2:
				return "Major Luck"
			case 3:
				return "Chosen"
			case 4:
				return "Fortune Rivalling Heaven"
		}
	}

	////// Tooltips

	o.getTooltip <- function()
	{
		local name = this.getName();
		local curse = getCursePoints();
		if (curse > 0) name += " (Suppressed)"

		local tooltip = [
			{
				id = 1,
				type = "title",
				text = name
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		getLuckTooltip(tooltip);

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = getCursePoints() + "/" + getLuckyPoints() + " Curses"
		});


		return tooltip;
	}

	o.getLuckTooltip <- function( _tooltip )
	{
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = getLuckTooltipHelper()
		});
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::green("+" + getRerollChance() + "%") + " chance to reroll an attack that hits this character"
		});

		return _tooltip;
	}

	o.getLuckTooltipHelper <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Lucky")) return "Things seem to go well once in a while for this character.";
		switch(this.getContainer().getActor().getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Things seem to go well once in a while for this character."
			case 2:
				return "Things seem to go well a lot for this character."
			case 3:
				return "This character is the chosen one. Their luck represents the trend of the world."
			case 4:
				return "This character's luck defies the balance of heaven. Their enemies might choke to death on air before hitting them."
		}
	}

});

