::mods_hookExactClass("skills/special/mood_check", function (o)
{
    o.m.Stacks <- 0;
	o.m.MaxStacks <- 10;

    o.create = function()
	{
		this.m.ID = "special.mood_check";
		this.m.Name = "Details";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;
	}

    o.getDescription <- function()
	{
		return "Provides details about the character's progression and armor.";
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();
		local details = getTooltip_Details();
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();

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

		getTooltip_Proficiency(tooltip);

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Skill Fatigue Mult: " + ::MSU.Text.colorGreen(p.FatigueEffectMult)
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Fatality Chance Mult: " + ::MSU.Text.colorGreen(p.FatalityChanceMult)
		});

        tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Armor class: " + details.Name + " (" + ::MSU.Text.colorGreen(details.Weight) + ") [" + details.Range + "]"

		});

		switch(details.Type)
		{
			case 1: //Light
			getTooltip_FreedomOfMovement(tooltip);
			break;

			case 2: //Medium
			getTooltip_MediumArmor(tooltip);
			break;

			case 3: //Heavy
			getTooltip_ManOfSteel(tooltip);
			break;
		}

		if (this.getContainer().hasSkill("perk.nimble")) getTooltip_Nimble(tooltip);
		if (this.getContainer().hasSkill("perk.legend_lithe")) getTooltip_Lithe(tooltip);
		if (this.getContainer().hasSkill("perk.battle_forged")) getTooltip_Battleforged(tooltip);
		if (this.getContainer().hasSkill("effects.dodge")) getTooltip_Dodge(tooltip);

		local hp = actor.getFlags().getAsInt("trainable_hitpoints");
		local res = actor.getFlags().getAsInt("trainable_resolve");
		local fat = actor.getFlags().getAsInt("trainable_fatigue");
		local ini = actor.getFlags().getAsInt("trainable_initiative");
		local mskill = actor.getFlags().getAsInt("trainable_meleeskill");
		local mdef = actor.getFlags().getAsInt("trainable_meleedefense");
		local rskill = actor.getFlags().getAsInt("trainable_rangedskill");
		local rdef = actor.getFlags().getAsInt("trainable_rangeddefense");
		
		if (hp > 0 
			|| res > 0
			|| fat > 0
			|| ini > 0
			|| mskill > 0
			|| mdef > 0
			|| rskill > 0
			|| rdef > 0
		)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "========================"
			});
	
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Trainable stats"
			});
	
			if (hp > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = "" + hp
			});
	
			if (fat > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "" + fat
			});
	
			if (ini > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "" + ini
			});

			if (res > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "" + res
			});
	
			if (mskill > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "" + mskill
			});
	
			if (mdef > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "" + mdef
			});
	
			if (rskill > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/strength.png",
				text = "" + rskill
			});
	
			if (rdef > 0) tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/reflex.png",
				text = "" + rdef
			});
		}

		tooltip = getTooltip_old(tooltip);

		return tooltip;
	}

	o.getTooltip_old <- function(ret)
	{
		local changes = this.getContainer().getActor().getMoodChanges();

		foreach( change in changes )
		{
			if (change.Positive)
			{
				ret.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/positive.png",
					text = "" + change.Text + ""
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/negative.png",
					text = "" + change.Text + ""
				});
			}
		}

		return ret;
	}

	// =============================================================================================
	// Proficiency tooltips
	// =============================================================================================

	o.getTooltip_Proficiency <- function( _tooltip )
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
	// Logic
	// =============================================================================================



    o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		local total_weight = getTotalWeight();
        if (total_weight <= 20) // Freedom of Movement
        {
            if (_attacker == null) return;
            if (_skill == null) return;

			if (!_skill.isAttack() || _skill.isRanged() || !_skill.isUsingHitchance()) return;
			if (_attacker.getID() == this.getContainer().getActor().getID()) return;

			if ( _attacker.getSkills().getSkillByID("perk.stance.seismic_slam") != null) return;
			if ( _attacker.getSkills().getSkillByID("perk.class.continuance_knight") != null) return;
			if ( _attacker.getSkills().getSkillByID("perk.strange_strikes") != null) return;
			if ( _attacker.getSkills().getSkillByID("actives.horrific_scream") != null) return;

            local ourCurrentInitiative = this.getContainer().getActor().getInitiative();
            local enemyCurrentInitiative = _attacker.getInitiative();
            local bonus = 1;
            if (ourCurrentInitiative > enemyCurrentInitiative)
            {
                local diff = (ourCurrentInitiative - enemyCurrentInitiative) / 100.0;
                local diffPoint = ::Math.minf(1, ::Math.pow(diff, 0.4)) * 0.8;
                bonus = 1 - diffPoint;
            }
			_properties.DamageReceivedRegularMult *= bonus;

			bonus = 1 - bonus;
			if (bonus > 0) ::Tactical.EventLog.logIn(
				"[Freedom of Movement] -" + (::Z.Log.roundFloat(bonus, 2) * 100) + "% damage"
			);
        }
        else if (total_weight > 20 && total_weight <= 40) // Medium Armor
        {
            if (_attacker != null && _skill != null && _skill.isAttack())
			{
				local bonus = this.m.Stacks * 0.05;
				_properties.DamageReceivedRegularMult *= 1 - bonus;
				this.m.Stacks = ::Math.max(0, this.m.Stacks - 2);
				if (bonus > 0) ::Tactical.EventLog.logIn(
					"[Medium Armor Passive] -" + (::Z.Log.roundFloat(bonus, 2) * 100) + "% damage"
				);
			}
        }
		else //Man of steel
		{
			if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;
			local bonus = this.getBonus_ManOfSteel(_hitInfo.BodyPart) * 0.01;
			_properties.DamageReceivedDirectMult *= 1.0 - bonus;
			if (bonus > 0) ::Tactical.EventLog.logIn(
				"[Man of Steel] -" + (::Z.Log.roundFloat(bonus, 2)  * 100) + "% hitpoint damage"
			);
		}
	}

    o.getTotalWeight <- function()
    {
        return this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
    }

