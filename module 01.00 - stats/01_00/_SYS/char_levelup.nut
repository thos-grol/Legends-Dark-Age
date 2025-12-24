::mods_hookExactClass("entity/tactical/player", function (o){

	// changes level up logic
	// removes manual stat allocations
    // max level is 7
	o.updateLevel = function()
	{
		while (this.m.Level < 7 && this.m.XP >= ::Const.LevelXP[this.m.Level])
		{
			++this.m.Level;
			++this.m.PerkPoints;
			
			if ("State" in ::World && ::World.State != null && ::World.Assets.getOrigin() != null)
			{
				::World.Assets.getOrigin().onUpdateLevel(this);
			}
		}

		local f = this.getFlags();
		if (!f.has("Level Updated To")) f.set("Level Updated To", 1);

		// if we don't have a class yet, then defer stat updates
		// pressing class button will call this fn anyways
		local c = null;
		if (f.has("Class")) c = f.get("Class");
		if (c == null) return;

		// get class stat table
		local class_stats = ::DEF.C.Stats.Class[c];

		// apply levelups
		local lvl_update = f.getAsInt("Level Updated To");
		local lvl_changed = false;
		while (lvl_update < this.m.Level)
		{
			lvl_update++;
			local increaseValues = {
				//used stats
				hitpointsIncrease = class_stats["Hitpoints"][lvl_update],
				maxFatigueIncrease = class_stats["Endurance"][lvl_update],
				initiativeIncrease = class_stats["Agility"][lvl_update],
				braveryIncrease = class_stats["Mettle"][lvl_update],
				meleeSkillIncrease = class_stats["Skill"][lvl_update],
				meleeDefenseIncrease = class_stats["Defense"][lvl_update],
				rangeSkillIncrease = 0,
				rangeDefenseIncrease = 0
			};
			setAttributeLevelUpValues(increaseValues);

			//FEATURE_1: add trait/weapon points

			lvl_changed = true;
		}
		if (lvl_changed) f.set("Level Updated To", lvl_update);

	}

	// limit_break
	o.limit_break <- function()
	{
		if (this.m.Level != 6) return;
		++this.m.Level;
		++this.m.LevelUps;

		if ("State" in ::World && ::World.State != null && ::World.Assets.getOrigin() != null)
		{
			::World.Assets.getOrigin().onUpdateLevel(this);
		}
		updateLevel();
	}

	o.setAttributeLevelUpValues = function( _v )
	{
		local b = this.getBaseProperties();
		b.Hitpoints += _v.hitpointsIncrease;
		this.m.Hitpoints += _v.hitpointsIncrease;
		b.Stamina += _v.maxFatigueIncrease;
		b.Bravery += _v.braveryIncrease;
		b.MeleeSkill += _v.meleeSkillIncrease;
		b.RangedSkill += _v.rangeSkillIncrease;
		b.MeleeDefense += _v.meleeDefenseIncrease;
		b.RangedDefense += _v.rangeDefenseIncrease;
		b.Initiative += _v.initiativeIncrease;
		// this.m.LevelUps = this.Math.max(0, this.m.LevelUps - 1);

		// for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		// {
		// 	this.m.Attributes[i].remove(0);
		// }

		this.getSkills().update();
		this.setDirty(true);

		if (b.MeleeSkill >= 90)
		{
			this.updateAchievement("Swordmaster", 1, 1);
		}

		if (b.RangedSkill >= 90)
		{
			this.updateAchievement("Deadeye", 1, 1);
		}
	}

// 	// =========================================================================================
// 	// Helper fns
// 	// =========================================================================================

// 	//this function hooks max values for levelups
// 	o.getAttributeLevelUpValues = function()
// 	{
// 		local b = this.getBaseProperties();

// 		if (this.m.Attributes.len() == 0)
// 		{
// 			this.m.Attributes.resize(::Const.Attributes.COUNT);
// 			for( local i = 0; i != ::Const.Attributes.COUNT; i = ++i )
// 			{
// 				this.m.Attributes[i] = [];
// 			}
// 		}

// 		for( local i = 0; i != ::Const.Attributes.COUNT; i = ++i )
// 		{
// 			if (this.m.Attributes[i].len() == 0) {
// 				this.m.Attributes[i].push(1);
// 			}
// 		}

// 		// sets max values to 300
// 		local ret = {
// 			hitpoints = b.Hitpoints,
// 			hitpointsMax = 300,
// 			hitpointsIncrease = this.m.Attributes[::Const.Attributes.Hitpoints][0],
// 			bravery = b.Bravery,
// 			braveryMax = 300,
// 			braveryIncrease = this.m.Attributes[::Const.Attributes.Bravery][0],
// 			fatigue = b.Stamina,
// 			fatigueMax = 300,
// 			fatigueIncrease = this.m.Attributes[::Const.Attributes.Fatigue][0],
// 			initiative = b.Initiative,
// 			initiativeMax = 300,
// 			initiativeIncrease = this.m.Attributes[::Const.Attributes.Initiative][0],
// 			meleeSkill = b.MeleeSkill,
// 			meleeSkillMax = 300,
// 			meleeSkillIncrease = this.m.Attributes[::Const.Attributes.MeleeSkill][0],
// 			rangeSkill = b.RangedSkill,
// 			rangeSkillMax = 300,
// 			rangeSkillIncrease = this.m.Attributes[::Const.Attributes.RangedSkill][0],
// 			meleeDefense = b.MeleeDefense,
// 			meleeDefenseMax = 300,
// 			meleeDefenseIncrease = this.m.Attributes[::Const.Attributes.MeleeDefense][0],
// 			rangeDefense = b.RangedDefense,
// 			rangeDefenseMax = 300,
// 			rangeDefenseIncrease = this.m.Attributes[::Const.Attributes.RangedDefense][0]
// 		};
// 		return ret;
// 	}

// 	o.isPerkUnlockable = function( _id )
// 	{
// 		if (this.m.PerkPoints == 0 || this.hasPerk(_id)) return false;
// 		local perk = this.getBackground().getPerk(_id);
// 		if (perk == null) return false;

// 		if (::Z.S.Perks_isDestiny(_id))
// 		{
// 			if (this.m.Level < 11) return false; //is level 11
// 			if (this.getFlags().has("Destiny")) return false; //has a destiny already
// 		}

// 		if (::Z.S.Perks_isStance(_id))
// 		{
// 			if (!::Z.S.Perks_verifyStance(actor, _id)) return false; //has required mastery
// 			if (this.getFlags().has("Stance")) return false; //has a stance already
// 		}


// 		if (this.m.PerkPointsSpent >= perk.Unlocks) return true;
// 		return false;
// 	}

});