// This file modifies/adds new character properties

// Hardness reduces damage done by Hardness Amount
::Const.CharacterProperties.Hardness <- 0;

// properties that determine whether an attack will choose between the highest or lowest of 2 rolls
// neutral is normal BB behavior
::Const.CharacterProperties.Disadvantage_Attack <- false;
::Const.CharacterProperties.Advantage_Attack <- false;
::Const.CharacterProperties.Disadvantage_Defense <- false;
::Const.CharacterProperties.Advantage_Defense <- false;

::Const.CharacterProperties.Alert_Defense <- false;
::Const.CharacterProperties.IsProficientWithRogue <- false;


// properties that determine whether an attack will roll min or max damage between 2 rolls
// neutral is normal BB behavior
::Const.CharacterProperties.Disstrike_Attack <- false;
::Const.CharacterProperties.Strike_Attack <- false;
::Const.CharacterProperties.Disstrike_Defense <- false;
::Const.CharacterProperties.Strike_Defense <- false;


::Const.CharacterProperties.IsAffectedByApproachingEnemies <- true;
::Const.CharacterProperties.BlockMastery <- false;
::Const.CharacterProperties.IsAffectedByStaminaHitDamage <- true;


// resistances
::Const.CharacterProperties.PhysicalResistance <- 0;
::Const.CharacterProperties.TechniqueResistance <- 0;
::Const.CharacterProperties.PoisonResistance <- 0;
::Const.CharacterProperties.BleedResistance <- 0;

::Const.CharacterProperties.FireResistance <- 0;
::Const.CharacterProperties.IceResistance <- 0;
::Const.CharacterProperties.NegativeResistance <- 0;