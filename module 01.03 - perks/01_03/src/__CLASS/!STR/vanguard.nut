// =================================================================================================
// 1
// =================================================================================================
    
::Const.Strings.PerkName.BlockMastery <- "Block Mastery";
::Const.Strings.PerkDescription.BlockMastery <- "Improves ability to survive"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+100%") + " Block Mitigation"
+ "\n" + ::green("– 25%") + " Fatigue " + ::seagreen("(Shieldwall)")
+ "\n" + ::green("– 25%") + " Fatigue " + ::seagreen("(Safeguard)");

::Const.Strings.PerkName.Conservation <- "Conservation";
::Const.Strings.PerkDescription.Conservation <- "Improves endurance"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("– 25%") + " Fatigue " + ::red("(Skill)")

+ "\n\n" + ::blue("« Vanguard »")
+ "\n" + ::green("– 25%") + " Fatigue " + ::seagreen("(Shieldwall)")
+ "\n" + ::green("– 25%") + " Fatigue " + ::seagreen("(Safeguard)")

+ "\n\n" + ::blue("« Rogue »")
+ "\n" + ::green("– 25%") + " Fatigue " + ::seagreen("(Footwork)")
+ "\n" + ::green("– 25%") + " Fatigue " + ::seagreen("(Fleche)");
        
::Const.Strings.PerkName.BruteStrength <- "Brute Strength";
::Const.Strings.PerkDescription.BruteStrength <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+5") + " Damage"
+ "\n" + ::green("+5") + " Damage " + ::red("Lvl 3")
+ "\n" + ::green("+10") + " Damage " + ::red("Lvl 5");
        
// =================================================================================================
// 2
// =================================================================================================

::Const.Strings.PerkName.Safeguard <- "Safeguard";
::Const.Strings.PerkDescription.Safeguard <- "Improves allies ability to survive"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants shield skill " + ::seagreen("Safeguard")
+ "\n\n" + ::gray("« Safeguard » [4 AP, 1 CD, 20 FAT]:")
+ "\n" + ::gray("• Protect an ally, swapping positions with them. User will then shieldwall and then taunt all enemies that can attack in 2 tiles. Ignores stun and root.");
        
::Const.Strings.PerkName.Steadfast2 <- "Steadfast";
::Const.Strings.PerkDescription.Steadfast2 <- "Improves endurance and mental resilience"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("– 100%") + " Fatigue " + ::red("(Being Attacked)")
+ "\n" + "• Is not morale checked by approaching enemies"
+ "\n" + "• Is not morale checked by taking damage"
+ "\n" + "• Is not morale checked by dying or fleeing allies";

::Const.Strings.PerkName.SurvivalInstinct <- "Survival Instinct";
::Const.Strings.PerkDescription.SurvivalInstinct <- "Improves ability to survive"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+5") + " Defense"
+ "\n" + ::green("+10") + " Defense (if HP ≤ 66%)"
+ "\n" + ::green("+20") + " Defense (if HP ≤ 33%)";
        
// =================================================================================================
// 3
// =================================================================================================
    
::Const.Strings.PerkName.IronMountain <- "Iron Mountain";
::Const.Strings.PerkDescription.IronMountain <- "Improves ability to survive"
+ "\n\n" + ::blue("« On Being Hit »")
+ "\n" + ::green("+10") + " Hardness" + ::red(" until turn start")
+ "\n" + ::red("This can only occur once per turn")
+ "\n\n" + ::gray("« Hardness »")
+ "\n" + ::gray("Each point of Hardness reduces damage by 1 before any calculations");
        
::Const.Strings.PerkName.Vanguard <- "Vanguard";
::Const.Strings.PerkDescription.Vanguard <- "Improves ability to survive and control positions"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Surrounding has no effect on this character"
+ "\n" + "• Grants skill " + ::seagreen("Line Breaker")
+ "\n\n" + ::gray("« Line Breaker »\n[3 AP, 3 CD, 15 FAT]:")
+ "\n" + ::gray("• Push an enemy back and take their place")
+ ::DEF.C.Effect_Explanations["Surrounding"];

::Const.Strings.PerkName.Rage <- "Rage";
::Const.Strings.PerkDescription.Rage <- "Improves lethality"
+ "\n\n" + ::blue("« On Hit »")
+ "\n" + ::green("+1") + " Rage Stack " + ::red("(33% Chance)")
+ "\n" + ::red("Damage rolls exceeding 25% of Health (100% Chance)")

+ "\n\n" + ::gray("« Rage » (Max 1)")
+ "\n" + ::gray("+100% damage. Stack expended on graze or hit");

// =================================================================================================
// 4
// =================================================================================================
    
::Const.Strings.PerkName.StunStrike <- "Stun Strike";
::Const.Strings.PerkDescription.StunStrike <- "Gives the capability to control enemies"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants shield skill " + ::seagreen("Stun Strike")
+ "\n\n" + ::gray("« Stun Strike »\n[4 AP, 20 FAT, 3 CHARGES]:")
+ "\n" + ::gray("• Strike the enemy with your shield with a 20 Skill bonus. On hit, deal a T4 stun")
+ "\n" + ::gray("• Gain charges when hit")
+ ::DEF.C.Effect_Explanations["Stun"]
+ ::DEF.C.Effect_Explanations["Daze"];
        
