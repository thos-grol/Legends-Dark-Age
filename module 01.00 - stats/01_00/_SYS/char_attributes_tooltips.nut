::mods_hookExactClass("skills/backgrounds/character_background", function(o)
{
    o.getAttributesTooltip <- function()
	{
		if (this.getContainer().getActor().getLevel() >= 7) {
			return [];
		}

        local c = this.getContainer();
		local actor = c.getActor();
		local f = actor.getFlags();
		local p = actor.getBaseProperties();

		local _class = null;
		if (f.has("Class")) _class = f.get("Class");
        if (_class == null) return [
			{
				id = 103,
				type = "hint",
				text = ::red("This character does not have a class yet to do a stat growth projection")
			},
		];

        local class_stats = ::DEF.C.Stats.Class[_class];
		if (!f.has("Level Updated To")) return [
			{
				id = 103,
				type = "hint",
				text = ::red("Applying level updates, check again later")
			},
		];
		local lvl_update = f.getAsInt("Level Updated To");
		local lvl_next = lvl_update + 1;

		local a = {
			Hitpoints = [
				p.Hitpoints,
				::DEF.C.Stats.Base["Hitpoints"] + ::Z.S.sum_arr(class_stats["Hitpoints"]),
				class_stats["Hitpoints"][lvl_next]
			],
			Bravery = [
				p.Bravery,
				::DEF.C.Stats.Base["Bravery"] + ::Z.S.sum_arr(class_stats["Mettle"]),
				class_stats["Mettle"][lvl_next]
			],
			Fatigue = [
				p.Stamina,
				::DEF.C.Stats.Base["Stamina"] + ::Z.S.sum_arr(class_stats["Endurance"]),
				class_stats["Endurance"][lvl_next]
			],
			Initiative = [
				p.Initiative,
				::DEF.C.Stats.Base["Initiative"] + ::Z.S.sum_arr(class_stats["Agility"]),
				class_stats["Agility"][lvl_next]
			],
			MeleeSkill = [
				p.MeleeSkill,
				::DEF.C.Stats.Base["MeleeSkill"] + ::Z.S.sum_arr(class_stats["Skill"]),
				class_stats["Skill"][lvl_next]
			],
			RangedSkill = [
				15 + class_stats["Recovery"][lvl_update],
				15 + class_stats["Recovery"][7],
				class_stats["Recovery"][lvl_next] - class_stats["Recovery"][lvl_update]
			],
			MeleeDefense = [
				p.MeleeDefense,
				::DEF.C.Stats.Base["MeleeDefense"] + ::Z.S.sum_arr(class_stats["Defense"]),
				class_stats["Defense"][lvl_next]
			],
			RangedDefense = [
				0,
				0
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
				text = ::red("Projection of this character\'s maximum attribute growth. In parenthesis are stats gained on the next level up")
			},
			{
				id = 104,
				type = "hint",
				text = "[img]gfx/ui/icons/fatigue_va11.png[/img] " + a.Fatigue[0] + " / " + a.Fatigue[1] + " (" + a.Fatigue[2] + ") " + bufferFatigue + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/fatigue_va11.png[/img] " + a.RangedSkill[0] + " / " + a.RangedSkill[1] + " (" + a.RangedSkill[2] + ") "
			},
			{
				id = 105,
				type = "hint",
				text = "[img]gfx/ui/icons/health_va11.png[/img] " + a.Hitpoints[0] + " / " + a.Hitpoints[1] + " (" + a.Hitpoints[2] + ") " + bufferHealth + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_skill_va11.png[/img] " + a.MeleeSkill[0] + " / " + a.MeleeSkill[1] + " (" + a.MeleeSkill[2] + ") "
			},
			{
				id = 106,
				type = "hint",
				text = "[img]gfx/ui/icons/bravery_va11.png[/img] " + a.Bravery[0] + " / " + a.Bravery[1] + " (" + a.Bravery[2] + ") " + bufferBravery + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_defense_va11.png[/img] " + a.MeleeDefense[0] + " / " + a.MeleeDefense[1] + " (" + a.MeleeDefense[2] + ") "
			},
			{
				id = 107,
				type = "hint",
				text = "[img]gfx/ui/icons/initiative_va11.png[/img] " + a.Initiative[0] + " / " + a.Initiative[1] + " (" + a.Initiative[2] + ") " + bufferInitiative
			}
		];

		return tooltip;
	}
});