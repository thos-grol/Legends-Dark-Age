::mods_hookExactClass("skills/special/mood_check", function (o)
{
	// DamageReceivedArmorMult
	o.getTooltip <- function()
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local p = actor.getCurrentProperties();

		local tooltip = this.skill.getTooltip();
		local details = get_ac();
		local level = actor.getLevel();

		if (level >= 11) 
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + 20 + "[/color] Attack"
			});
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + 40 + "[/color] Defense"
			});
		}
		else if (level >= 6)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + 10 + "[/color] Attack"
			});
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + 20 + "[/color] Defense"
			});
		}

		if (level == 5) tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "-90% XP gain at Level 5. Bottleneck"
		});
		else if (level == 10) tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "0% XP gain at Level 10. Bottleneck Find a way to break fate and change destiny!"
		});

		tt_proficiency(tooltip);

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::green(::Z.S.log_roundf(p.FatigueEffectMult) * 100) + "% Fatigue Cost (Skill)"
		});

		// tooltip.push({
		// 	id = 10,
		// 	type = "text",
		// 	icon = "ui/icons/fatigue.png",
		// 	text = "Fatality Chance Mult: " + ::green(p.FatalityChanceMult)
		// });

        tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Armor class: " + details.Name + " (" + ::green(details.Weight) + ") [" + details.Range + "]"
		});

		switch(details.Type)
		{
			case 1: //Light
			tt_ac_light(tooltip);
			break;

			case 2: //Medium
			tt_ac_medium(tooltip);
			break;

			case 3: //Heavy
			tt_ac_heavy(tooltip);
			break;
		}

		tt_skill(::Legends.Perk.Dodge, tooltip);
		tt_skill(::Legends.Perk.Nimble, tooltip);
		tt_skill(::Legends.Perk.Lithe, tooltip);
		tt_skill(::Legends.Perk.BattleForged, tooltip);
		
		// local hp = actor.getFlags().getAsInt("trainable_hitpoints");
		// local res = actor.getFlags().getAsInt("trainable_resolve");
		// local fat = actor.getFlags().getAsInt("trainable_fatigue");
		// local ini = actor.getFlags().getAsInt("trainable_initiative");
		// local mskill = actor.getFlags().getAsInt("trainable_meleeskill");
		// local mdef = actor.getFlags().getAsInt("trainable_meleedefense");
		// local rskill = actor.getFlags().getAsInt("trainable_rangedskill");
		// local rdef = actor.getFlags().getAsInt("trainable_rangeddefense");
		
		// if (hp > 0 
		// 	|| res > 0
		// 	|| fat > 0
		// 	|| ini > 0
		// 	|| mskill > 0
		// 	|| mdef > 0
		// 	|| rskill > 0
		// 	|| rdef > 0
		// )
		// {
		// 	tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/special.png",
		// 		text = "========================"
		// 	});
	
		// 	tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/warning.png",
		// 		text = "Trainable stats"
		// 	});
	
		// 	if (hp > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/health.png",
		// 		text = "" + hp
		// 	});
	
		// 	if (fat > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/fatigue.png",
		// 		text = "" + fat
		// 	});
	
		// 	if (ini > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/initiative.png",
		// 		text = "" + ini
		// 	});

		// 	if (res > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/bravery.png",
		// 		text = "" + res
		// 	});
	
		// 	if (mskill > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/melee_skill.png",
		// 		text = "" + mskill
		// 	});
	
		// 	if (mdef > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/melee_defense.png",
		// 		text = "" + mdef
		// 	});
	
		// 	if (rskill > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/strength.png",
		// 		text = "" + rskill
		// 	});
	
		// 	if (rdef > 0) tooltip.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/reflex.png",
		// 		text = "" + rdef
		// 	});
		// }

		tooltip = tt_mood(tooltip);
		return tooltip;
	}

	// =============================================================================================
	// Proficiency tooltips
	// =============================================================================================

	o.tt_proficiency <- function( _tooltip )
	{
		local actor = this.getContainer().getActor();
		local skill;
		local count = 0;

		local proficiencies = [
			"trait.proficiency_Axe",
			"trait.proficiency_Cleaver",
			"trait.proficiency_Sword",
			"trait.proficiency_Mace",
			"trait.proficiency_Hammer",
			"trait.proficiency_Flail",
			"trait.proficiency_Spear",
			"trait.proficiency_Polearm",
			"trait.proficiency_Fist",
			"trait.proficiency_Ranged",
		];

		foreach (proficiency in proficiencies)
		{
			skill = actor.getSkills().getSkillByID(proficiency);
			if (skill != null)
			{
				skill.getDetails(_tooltip);
				count += 1;
			}
		}

		if (count > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "========================"
			});
		}

		return _tooltip;
	}

// =============================================================================================
// Modular Tooltips: Light
// =============================================================================================

    o.tt_ac_light <- function( _tooltip )
	{
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Freedom of Movement: " + ::green("+x%") + " Melee DR proportional to the Agility difference between this and attacker. (Max 80% for a 100 difference)."
		});
		return _tooltip;
	}

// =============================================================================================
// Modular Tooltips: Medium
// =============================================================================================

	o.tt_ac_medium <- function( _tooltip)
	{
		local bonus = this.m.Stacks * 5;

        _tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Balance: " + ::green("+" + bonus + "%") + " DR. " + ::red("(Max 50%)\n") + ::green("+5%") + " when dodging.\n" + ::red("– 10%") + " when hit. " 
        });

		return _tooltip;
	}

// =============================================================================================
// Modular Tooltips: Heavy
// =============================================================================================

	o.tt_ac_heavy <- function( _tooltip)
	{
		local headBonus = this.get_bonus_ac_heavy(::Const.BodyPart.Head);
		local bodyBonus = this.get_bonus_ac_heavy(::Const.BodyPart.Body);
		if (headBonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::green("+" + headBonus + "%") + " Head DR (Health)"
			});
		}
		if (bodyBonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::green("+" + bodyBonus + "%") + " Body DR (Health)"
			});
		}
		return _tooltip;
	}

	// =============================================================================================
	// Modular Tooltips: Mood
	// =============================================================================================

	o.tt_mood <- function( _tooltip )
	{
		local changes = this.getContainer().getActor().getMoodChanges();

		foreach( change in changes )
		{
			if (change.Positive)
			{
				_tooltip.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/positive.png",
					text = "" + change.Text + ""
				});
			}
			else
			{
				_tooltip.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/negative.png",
					text = "" + change.Text + ""
				});
			}
		}
	}

	// =============================================================================================
	// Modular Tooltips: Helper
	// =============================================================================================

	o.tt_skill( _def, _tooltip )
	{
		local id = ::Legends.Perks.getID(_def);
		if (c.hasSkill(id))
		{
			c.getSkillByID(id).tt( _tooltip );
		}
	}

});



