::Const.Perks.SwordTree <- {
	ID = "Sword",
	Name = "Sword",
	Descriptions = [
		"swords"
	],
	Attributes = {
		Hitpoints = [ 0, 0 ],
		Bravery = [ 0, 0 ],
		Stamina = [ 0, 0 ],
		MeleeSkill = [ 0, 0 ],
		RangedSkill = [ 0, 0 ],
		MeleeDefense = [ 0, 0 ],
		RangedDefense = [ 0, 0 ],
		Initiative = [ 0, 0 ]
	},
	Tree = [
		[
			::Legends.Perk.EMPTY_SWORD,
		],
		[
			::Legends.Perk.Tempi
		],
		[
			::Legends.Perk.EMPTY_SWORD,
		],
		[
			::Legends.Perk.SpecSword2
		],
		[
			::Legends.Perk.EMPTY_SWORD,
		],
		[
			::Legends.Perk.TheStrongest
		],
		[
			::Legends.Perk.EMPTY_SWORD,
		]
	]
};