// =============================================================================================
// Medium Armor
// =============================================================================================

	o.onMissed <- function( _attacker, _skill )
	{
		local total_weight = getTotalWeight();
		if (total_weight > 20 && total_weight <= 40)
        {
            if (_attacker != null && _skill != null && _skill.isAttack() && !_skill.isRanged()) this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
        }

	}

// =============================================================================================
// Helper Fns
// =============================================================================================

	o.getTooltip_Details <- function(  )
	{
		local ret = {
			Weight = getTotalWeight()
		};

		if (ret.Weight <= 20)
		{
			ret.Name <- "Light";
			ret.Type <- 1;
			ret.Range <- "0 - 20";
		}
        else if (ret.Weight <= 40)
		{
			ret.Name <- "Medium";
			ret.Type <- 2;
			ret.Range <- "21 - 40";
		}
        else
		{
			ret.Name <- "Heavy";
			ret.Type <- 3;
			ret.Range <- "40+";
		}

		return ret;
	}

// =============================================================================================
// Modular Tooltips: Light
// =============================================================================================

    o.getTooltip_FreedomOfMovement <- function( _tooltip )
	{
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Freedom of Movement: " + ::MSU.Text.colorGreen("– x%") + " damage taken proportional to the initiative difference between the attacker and this unit for melee attacks. (Max 80% for a 100 difference)."
		});
		return _tooltip;
	}

	o.getTooltip_Nimble <- function( _tooltip )
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Head);
		if (body != null) fat = fat + body.getStaminaModifier();
		if (head != null) fat = fat + head.getStaminaModifier();
		fat = ::Math.min(0, fat + 15);
		local ret = ::Math.minf(1.0, 1.0 - 0.6 + ::Math.pow(::Math.abs(fat), 1.23) * 0.01);
		local fm = ::Math.floor(ret * 100);

		if (fm > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Nimble: " + ::MSU.Text.colorGreen("– " + fm + "%") + " hitpoint damage taken"
			});
		}

		return _tooltip;
	}

	o.getTooltip_Dodge <- function( _tooltip )
	{
		local initiative = ::Math.max(0, ::Math.floor(this.getContainer().getActor().getInitiative() * 0.15));
		if (initiative == 0) return _tooltip;
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "Dodge: " + ::MSU.Text.colorGreen("+" + initiative) + " Melee and Ranged Defense"
		});
		return _tooltip;
	}

