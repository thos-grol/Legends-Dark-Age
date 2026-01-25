
// =================================================================================================
// 2
// =================================================================================================
    
::Const.Strings.PerkName.Tempi <- "Tempi";
::Const.Strings.PerkDescription.Tempi <- "Improves lethality"
+ "\n\n" + ::blue("« On Miss »")
+ "\n" + ::green("25%") + " chance to gain 3 AP"
+ "\n " + ::red("• Expires on turn end")
+ "\n\n" + ::blue("« On Hit »")
+ "\n" + ::green("+5%") + " [On Miss] chance"
+ "\n " + ::red("• All charges are lost when [On Miss] effect triggers");
        
// =================================================================================================
// 4
// =================================================================================================

::Const.Strings.PerkName.SpecSword2 <- "Sword Proficiency";
::Const.Strings.PerkDescription.SpecSword2 <- ::purple("Proficiency")
+ "\n\n" + ::blue("« Passive »")
+ "\n " + ::green("– 25%") + " skill fatigue (Swords)"
+ "\n\n" + ::blue("End turn, sword equipped:")
+ "\n[Riposte] for free"
+ "\n " + ::red("• Invalid with less than 15 [Endurance] remaining")
+ "\n " + ::red("• If the sword does not have riposte, perform a cqc attack with a 50% chance of [Daze]")
+ ::DEF.C.Effect_Explanations["Daze"];

// =================================================================================================
// 6
// =================================================================================================
    
::Const.Strings.PerkName.TheStrongest <- "The Strongest";
::Const.Strings.PerkDescription.TheStrongest <- ::purple("Stance")
+ "\n\n" + ::blue("« On Hit (by Enemy) »")
+ "\n " + "Parry the strike and strike back"
+ "\n " + ::red("• Needs 1 [Charge] to function")
+ "\n " + ::red("• +1 [Charge] on [Turn Start]")
+ "\n " + ::red("• Retaliation works at weapon range");

        