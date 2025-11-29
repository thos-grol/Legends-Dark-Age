::mods_hookExactClass("skills/special/mood_check", function (o)
{
	o.m.stacks_medium <- 0;
	o.m.stacks_medium_max <- 10;

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

	// =============================================================================================
	// Logic
	// =============================================================================================


    o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		local total_weight = getTotalWeight();
		local actor = this.getContainer().getActor();
        if (total_weight <= 20) // Freedom of Movement
        {
            if (_attacker == null) return;
			if (_attacker.getID() == actor.getID()) return;

            if (_skill == null) return;
			if (!_skill.isAttack() || _skill.isRanged() || !_skill.isUsingHitchance()) return;

			local ac = _attacker.getSkills();
			if (ac.getSkillByID("perk.stance.seismic_slam") != null) return;
			if (ac.getSkillByID("perk.class.continuance_knight") != null) return;
			if (ac.getSkillByID("perk.strange_strikes") != null) return;
			if (ac.getSkillByID("actives.horrific_scream") != null) return;

            local ourCurrentInitiative = actor.getInitiative();
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
			if (bonus > 0) 
			{
				::Z.T.Log.cd_obdr_msg <- true;
				::Z.T.Log.cd_obdr_str <- "[Freedom of Movement] -" + (::Z.S.log_roundf(bonus, 2) * 100) + "% damage";		
			}
        }
        else if (total_weight > 20 && total_weight <= 40) // medium armor passive
        {
            if (_attacker != null && _skill != null && _skill.isAttack())
			{
				local bonus = this.m.stacks_medium * 0.05;
				_properties.DamageReceivedRegularMult *= 1 - bonus;
				this.m.stacks_medium = ::Math.max(0, this.m.stacks_medium - 2);
				if (bonus > 0)
				{
					::Z.T.Log.cd_obdr_msg <- true;
					::Z.T.Log.cd_obdr_str <- "[Medium Armor Passive] -" + (::Z.S.log_roundf(bonus, 2) * 100) + "% damage";
				}
			}
        }
		else //Man of steel
		{
			if (_attacker != null && _attacker.getID() == actor.getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;
			local bonus = get_bonus_ac_heavy(_hitInfo.BodyPart) * 0.01;
			_properties.DamageReceivedDirectMult *= 1.0 - bonus;
			if (bonus > 0)
			{
				::Z.T.Log.cd_obdr_msg <- true;
				::Z.T.Log.cd_obdr_str <- "[Man of Steel] -" + (::Z.S.log_roundf(bonus, 2)  * 100) + "% Health damage";
			}
		}
	}

	o.onMissed <- function( _attacker, _skill )
	{
		// medium armor passive
		local total_weight = getTotalWeight();
		if (total_weight > 20 && total_weight <= 40)
        {
            if (_attacker != null && _skill != null && _skill.isAttack() && !_skill.isRanged()) this.m.stacks_medium = ::Math.min(this.m.stacks_medium_max, this.m.stacks_medium + 1);
        }
	}
	
    o.onCombatStarted = function()
	{
		this.m.stacks_medium = 5; // start 25% dr medium armor passive

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
		if (!actor.isPlacedOnMap()) this.m.stacks_medium = 5; // show 25% dr for medium
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

	// =============================================================================================
	// Helper
	// =============================================================================================

	o.getTotalWeight <- function()
    {
        return this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
    }

	o.get_ac <- function(  )
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

	o.get_bonus_ac_heavy <- function( _bodyPart )
	{
		local actor = this.getContainer().getActor();
		return ::Math.min(100, ::Math.round(actor.getArmor(_bodyPart) * 0.1));
	}
});