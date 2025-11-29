//This file hooks tooltip events to modify the tooltips we want
::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {
local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
o.general_queryUIElementTooltipData = function (_entityId, _elementId, _elementOwner )
{
	local entity;
	if (_entityId != null) entity = this.Tactical.getEntityByID(_entityId);
	
	switch(_elementId)
	{
		//stats
		case "character-stats.Hitpoints":
			return [
				{
					id = 1,
					type = "title",
					text = "Health"
				},
				{
					id = 2,
					type = "description",
					text = "The dwelling-place of the soul. [The ninth of the nine parts of the soul; the only one that can be touched.]\n\nHealth represents the amount of damage this character can take before dying.\n\nInjuries are inflicted when...\n\nDamage is rounded down after processing, except when it's > 0 and < 1. Then it becomes 1."
				}
				//TODO: write more on injury thresholds.
			];

		case "character-stats.Morale":
			return [
				{
					id = 1,
					type = "title",
					text = "Morale"
				},
				{
					id = 2,
					type = "description",
					text = "Morale is one of five states and represents the mental condition of combatants and their effectiveness in battle. At the lowest state, fleeing, a character will be outside your control - although they may eventually rally again. Morale changes as the battle unfolds, with characters that have high resolve less likely to fall to low morale states. Many of your opponents are affected by morale as well.\n\nMorale checks trigger on these occasions:\n- Killing an enemy\n- Seeing an enemy be killed\n- Seeing an ally be killed\n- Seeing an ally flee\n- Being hit for 15 or more damage to hitpoints\n- Being engaged by more than one opponent\n- Using certain skills, like \'Rally\'"
				}
			];

		case "character-stats.Fatigue":
			return [
				{
					id = 1,
					type = "title",
					text = "Endurance"
				},
				{
					id = 2,
					type = "description",
					text = "The power of the body to keep holding on.\n\nEndurance increases the amount of Fatigue a character can bear, and thus actions they can do. It also increases the potency of certain perks and skills.\n\nFatigue is gained for every action, when being hit, or dodging. On turn start, Fatigue recovers by 15."
				}
			];

		case "character-stats.MaximumFatigue":
			return [
				{
					id = 1,
					type = "title",
					text = "Maximum Fatigue"
				},
				{
					id = 2,
					type = "description",
					text = "Maximum Fatigue is the amount of fatigue a character can accumulate before being unable to take any more actions and having to recuperate. It is reduced by wearing heavy equipment, especially armor."
				}
			];

		case "character-stats.ArmorHead":
			return [
				{
					id = 1,
					type = "title",
					text = "Head Armor"
				},
				{
					id = 2,
					type = "description",
					text = "Armor description here. With some exceptions, all damage must deplete armor first before damaging Health.\nHardness is a stat related to armor that is a flat reduction to incoming damage."
				}
				//TODO: armor description
			];

		case "character-stats.ArmorBody":
			return [
				{
					id = 1,
					type = "title",
					text = "Body Armor"
				},
				{
					id = 2,
					type = "description",
					text = " The more body armor, the less damage will be applied to hitpoints on taking a hit to the body."
				}
				//TODO: armor description
			];

		case "character-stats.MeleeSkill":
			return [
				{
					id = 1,
					type = "title",
					text = "Skill"
				},
				{
					id = 2,
					type = "description",
					text = "The ability to hit attacks. \n\n Between hit and miss chances, there is now a graze band that takes up to 10 points from each side. Grazes deal 50% damage. ie. character with 40 Skill strikes a 0 defense character. The chances are 50% miss, 20% graze, and 30% hit. Grazes soften the disparity between hit and miss, and also decreases the chance of landing a solid hit. However when calculating at 90. 0% miss, 10% graze, 90% hit."
				}
			];

			//TODO: write about graze band here

		case "character-stats.RangeSkill":
			return [
				{
					id = 1,
					type = "title",
					text = "X"
				},
				{
					id = 2,
					type = "description",
					text = "X"
				}
			];

		case "character-stats.MeleeDefense":
			return [
				{
					id = 1,
					type = "title",
					text = "Defense"
				},
				{
					id = 2,
					type = "description",
					text = "The ability to not get hit.\n\nDefense reduces the probability of being hit with attacks."
				}
			];

		case "character-stats.RangeDefense":
			return [
				{
					id = 1,
					type = "title",
					text = "X"
				},
				{
					id = 2,
					type = "description",
					text = "X"
				}
			];

		case "character-stats.SightDistance":
			return [
				{
					id = 1,
					type = "title",
					text = "Vision"
				},
				{
					id = 2,
					type = "description",
					text = "Vision, or view range, determines how far a character can see to uncover the fog of war, discover threats and hit with ranged attacks. Heavier helmets and night time can reduce vision."
				}
			];

		case "character-stats.RegularDamage":
			return [
				{
					id = 1,
					type = "title",
					text = "Damage"
				},
				{
					id = 2,
					type = "description",
					text = "The base damage the currently equipped weapon does. Will be applied in full against hitpoints if no armor is protecting the target. If the target is protected by armor, the damage is applied to armor instead based on the weapon\'s effectiveness against armor. The actual damage done is modified by the skill used and the target hit."
				}
			];

		case "character-stats.CrushingDamage":
			return [
				{
					id = 1,
					type = "title",
					text = "Effectiveness against Armor"
				},
				{
					id = 2,
					type = "description",
					text = "The base percentage of damage that will be applied when hitting a target protected by armor. Once the armor is destroyed, the weapon damage applies at 100% to hitpoints. The actual damage done is modified by the skill used and the target hit."
				}
			];

		case "character-stats.ChanceToHitHead":
			return [
				{
					id = 1,
					type = "title",
					text = "Chance to hit head"
				},
				{
					id = 2,
					type = "description",
					text = "The base percentage chance to hit a target\'s head for increased damage. The final chance can be modified by the skill used."
				}
			];

		case "character-stats.Initiative":
			return [
				{
					id = 1,
					type = "title",
					text = "Agility"
				},
				{
					id = 2,
					type = "description",
					text = "Freedom; The ability to move however and whenever one wants.\n\nAgility determines turn order, and is reduced by any form of Fatigue."
				}
			];

		case "character-stats.Bravery":
			return [
				{
					id = 1,
					type = "title",
					text = "Mettle"
				},
				{
					id = 2,
					type = "description",
					text = "Will; self-discipline; that part of us which makes the right choice. [One of the nine parts of the human soul.]\n\nMettle provides:\n- resistance to mental attacks, \n-the effects of negative events on morale, \n-while increasing the chance characters gain morale from positive events."
				}
			];
	}

	return general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
}});
