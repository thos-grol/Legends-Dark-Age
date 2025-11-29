// =================================================================================================
// 1
// =================================================================================================
    
::Const.Strings.PerkName.BlockMastery <- "Block Mastery";
::Const.Strings.PerkDescription.BlockMastery <- "Improves ability to survive"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+100%") + " Shield Armor Points";
        
::Const.Strings.PerkName.Conservation <- "Conservation";
::Const.Strings.PerkDescription.Conservation <- "Improves endurance"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("– 25%") + " Fatigue " + ::red("(Skill)")

+ "\n\n" + ::blue("« Vanguard »")
+ "\n" + ::green("– 100%") + " Fatigue " + ::seagreen("(Shieldwall)")
+ "\n" + ::green("– 100%") + " Fatigue " + ::seagreen("(Safeguard)");
        
::Const.Strings.PerkName.BruteStrength <- "Brute Strength";
::Const.Strings.PerkDescription.BruteStrength <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+5") + " Damage"
+ "\n" + ::green("+5") + " Damage " + ::red("Lvl 3")
+ "\n" + ::green("+5") + " Damage " + ::red("Lvl 5")
+ "\n" + ::green("+5") + " Damage " + ::red("Lvl 7");
        
// =================================================================================================
// 2
// =================================================================================================
    
::Const.Strings.PerkName.Safeguard <- "Safeguard";
::Const.Strings.PerkDescription.Safeguard <- "Gives the capability to protect allies"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants shield skill " + ::seagreen("Safeguard")
+ "\n\n" + ::blue("« Safeguard » [4 AP, 1 CD, 20 FAT]:")
+ "\n" + "• Divert attacks on target to self";
//TODO: refine values in test
        
::Const.Strings.PerkName.Steadfast2 <- "Steadfast2";
::Const.Strings.PerkDescription.Steadfast2 <- "Improves endurance and mental resilience"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("– 100%") + " Fatigue " + ::red("(Being Attacked)")
+ "\n" + "• Is not morale checked by taking damage"
+ "\n" + "• Is not morale checked by dying allies";
//TODO: implement

::Const.Strings.PerkName.SurvivalInstinct <- "Survival Instinct";
::Const.Strings.PerkDescription.SurvivalInstinct <- "Improves ability to survive"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+5") + " Defense"
+ "\n" + ::green("+10") + " Defense (if HP ≤ 66%)"
+ "\n" + ::green("+20") + " Defense (if HP ≤ 33%)";
//TODO: implement
        
// =================================================================================================
// 3
// =================================================================================================
    
::Const.Strings.PerkName.IronMountain <- "Iron Mountain";
::Const.Strings.PerkDescription.IronMountain <- "Improves ability to survive"
+ "\n\n" + ::blue("« On Being Hit »")
+ "\n" + ::green("+10") + ::stack(" Hardness") + ::red(" until turn start")
+ "\n" + ::gray("Each point of Hardness reduces damage by 1 before any calculations");
//TODO: implement
        
::Const.Strings.PerkName.Vanguard <- "Vanguard";
::Const.Strings.PerkDescription.Vanguard <- "Improves ability to survive and control positions"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Surrounding has no effect on this character"
+ "\n" + "• Grants skill " + ::seagreen("Line Breaker")
+ "\n\n" + ::blue("« Line Breaker » [4 AP, 1 CD, 30 FAT]:")
+ "\n" + "• Push an enemy back and take their place";
//TODO: implement

::Const.Strings.PerkName.Rage <- "Rage";
::Const.Strings.PerkDescription.Rage <- "Improves lethality"
+ "\n\n" + ::blue("« On Hit »")
+ "\n" + ::green("+1") + " Rage Stack " + ::red("50% Chance")
+ "\n" + ::red("If the damage exceeds 25% of health, chance becomes 100%")

+ "\n\n" + ::gray("« Rage » (Max 1)")
+ "\n\n" + ::gray("+100% damage. Stack expended on graze or hit");
//TODO: implement
        
// =================================================================================================
// 4
// =================================================================================================
    
::Const.Strings.PerkName.StunStrike <- "Stun Strike";
::Const.Strings.PerkDescription.StunStrike <- "Gives the capability to control enemies"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants shield skill " + ::seagreen("Stun Strike")
+ "\n\n" + ::blue("« Stun Strike » [4 AP, 2 CD, 20 FAT, 3 CHARGES]:")
+ "\n" + "• Strike the enemy with your shield, if it hits, deal an unresistatable stun for 2 turns."
+ "\n" + "• Gains 1 charge when hit";
//TODO: implement
        