::Const.Strings.PerkName.Executioner2 <- "Executioner";
::Const.Strings.PerkDescription.Executioner2 <- "Improves ability to finish off enemies"
+ "\n\n" + ::blue("« vs Enemies ≤ 50% HP »")
+ "\n" + ::green("+25") + " Skill"
+ "\n" + ::green("+25") + " Headshot Chance";
        
::Const.Strings.PerkName.TrueStrike <- "True Strike";
::Const.Strings.PerkDescription.TrueStrike <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+10") + " Skill"
+ "\n\n" + ::blue("« On Hit »")
+ "\n" + "• Do 2 damage rolls and pick the highest one"
+ "\n\n" + ::blue("« For Rogues »")
+ "\n" + "• Boost passive [Keen Insight]: 15% -> 25%";


// =================================================================================================
// 5
// =================================================================================================

::Const.Strings.PerkName.ReboundForce <- "Rebound Force";
::Const.Strings.PerkDescription.ReboundForce <- "Improves control capabilities"
+ "\n\n" + ::blue("« On Being Hit »")
+ "\n" + "Enemies that hit this unit:"
+ "\n" + ::red("This can only occur 4 times a turn")
+ "\n" + "• Take X Damage"
+ "\n" + "• Gain X Fatigue"
+ "\n" + ::red("Χ = 0.25 ⋅ Damage Roll")
+ "\n" + "• Have a 25% chance to be " + ::status("Disarmed")
+ ::DEF.C.Effect_Explanations["Disarmed"];

::Const.Strings.PerkName.HoldtheLine <- "Warden";
::Const.Strings.PerkDescription.HoldtheLine <- "Improves Attacks of Oppurtunity and Riposte, and prevents most cases of displacement"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Attacks made " + ::red("not on this character's turn") + " have advantage"
+ "\n" + "• Cannot be displaced generally"
+ "\n\n" + ::gray("« Advantage »")
+ "\n" + ::gray("• Do 2 rolls and pick the highest roll. Advantage and Disadvantage negate each other");
        
::Const.Strings.PerkName.Berserk <- "Berserk";
::Const.Strings.PerkDescription.Berserk <- "Improves lethality"
+ "\n\n" + ::blue("« On Kill »")
+ "\n" + ::green("+4") + " AP"
+ "\n" + "• Recovers 15 Fatigue"
+ "\n" + ::red("This can only occur once a turn");
        
// =================================================================================================
// 6
// =================================================================================================
    
::Const.Strings.PerkName.HeavyCounter <- "Heavy Counter";
::Const.Strings.PerkDescription.HeavyCounter <- "Improves Attacks of Oppurtunity and Riposte and ability to control enemies"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Attacks made " + ::red("not on this character's turn") + " apply " + ::status("Flaw") + " on hit"
+ "\n\n" + ::blue("« On Hit, Flaw »")
+ "\n" + ::green("25%") + " chance to " + ::status("Stun")
+ "\n" + ::green("75%") + " chance to " + ::status("Daze")
+ ::DEF.C.Effect_Explanations["Flaw"]
+ ::DEF.C.Effect_Explanations["Stun"]
+ ::DEF.C.Effect_Explanations["Daze"];
        
::Const.Strings.PerkName.Unhindered <- "Unhindered";
::Const.Strings.PerkDescription.Unhindered <- "Improves resistance to negative effects"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("2") + " Physical Resistance"
+ ::DEF.C.Effect_Explanations["Resistance"];

::Const.Strings.PerkDescription.NineLives <- "Improves ability to survive"
+ "\n\n" + ::blue("Upon taking fatal damage:")
+ "\n" + ::green("+Death immunity") + " till turn start"
+ "\n" + ::green("+Remove DOT effects")
+ "\n" + ::red("Effect occurs once per battle");
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.NineLives].Tooltip = ::Const.Strings.PerkDescription.NineLives;


// =================================================================================================
// 7
// =================================================================================================
    
::Const.Strings.PerkName.ImpactCondensation <- "Impact Condensation";
::Const.Strings.PerkDescription.ImpactCondensation <- "Improves ability to survive"
+ "\n\n" + ::blue("« On Being Hit »")
+ "\n" + ::green("+1") + ::status(" Condensation") + " stack"

+ "\n\n" + ::gray("« Condensation » Max 4")
+ "\n" + ::gray("+25%") + " Damage Reduction (vs Physical) per stack"
+ "\n" + ::gray("• Lose 3 stacks on turn start");
        
::Const.Strings.PerkName.LionsRoar <- "Lions Roar";
::Const.Strings.PerkDescription.LionsRoar <- "Increases control capabilities"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants skill " + ::seagreen("Lion\'s Roar")

+ "\n\n" + ::gray("« Lion\'s Roar »\n[8 CHARGES or AUTOMATIC - Dropping below 33% HP]:")
+ "\n" + ::gray("If the skill is triggered, all charges are consumed")
+ "\n" + ::gray("All surrounding enemies:")
+ "\n" + ::gray("• T4 Stun")
+ "\n" + ::gray("• T4 Weakness")
+ ::DEF.C.Effect_Explanations["Stun"]
+ ::DEF.C.Effect_Explanations["Weakness"];
        
::Const.Strings.PerkName.DeathDealer <- "Death Dealer";
::Const.Strings.PerkDescription.DeathDealer <- "Increases lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("– 2") + " AP Cost for skills with costs ≥ 6"
+ "\n" + ::green("+10") + " Fatigue Recovery";