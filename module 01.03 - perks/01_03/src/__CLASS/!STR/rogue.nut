// =================================================================================================
// 1
// =================================================================================================
    
::Const.Strings.PerkName.Alert2 <- "Alert";
::Const.Strings.PerkDescription.Alert2 <- "Improves speed and survival"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Attacks cannot gain advantage on this unit"
+ "\n" + ::red("Ineffective if Dazed or Stunned")
+ "\n" + ::green("+10") + " Agility " + ::red("Lvl 3")
+ "\n" + ::green("+10") + " Agility " + ::red("Lvl 5");

//FIXME: Rogue - instead of perks granting ranged, class ability to use throwing weapons at rank 3

::Const.Strings.PerkName.Fleche <- "Fleche";
::Const.Strings.PerkDescription.Fleche <- "Improves tactical options and mobility (survival)"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Grants skill " + ::seagreen("Fleche")
+ "\n\n" + ::gray("« Fleche »\n[X AP, 2 CD, Y FAT]:")
+ "\n" + ::gray("• Dash towards and strike an enemy within 4 tiles using this character\'s current attack of opportunity (AOO)")
+ "\n" + ::gray("• AP and FAT (+15) costs will be set to the current AOO");

// =================================================================================================
// 2
// =================================================================================================
    
::Const.Strings.PerkName.TwinFangs <- "Twin Fangs";
::Const.Strings.PerkDescription.TwinFangs <- "Improves lethality"
+ "\n\n" + ::blue("« vs Enemy with Flaw »")
+ "\n" + ::green("25%") + " chance to consume the Flaw and perform another attack"
+ "\n\n" + ::blue("« vs Enemy with Flaw »")
+ "\n" + ::green("+15") + " Skill";

::Const.Strings.PerkName.FastAdaptation2 <- "Fast Adaptation";
::Const.Strings.PerkDescription.FastAdaptation2 <- "Improves lethality"
+ "\n\n" + ::blue("« On Miss or Graze »")
+ "\n" + ::green("+15") + " Skill"
+ "\n" + ::red("Resets to 0 on Hit")
+ "\n\n" + ::blue("« vs Enemy with Flaw »")
+ "\n" + ::green("+15") + " Skill";
        
::Const.Strings.PerkName.WeaponHarmony <- "Weapon Harmony";
::Const.Strings.PerkDescription.WeaponHarmony <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+10") + " Damage"

+ "\n\n" + ::blue("« On Miss »")
+ "\n" + "• Become first in turn order"
+ "\n" + ::red("For 4 AP attacks, this is only considered past the 1st this turn")

+ "\n\n" + ::blue("« vs Enemy with Flaw »")
+ "\n" + ::green("+15") + " Skill";

// =================================================================================================
// 3
// =================================================================================================

::Const.Strings.PerkName.Poisoner <- "Poisoner";
::Const.Strings.PerkDescription.Poisoner <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+25%") + " Poison Chance"
+ "\n" + ::green("+1") + " Poison Tier"
+ "\n" + ::red("• Once per unit, adds a poison item to this unit\'s bag")
+ ::DEF.C.Effect_Explanations["Poison"];

::Const.Strings.PerkName.Reflex <- "Reflex";
::Const.Strings.PerkDescription.Reflex <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+5") + " Defense"
+ "\n\n" + ::blue("« On Attacked, Enemy Turn (20% chance) »")
+ "\n" + ::green("+4") + " AP until [Turn End]"
+ "\n" + "• Recovers 15 Fatigue";

::Const.Strings.PerkName.QuickHands2 <- "Quick Hands";
::Const.Strings.PerkDescription.QuickHands2 <- "Improves tactical options and lethality"
+ "\n\n" + ::blue("« Once Per Turn »")
+ "\n You may pick one:"
+ "\n" + "• Use a bag item active for free"
+ "\n" + "• Swap a weapon for free";
//FIXME: Rogue - future bag item actives and throwing weapons will refer to quick hands

// =================================================================================================
// 4
// =================================================================================================

::Const.Strings.PerkName.Escape <- "Escape";
::Const.Strings.PerkDescription.Escape <- "Inproves survival"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("-1") + " [Footwork] cooldown"
+ "\n\n" + ::blue("« On Attacked »")
+ "\n " + " Retreat back 4 squares"
+ "\n " + ::red("• Occurs if surrounded by 2 enemies")
+ "\n " + ::red("• If hit, will take 50% damage")
+ "\n " + ::red("• 3 turn coodown");
        
// =================================================================================================
// 5
// =================================================================================================

::Const.Strings.PerkName.PoisonMaster <- "Poison Master";
::Const.Strings.PerkDescription.PoisonMaster <- "Improves lethality"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• Can now apply multiple poisons"
+ "\n" + ::green("+2") + " Poison Resistance";

::Const.Strings.PerkName.Untouchable <- "Untouchable";
::Const.Strings.PerkDescription.Untouchable <- "Improves survival"
+ "\n\n" + ::blue("« On Enemy Kill »")
+ "\n" + ::green("+4") + " [Untouchable] stacks"

+ "\n\n" + ::gray("« Untouchable » Max 4")
+ "\n" + ::gray("While this character has stacks, they take 0 damage from most attacks. Things like explosions or undodgeable attacks are exceptions")
+ "\n" + ::gray("• Lose 1 stack on 1H attack")
+ "\n" + ::gray("• Lose 2 stacks on 2H attack");
        
::Const.Strings.PerkName.BladeDancer <- "Blade Dancer";
::Const.Strings.PerkDescription.BladeDancer <- "Improves survival"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + "• [Footwork] costs 0 AP"
+ "\n\n" + ::blue("« On Missed or Grazed »")
+ "\n" + ::green("-1") + " [Fleche] CD"
+ "\n" + ::green("-1") + " [Footwork] CD"
+ "\n" + ::green("-1") + " [Escape] CD" + ::red(" 25% chance");

// =================================================================================================
// 6
// =================================================================================================
    
::Const.Strings.PerkName.LotusPoison <- "Lotus Poison";
::Const.Strings.PerkDescription.LotusPoison <- "TODO"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+1") + " Fat Recovery";
//TODO:implement
        
::Const.Strings.PerkName.Sap <- "Sap";
::Const.Strings.PerkDescription.Sap <- "TODO"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+1") + " Fat Recovery";
//TODO:implement
        
::Const.Strings.PerkName.Duelist2 <- "Duelist";
::Const.Strings.PerkDescription.Duelist2 <- "TODO"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+1") + " Fat Recovery";
//TODO:implement
        
// =================================================================================================
// 7
// =================================================================================================
    
::Const.Strings.PerkName.UncannyDodge <- "Uncanny Dodge";
::Const.Strings.PerkDescription.UncannyDodge <- "TODO"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+1") + " Fat Recovery";
//TODO:implement
        
::Const.Strings.PerkName.ViciousInsight <- "Vicious Insight";
::Const.Strings.PerkDescription.ViciousInsight <- "TODO"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+1") + " Fat Recovery";
//TODO:implement
        
::Const.Strings.PerkName.WeaponMaster <- "Weapon Master";
::Const.Strings.PerkDescription.WeaponMaster <- "TODO"
+ "\n\n" + ::blue("« Passive »")
+ "\n" + ::green("+1") + " Fat Recovery";
//FIXME: Rogue - implement after weapon trees are done