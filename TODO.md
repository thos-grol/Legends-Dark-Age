//FIXME: contract destruction on world map doesn't seem to work correctly anymore, go fix it.
//TODO: idea, shieldwall should have a chance to taunt enemies
//TODO: modify double grip to remove armor pen

//TODO: retexture dismiss button to be red
//TODO: change reserve button/add weapon tree tooltip explanation

//TODO: implement all trait trees and test (4 x 2 = 8) <- copy from old project to save time
	health
	endurance
	mettle
	agility
//TODO: implement all weapon trees and test (15 x 3 = 45) <- copy from old project to save time
	crossbows -> advanced weapons
		- crossbow -> uses bolts (military grade weapons, deadly, hard to obtain)
		- handgonne -> handcannon (takes ? AP to reload, needs powder) (military grade weapons, deadly, hard to obtain)
		- future flintlock (high damage burst shot, 1 shot - takes 9 AP to reload, needs powder) (military grade weapons, deadly, hard to obtain)
		- magic ranged items? (epic grade weapons, deadly, hard to obtain)

//TODO: finish up rogue tree

//TODO: finish up all other classes
//TODO: implement perk unlock restrictions
	- one per row
		- add description to say how silver perks - class perks can only be picked once per row
	- traits and weapons can't be picked
		- add description to lock saying how to obtain them - bronze perks

//FEATURE_1: idea, add flintlock pistol
//FEATURE_9: add bro cosmetic screen to squadscreen (popup dialog?)


• 
+ ::DEF.C.Effect_Explanations["Daze"];



Enemy Designs

Bandits, ruffians. They should be a threat even with the lowest tier. Poorly equipped, but has classes that can capitulize on that.
Blunt weapons, farm implements, axes.

	Bandit tiers
		Rabble & Thugs
		Veterans
		Elites

What sort of contracts involve bandits?
	Stolen goods
	Town Defense
	Camp
	Caravans

Short term
  // contracts spawned if village is above z level use barbarians instead
    
// story missions where the world heads towards a future associated with a certain god ()
// faction has enemies stored as details?
// enemies simulated faction can conflict with faction
// let's design organic factions and force level system
// preset factions
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