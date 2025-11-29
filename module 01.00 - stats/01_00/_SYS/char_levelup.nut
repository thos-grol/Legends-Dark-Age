::mods_hookExactClass("entity/tactical/player", function (o){

	// changes level up logic
    // max level is 7
	o.updateLevel = function()
	{
		while (this.m.Level < 7 && this.m.XP >= ::Const.LevelXP[this.m.Level])
		{
			++this.m.Level;
			// ++this.m.LevelUps;
			++this.m.PerkPoints;
			this.getFlags().add("Level " + this.m.Level);
			
			if ("State" in ::World && ::World.State != null && ::World.Assets.getOrigin() != null)
			{
				::World.Assets.getOrigin().onUpdateLevel(this);
			}

			if (this.m.Level == 2)
			{
				local _newTree = ::Const.Perks.ClassTrees.getRandom(null);
				getBackground().addPerkGroup(_newTree.Tree)
			}
		}
	}

	// limit_break
	o.limit_break <- function()
	{
		if (this.m.Level != 7) return;
		++this.m.Level;
		++this.m.LevelUps;

		if ("State" in ::World && ::World.State != null && ::World.Assets.getOrigin() != null)
		{
			::World.Assets.getOrigin().onUpdateLevel(this);
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