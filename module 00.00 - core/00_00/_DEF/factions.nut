// story missions where the world heads towards a future associated with a certain god ()


// TODO: preset factions
	// 1. Northern ice faction, can tame white wolves, ice knights
	//	- bandits: barbarians
	//  - big threat: undead, crisis: Necromancer's ascension ritual
	// 2. Council of Mages
	// 	- bandits: different bandit gang design
	//  - big threat: greenskins, crisis: Greenskin Tide (Two Headed Orc Mage)
	//   (camp) ghost village
	//   (camp) undead legionaries
	//   (camp) shifting woods
	// 3. Holy Kingdom
	// 	- bandits: none/theyve been purged
	//  - big threat: cultists, crisis: Davkul's advent
	//  (camp) castle of night (vampires)
	//  (camp) witches
	// 4. (Southern) Alchemists
	//  - bandits: nomads
	//  general crisis: world war
	
	//  (camp) monsters
	//  (camp) anatomists


// new mechanic = retaliations
// % chance after mission they send a retaliation based on how much hate you have
// influences the quality of units sent

// XCOM force level -> as force level increases, so too does the quality of units they field
// faction strength -> the amount of units they can devote to missions

// faction conflict, over certain resource points
// faction conflict, over schemes
// faction actions - caravan transports
// faction actions - critical caravan transports

// you cannot betray allied faction

// Golden Path mission
	// unique mission chain for each faction


// General Missions
	// claim enemy resource point
	// defend/raid caravan - raid caravan contract given by hostile nations (between town to capital)
	// defend/raid critical caravan - raid caravan contract given by hostile nations (between resource point to capital)


	// barbarians
		// gang - remove them
		// barbarian camp
		// barbarian chosen
		// barbarian lord

	// bandit 
		// gang - remove them
		// bandit camp - remove them
		// hunt hero bandit
		// hunt bandit warlord
		// hunt special bandit group + leader

	// cultist 
		// gang - remove them
		// cultist ritual - remove them (they sacrifice humans to gain faction power)
		// hunt hero cultists
		// hunt apostle

	// graveyard - bandits, undead, necromancer

	// goblins
	// orcs

	// find stolen item
	// protect VIP
		// could be from any enemy faction attacking
	// witch and child - defend

	// clear beasts
	//	spiders
		// spider nest I (has redback spider)
		// spider nest II (has spider queen)
	//	hyena

	// monster. You don't always have information if it's t1 or t2 boss
		// nachzerher
		// alp
		// direwolf
		// unhold
		// treant
		// basilisk

::DEF.C.Factions.Nobles <- {};
::DEF.C.Factions.Nobles["House Adelheim"] <- {
	Name = "House Adelheim",
	Traits = [
		this.Const.FactionTrait.NobleHouse
	],
	Description = "House Adelheim is renowned for their iron grip over the northern lands. Their specialties are the ice wolf knights, an elite unit of special sequence knights whose allies are white wolves.",
	Motto = "Beware the Wolf"
};
::DEF.C.Factions.Nobles["Templar Order"] <- {
	Name = "Templar Order",
	Traits = [
		this.Const.FactionTrait.NobleHouse,
	],
	Description = "The templar order protects the church of the light. Their specialties are templar knights and priests who purge all that is evil, blasphemous, and unholy.",
	Motto = "Light in Darkness"
};
::DEF.C.Factions.Nobles["House Rabenholt"] <- {
	Name = "House Rabenholt",
	Traits = [
		this.Const.FactionTrait.NobleHouse,
	],
	Description = "House Rabenholt is a clan of mages who seek higher powers. They specialize and collect all aspects of knowledge.",
	Motto = "Knowledge is Victory"

};

::DEF.C.Factions.CityState <- {};
::DEF.C.Factions.CityState["Alchemists"] <- {
	// Alchemists
	// Technology
	// 1001 nights
	Traits = [
		this.Const.FactionTrait.OrientalCityState
	],
	Description = "A city state dedicated to acquiring knowledge above all - even if it comes at the cost of doing autopsies, reading forbidden tomes or engaging with sinister powers not of this world.",
	Mottos = [
		"Dare to be wise",
		"Wisdom the conqueror of fortune",
		"Read and learn",
		"The castle of wisdom",
		"Knowledge at last"
	]
};