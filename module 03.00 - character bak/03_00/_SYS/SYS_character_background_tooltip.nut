// modifies the tooltip to use new stat icons
::mods_hookExactClass("skills/backgrounds/character_background", function(o)
{
    o.getAttributesTooltip <- function()
	{
		if (this.getContainer().getActor().getLevel() >= 11) {
			return [];
		}

		local calculateAttribute = function(attribute, maximum = false)
		{
			local bro = this.getContainer().getActor();
			local attributeMin = ::Const.AttributesLevelUp[attribute].Min + ::Math.min(bro.m.Talents[attribute], 2);
			local attributeMax = ::Const.AttributesLevelUp[attribute].Max;
			if (bro.m.Talents[attribute] == 3) attributeMax += 1;
			local levelUps = ::Math.max(11 - bro.getLevel() + bro.getLevelUps(), 0);
			local attributeValue = maximum ? attributeMax * levelUps : attributeMin * levelUps;

			switch (attribute)
			{
				case ::Const.Attributes.Hitpoints:
					return attributeValue + bro.getBaseProperties().Hitpoints;
					break;
				case ::Const.Attributes.Bravery:
					return attributeValue + bro.getBaseProperties().Bravery;
					break;
				case ::Const.Attributes.Fatigue:
					return attributeValue + bro.getBaseProperties().Stamina;
					break;
				case ::Const.Attributes.Initiative:
					return attributeValue + bro.getBaseProperties().Initiative;
					break;
				case ::Const.Attributes.MeleeSkill:
					return attributeValue + bro.getBaseProperties().MeleeSkill;
					break;
				case ::Const.Attributes.RangedSkill:
					return attributeValue + bro.getBaseProperties().RangedSkill;
					break;
				case ::Const.Attributes.MeleeDefense:
					return attributeValue + bro.getBaseProperties().MeleeDefense;
					break;
				case ::Const.Attributes.RangedDefense:
					return attributeValue + bro.getBaseProperties().RangedDefense;
					break;
				default:
					return 0;
					break;
			}
		}

		local a = {
			Hitpoints = [
				calculateAttribute(::Const.Attributes.Hitpoints),
				calculateAttribute(::Const.Attributes.Hitpoints, true)
			],
			Bravery = [
				calculateAttribute(::Const.Attributes.Bravery),
				calculateAttribute(::Const.Attributes.Bravery, true)
			],
			Fatigue = [
				calculateAttribute(::Const.Attributes.Fatigue),
				calculateAttribute(::Const.Attributes.Fatigue, true)
			],
			Initiative = [
				calculateAttribute(::Const.Attributes.Initiative),
				calculateAttribute(::Const.Attributes.Initiative, true)
			],
			MeleeSkill = [
				calculateAttribute(::Const.Attributes.MeleeSkill),
				calculateAttribute(::Const.Attributes.MeleeSkill, true)
			],
			RangedSkill = [
				calculateAttribute(::Const.Attributes.RangedSkill),
				calculateAttribute(::Const.Attributes.RangedSkill, true)
			],
			MeleeDefense = [
				calculateAttribute(::Const.Attributes.MeleeDefense),
				calculateAttribute(::Const.Attributes.MeleeDefense, true)
			],
			RangedDefense = [
				calculateAttribute(::Const.Attributes.RangedDefense),
				calculateAttribute(::Const.Attributes.RangedDefense, true)
			]
		};

		local bufferHealth = "";
		local bufferFatigue = "";
		local bufferBravery = "";
		local bufferInitiative = "";

		if (a.Hitpoints[0] >= 100)
		{
			bufferFatigue += "&nbsp;&nbsp;";
			bufferBravery += "&nbsp;&nbsp;";
			bufferInitiative += "&nbsp;&nbsp;";
		}
		if (a.Hitpoints[1] >= 100)
		{
			bufferFatigue += "&nbsp;&nbsp;";
			bufferBravery += "&nbsp;&nbsp;";
			bufferInitiative += "&nbsp;&nbsp;";
		}
		if (a.Fatigue[0] >= 100)
		{
			bufferHealth += "&nbsp;&nbsp;";
			bufferBravery += "&nbsp;&nbsp;";
			bufferInitiative += "&nbsp;&nbsp;";
		}
		if (a.Fatigue[1] >= 100)
		{
			bufferHealth += "&nbsp;&nbsp;";
			bufferBravery += "&nbsp;&nbsp;";
			bufferInitiative += "&nbsp;&nbsp;";
		}
		if (a.Bravery[0] >= 100)
		{
			bufferHealth += "&nbsp;&nbsp;";
			bufferFatigue += "&nbsp;&nbsp;";
			bufferInitiative += "&nbsp;&nbsp;";
		}
		if (a.Bravery[1] >= 100)
		{
			bufferHealth += "&nbsp;&nbsp;";
			bufferFatigue += "&nbsp;&nbsp;";
			bufferInitiative += "&nbsp;&nbsp;";
		}
		if (a.Initiative[0] >= 100)
		{
			bufferHealth += "&nbsp;&nbsp;";
			bufferFatigue += "&nbsp;&nbsp;";
			bufferBravery += "&nbsp;&nbsp;";
		}
		if (a.Initiative[1] >= 100)
		{
			bufferHealth += "&nbsp;&nbsp;";
			bufferFatigue += "&nbsp;&nbsp;";
			bufferBravery += "&nbsp;&nbsp;";
		}

		local tooltip = [
			{
				id = 103,
				type = "hint",
				text = "Projection of this character\'s base attribute ranges calculated as if that attribute is improved on every level up from current level to 11."
			},
			{
				id = 104,
				type = "hint",
				text = "[img]gfx/ui/icons/health_va11.png[/img] " + a.Hitpoints[0] + " to " + a.Hitpoints[1] + bufferHealth + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_skill_va11.png[/img] " + a.MeleeSkill[0] + " to " + a.MeleeSkill[1]
			},
			{
				id = 105,
				type = "hint",
				text = "[img]gfx/ui/icons/fatigue_va11.png[/img] " + a.Fatigue[0] + " to " + a.Fatigue[1] + bufferFatigue + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_defense_va11.png[/img] " + a.MeleeDefense[0] + " to " + a.MeleeDefense[1]
			},
			{
				id = 106,
				type = "hint",
				text = "[img]gfx/ui/icons/bravery_va11.png[/img] " + a.Bravery[0] + " to " + a.Bravery[1] + bufferBravery + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/strength_s.png[/img] " + a.RangedSkill[0] + " to " + a.RangedSkill[1]
			},
			{
				id = 107,
				type = "hint",
				text = "[img]gfx/ui/icons/initiative_va11.png[/img] " + a.Initiative[0] + " to " + a.Initiative[1] + bufferInitiative + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/reflex_s.png[/img] " + a.RangedDefense[0] + " to " + a.RangedDefense[1]
			}
		];

		return tooltip;
	}
});