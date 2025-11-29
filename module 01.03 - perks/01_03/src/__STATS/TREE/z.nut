::Const.Perks.TraitsTrees.TreeCustom <- [
    ::Const.Perks.AgilityTree, // Agility
    ::Const.Perks.TenaciousTree, // Mettle
    ::Const.Perks.HealthTree, // Health
    ::Const.Perks.EnduranceTree, // Endurance
];

// hk - trait trees are selected using traits now
::Const.Perks.TraitsTrees.get_random <- function( _exclude, _flags, i)
{
    if ( i == 0 && _flags.has("main_trait")) return ::Const.Perks[_flags.get("main_trait")];
    if ( i == 1 && _flags.has("secondary_trait")) return ::Const.Perks[_flags.get("secondary_trait")];
    
    local L = [];
    foreach( i, t in this.TreeCustom )
    {
        if (_exclude != null && _exclude.find(t.ID) != null) continue;
        L.push(i);
    }

    local tree = this.TreeCustom[L[::Math.rand(0, L.len() - 1)]];
    if (i == 0 && !_flags.has("main_trait"))
    {
        _flags.set("main_trait", tree.ID);
        ::logInfo("main_trait: " + tree.ID);
    }
    else if (i == 1  && !_flags.has("secondary_trait"))
    {
        _flags.set("secondary_trait", tree.ID);
        ::logInfo("secondary_trait: " + tree.ID);
    }
    return tree;
}

::Const.Perks.OrganisedTree <- { //Unused
	ID = "OrganisedTree",
	Name = "Organized",
	Descriptions = [
		"is organized"
	],
	Attributes = {
		Hitpoints = [0,0],
		Bravery = [0,0],
		Stamina = [0,0],
		MeleeSkill = [0,0],
		RangedSkill = [0,0],
		MeleeDefense = [0,0],
		RangedDefense = [0,0],
		Initiative = [0,0]
	},
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.MartyrTree <- { //Unused
	ID = "MartyrTree",
	Name = "Martyr",
	Descriptions = [
		"has martyr complex"
	],
	Attributes = {
		Hitpoints = [0,0],
		Bravery = [0,0],
		Stamina = [0,0],
		MeleeSkill = [0,0],
		RangedSkill = [0,0],
		MeleeDefense = [0,0],
		RangedDefense = [0,0],
		Initiative = [0,0]
	},
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.FastTree <- { //Unused
	ID = "FastTree",
	Name = "Fast",
	Descriptions = [
		"is fast"
	],
	Attributes = {
		Hitpoints = [0,0],
		Bravery = [0,0],
		Stamina = [0,0],
		MeleeSkill = [0,0],
		RangedSkill = [0,0],
		MeleeDefense = [0,0],
		RangedDefense = [0,0],
		Initiative = [0,0]
	},
	Tree = [
		[
		],
		[],
		[
		],
		[],
		[
		],
		[],
		[
		]
	]
};