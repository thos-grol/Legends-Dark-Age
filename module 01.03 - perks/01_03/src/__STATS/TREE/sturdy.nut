::Const.Perks.SturdyTree <- {
	ID = "SturdyTree",
	Name = "Sturdy",
	Descriptions = [ "is sturdy" ]
	Attributes = {
		Hitpoints = [0,0],
		Bravery = [0,0],
		Stamina = [0,0],
		MeleeSkill = [0,0],
		RangedSkill = [0,0],
		MeleeDefense = [0,0],
		RangedDefense = [0,0],
		Initiative = [0,0],
	},
	Tree = [
		[
			::Const.Perks.PerkDefs.Colossus
		],
		[],
		[
			::Const.Perks.PerkDefs.HoldOut
		],
		[],
		[
			::Const.Perks.PerkDefs.NineLives
		],
		[],
		[
			::Const.Perks.PerkDefs.Indomitable
		]
	]
};