::Const.Strings.PerkName.Executioner2 <- "Executioner";
::Const.Strings.PerkDescription.Executioner2 <- "Improves ability to finish off enemies"
+ "\n\n" + ::blue("« vs Enemies ≤ 50% HP »")
+ "\n" + ::green("+20") + " Skill"
+ "\n" + ::green("+20") + " Headshot Chance";
//TODO: implement
        
::Const.Strings.PerkName.TrueStrike <- "True Strike";
::Const.Strings.PerkDescription.TrueStrike <- "Improves lethality"
+ "\n\n" + ::blue("« On Hit »")
+ "\n" + "• Do 2 damage rolls and pick the highest one";
//TODO: implement

// =================================================================================================
// 5
// =================================================================================================

::Const.Strings.PerkName.ReboundForce <- "Rebound Force";
::Const.Strings.PerkDescription.ReboundForce <- "Improves control capabilities"
+ "\n\n" + ::blue("« On Being Hit »")
+ "\n" + "Enemies that hit this unit:"
+ "\n" + "• Take X Damage"
+ "\n" + "• Gain X Fatigue"
+ "\n" + ::red("Χ = 0.25 ⋅ Damage Roll")
+ "\n" + "• Have a 25% chance to be " + ::status("Disarmed")
+ "\n" + ::red("This can only occur twice a turn");
//TODO: implement

::Const.Strings.PerkName.HoldtheLine <- "Warden";
::Const.Strings.PerkDescription.HoldtheLine <- "Improves Attacks of Oppurtunity and Riposte, and prevents most cases of displacement"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Attacks made " + ::red("not on this character's turn") + " are made with advantage"
+ "\n" + "• Cannot be displaced generally"
+ "\n\n" + ::stack("« Advantage »")
+ "\n" + ::gray("• Do 2 rolls and pick the highest roll. Advantage and Disadvantage negate each other");
//TODO: implement
        
::Const.Strings.PerkName.Berserk <- "Berserk";
::Const.Strings.PerkDescription.Berserk <- "Improves lethality"
+ "\n\n" + ::blue("« On Kill »")
+ "\n" + ::green("+4") + " AP"
+ "\n" + "• Recovers 15 Fatigue"
+ "\n" + ::red("This can only occur once a turn");
//TODO: implement Berserk
        
// =================================================================================================
// 6
// =================================================================================================
    
::Const.Strings.PerkName.HeavyCounter <- "Heavy Counter";
::Const.Strings.PerkDescription.HeavyCounter <- "Improves Attacks of Oppurtunity and Riposte and ability to control enemies"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Attacks made " + ::red("not on this character's turn") + " apply " + ::status("Flaw") + " on hit"
+ "\n\n" + ::blue("« On Hit, Flaw »")
+ "\n" + ::green("25%") + " chance to " + ::status("Stun")
+ "\n" + ::green("75%") + " chance to " + ::status("Daze");
//TODO: implement
        
::Const.Strings.PerkName.Unhindered <- "Unhindered";
::Const.Strings.PerkDescription.Unhindered <- "Improves resistance to negative effects"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Negative effects are either downgraded or weakened by 50%";
//TODO: implement

//TODO: implement NIne Lives


// =================================================================================================
// 7
// =================================================================================================
    
::Const.Strings.PerkName.ImpactCondensation <- "Impact Condensation";
::Const.Strings.PerkDescription.ImpactCondensation <- "Improves ability to survive"
+ "\n\n" + ::blue("« On Being Hit »")
+ "\n" + ::green("+1") + ::status(" Condensation") + " stack"

+ "\n\n" + ::stack("« Condensation » Max 4")
+ "\n" + ::green("+25%") + " Damage Reduction per stack"
+ "\n" + ::gray("• Lose 3 stacks on turn start");
//TODO: implement Impact Condensation
        
::Const.Strings.PerkName.LionsRoar <- "Lions Roar";
::Const.Strings.PerkDescription.LionsRoar <- "Increases control capabilities"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants skill " + ::seagreen("Lion\'s Roar")
+ "\n\n" + ::blue("« Lion\'s Roar » [7 AP, 4 CD, 20 FAT]:")
+ "\n" + "All surrounding enemies:"
+ "\n" + "• Are inflicted with 2 Turn" + ::status("Stun")
+ "\n" + "• Are inflicted with " + ::status("Weakness");
//TODO: implement 
        
::Const.Strings.PerkName.DeathDealer <- "Death Dealer";
::Const.Strings.PerkDescription.DeathDealer <- "Increases lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("– 2") + " AP Cost for skills with costs ≥ 6"
+ "\n" + ::green("+15") + " Fatigue Recovery";

//TODO: implement 

        