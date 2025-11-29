// this file hooks the code that builds perk trees in the character background
::mods_hookExactClass("skills/backgrounds/character_background", function (o){

	o.m.PerkTreeDynamicBase <- { // this is a base perk tree so even if you don't add custom or dynamic perk tree it will default to this and build an average bro
		Weapon = [],
		Defense = [],
		Traits = [],
		Enemy = [],
		Class = [],
		Magic = []
	};
    
	// hk - modify how perk trees are built
	o.buildPerkTree <- function ()
	{
		local a = {
			Hitpoints = [0, 0],
			Bravery = [0, 0],
			Stamina = [0, 0],
			MeleeSkill = [0, 0],
			RangedSkill = [0, 0],
			MeleeDefense = [0, 0],
			RangedDefense = [0, 0],
			Initiative = [0, 0]
		};
		if (this.m.PerkTree != null) return a;

		// hk - use our custom GetDynamicPerkTree fn, remove some other logic
		if (this.m.CustomPerkTree == null)
		{
			local actor = this.getContainer().getActor();
			this.m.CustomPerkTree = ::Const.Perks.GetDynamicPerkTree(actor.getFlags());
		}

		local pT = ::Const.Perks.BuildCustomPerkTree(this.m.CustomPerkTree);
		this.m.PerkTree = pT.Tree;
		this.m.PerkTreeMap = pT.Map;
		
		// local origin = ::World.Assets.getOrigin();
		// if (origin != null)
		// {
		// 	origin.onBuildPerkTree(this);
		// }

		return a;
	}

	

    // uses actor flags we built from our modified GetDynamicPerkTree
	// to update background descriptions for recruitment
	o.getPerkBackgroundDescription = function( _tree )
	{
		local text = "";
        text = text + this.getContainer().getActor().getFlags().get("traits") + "\n";
		text = text + this.getPerkTreeGroupDescription(_tree.Weapon, "Has an aptitude for");
		text = text + this.getPerkTreeGroupDescription(_tree.Defense, "Likes wearing");
		text = text + this.getPerkTreeGroupDescription(_tree.Enemy, "Prefers fighting");
		text = text + this.getPerkTreeGroupDescription(_tree.Class, "Is skilled in");
		return text;
	}

});