// =============================================================================================
// Modular Tooltips: Medium
// =============================================================================================

	o.getTooltip_MediumArmor <- function( _tooltip)
	{
		local bonus = this.m.Stacks * 5;

        _tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Medium Armor Protection: " + ::MSU.Text.colorGreen("– " + bonus + "%") + " damage taken. " + ::MSU.Text.colorGreen("+5%") + " upon dodging. " + ::MSU.Text.colorGreen("– 10%") + " when hit. " + ::MSU.Text.colorRed("(50% Max)")
        });

		return _tooltip;
	}

	o.Lithe_getArmorFatPenMult <- function ( _totalArmorStaminaModifier )
	{
		_totalArmorStaminaModifier = _totalArmorStaminaModifier * -1;
		local steepnessFactor = 2.5999999;
		local armorIdealMin = 25;
		local armorIdealMax = 35;
		local mult = 1;

		if (_totalArmorStaminaModifier < armorIdealMin)
		{
			mult = ::Math.maxf(0, 1 - 0.01 * ::Math.pow(armorIdealMin - _totalArmorStaminaModifier, steepnessFactor));
		}
		else if (_totalArmorStaminaModifier > armorIdealMax)
		{
			mult = ::Math.maxf(0, 1 - 0.01 * ::Math.pow(_totalArmorStaminaModifier - armorIdealMax, steepnessFactor));
		}

		return mult;
	}

	o.Lithe_getBonus <- function()
	{
		local actor = this.getContainer().getActor();
		local bodyitem = actor.getBodyItem();

		if (bodyitem == null) return 0;

		local armorFatMult = Lithe_getArmorFatPenMult(actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head
		]));

		local bonus = ::Math.maxf(0, ::Math.minf(35, 35 * armorFatMult));
		return ::Math.floor(bonus);
	}

	o.getTooltip_Lithe <- function( _tooltip)
	{
		local bonus = Lithe_getBonus();
		if (bonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Lithe: " + ::MSU.Text.colorGreen("– " + (100 - bonus) + "%") + " damage taken"
			});
			return _tooltip;
		}

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Lithe: No damage reduction because this unit is not wearing any body armor."
			});
			return tooltip;
		}

		return _tooltip;
	}

// =============================================================================================
// Modular Tooltips: Heavy
// =============================================================================================

	o.getBonus_ManOfSteel <- function( _bodyPart )
	{
		return ::Math.min(100, this.getContainer().getActor().getArmor(_bodyPart) * 0.1);
	}

	o.getTooltip_ManOfSteel <- function( _tooltip)
	{
		local headBonus = this.getBonus_ManOfSteel(::Const.BodyPart.Head);
		local bodyBonus = this.getBonus_ManOfSteel(::Const.BodyPart.Body);
		if (headBonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::MSU.Text.colorGreen("– " + headBonus + "%") + " hitpoint damage taken " + ::MSU.Text.colorRed("(Head)")
			});
		}
		if (bodyBonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::MSU.Text.colorGreen("– " + bodyBonus + "%") + " hitpoint damage taken " + ::MSU.Text.colorRed("(Body)")
			});
		}

		return _tooltip;
	}

	o.getTooltip_Battleforged <- function( _tooltip)
	{
		local armor = this.getContainer().getActor().getArmor(::Const.BodyPart.Head) + this.getContainer().getActor().getArmor(::Const.BodyPart.Body);
		local reduction = ::Math.floor(armor * 5 * 0.01);

		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/armor_head.png",
			text = "Battleforged: " + ::MSU.Text.colorGreen("– " + reduction + "%") + " armor damage taken"
		});

		return _tooltip;
	}

// =============================================================================================
// Keep old mood code
// =============================================================================================
    o.onCombatStarted = function()
	{
		local actor = this.getContainer().getActor();
        if (!this.getContainer().getActor().isPlayerControlled()) return;

		local mood = actor.getMoodState();
		local morale = actor.getMoraleState();
		local isDastard = this.getContainer().hasSkill("trait.dastard");

		switch(mood)
		{
            case ::Const.MoodState.Concerned:
                actor.setMaxMoraleState(::Const.MoraleState.Steady);
                actor.setMoraleState(::Const.MoraleState.Steady);
                break;

            case ::Const.MoodState.Disgruntled:
                actor.setMaxMoraleState(::Const.MoraleState.Wavering);
                actor.setMoraleState(::Const.MoraleState.Wavering);
                break;

            case ::Const.MoodState.Angry:
                actor.setMaxMoraleState(::Const.MoraleState.Breaking);
                actor.setMoraleState(::Const.MoraleState.Breaking);
                break;

            case ::Const.MoodState.Neutral:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                break;
            case ::Const.MoodState.InGoodSpirit:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                if (morale < ::Const.MoraleState.Confident && ::Math.rand(1, 100) <= 25 && !isDastard)
                    actor.setMoraleState(::Const.MoraleState.Confident);
                break;
            case ::Const.MoodState.Eager:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                if (morale < ::Const.MoraleState.Confident && ::Math.rand(1, 100) <= 50 && !isDastard)
                    actor.setMoraleState(::Const.MoraleState.Confident);
                break;
            case ::Const.MoodState.Euphoric:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                if (morale < ::Const.MoraleState.Confident && ::Math.rand(1, 100) <= 75 && !isDastard)
                    actor.setMoraleState(::Const.MoraleState.Confident);
                break;
        }
	}

	o.onAfterUpdate <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap()) this.m.Stacks = 5; //Start off with 25% dr for medium armor passive

		_properties.MeleeDamageMult *= 1.0 + _properties.RangedSkill / 100.0;
		_properties.RangedDamageMult *= 1.0 + _properties.RangedSkill / 100.0;
	}

	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getFaction() != ::Const.Faction.Player)
		{
			if (!actor.getFlags().has("Level")) return;

			local level = actor.getFlags().getAsInt("Level");
			if (level >= 6)
			{
				_properties.MeleeSkill += 10;
				_properties.MeleeDefense += 20;
			}
			if (level >= 11)
			{
				_properties.MeleeSkill += 10;
				_properties.MeleeDefense += 20;
			}
			return;
		}

		local level = this.getContainer().getActor().getLevel();
		if (level == 5) _properties.XPGainMult *= 0.1;
		else if (level >= 10) _properties.XPGainMult *= 0;

		if (level >= 6)
		{
			_properties.MeleeSkill += 10;
			_properties.MeleeDefense += 20;
		}

		if (level >= 11)
		{
			_properties.MeleeSkill += 10;
			_properties.MeleeDefense += 20;
		}
		


		local mood = this.getContainer().getActor().getMoodState();
		local p = ::Math.round(this.getContainer().getActor().getMood() / (::Const.MoodState.len() - 0.05) * 100.0);
		this.m.Name = ::Const.MoodStateName[mood] + " (" + p + "%)";

		switch(mood)
		{
			case ::Const.MoodState.Neutral:
				this.m.Icon = "skills/status_effect_64.png";
				break;

			case ::Const.MoodState.Concerned:
				this.m.Icon = "skills/status_effect_46.png";
				break;

			case ::Const.MoodState.Disgruntled:
				this.m.Icon = "skills/status_effect_45.png";
				break;

			case ::Const.MoodState.Angry:
				this.m.Icon = "skills/status_effect_44.png";
				break;

			case ::Const.MoodState.InGoodSpirit:
				this.m.Icon = "skills/status_effect_47.png";
				break;

			case ::Const.MoodState.Eager:
				this.m.Icon = "skills/status_effect_48.png";
				break;

			case ::Const.MoodState.Euphoric:
				this.m.Icon = "skills/status_effect_49.png";
				break;
		}
	}
});