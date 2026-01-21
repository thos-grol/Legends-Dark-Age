
::DEF.C.Stats.Class.Vanguard <- {};
::DEF.C.Stats.Class.Rogue <- {};
::DEF.C.Stats.Class.Scrapper <- {};
::DEF.C.Stats.Class.Ranger <- {};

// Vanguards focuses on health and endurance and ignore agility
//                              Levels     0   1   2   3   4   5   6   7
::DEF.C.Stats.Class.Vanguard.Hitpoints <- [0,  0,  15, 10, 5,  10, 0,  20];
::DEF.C.Stats.Class.Vanguard.Endurance <- [0,  0,  15, 10, 5,  10, 0,  20];
::DEF.C.Stats.Class.Vanguard.Agility   <- [0,  0,  0,  0,  0,  0,  0,  10];
::DEF.C.Stats.Class.Vanguard.Mettle    <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Vanguard.Recovery  <- [0,  0,  2,  3,  4,  5,  0,  10];
::DEF.C.Stats.Class.Vanguard.Skill     <- [0,  0,  10, 5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Vanguard.Defense   <- [0,  0,  0,  5,  0,  5,  0,  10];

// Rogues focuses on skill/def and agility and ignore health
// They also have signifigant output ability
//                              Levels     0   1   2   3   4   5   6   7
::DEF.C.Stats.Class.Rogue.Hitpoints    <- [0,  0,-20,  0,  0,  0,  0,  0 ];
::DEF.C.Stats.Class.Rogue.Endurance    <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Rogue.Agility      <- [0,  0,  15, 10, 5,  10, 0,  20];
::DEF.C.Stats.Class.Rogue.Mettle       <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Rogue.Recovery     <- [0,  0,  2,  3,  4,  5,  0,  10];
::DEF.C.Stats.Class.Rogue.Skill        <- [0,  0,  10, 5,  10, 5,  10, 10];
::DEF.C.Stats.Class.Rogue.Defense      <- [0,  0,  5,  10, 0,  5,  0,  10];

// Scrapper focuses on mettle and agility and ignore endurance
//                              Levels     1   2   3   4   5   6   7   8
::DEF.C.Stats.Class.Scrapper.Hitpoints <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Scrapper.Endurance <- [0,  0,  0,  0,  0,  0,  0,  10];
::DEF.C.Stats.Class.Scrapper.Agility   <- [10, 10, 10, 10, 10, 10, 10, 20];
::DEF.C.Stats.Class.Scrapper.Mettle    <- [10, 10, 10, 10, 10, 10, 10, 20];
::DEF.C.Stats.Class.Scrapper.Skill     <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Scrapper.Defense   <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Scrapper.Recovery  <- [1,  1,  1,  1,  1,  1,  1,  5];

// Rangers focuses on skill and endurance and ignore mettle
//                              Levels     1   2   3   4   5   6   7   8
::DEF.C.Stats.Class.Ranger.Hitpoints    <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Ranger.Endurance    <- [10, 10, 10, 10, 10, 10, 10, 20];
::DEF.C.Stats.Class.Ranger.Agility      <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Ranger.Mettle       <- [0,  0,  0,  0,  0,  0,  0,  10];
::DEF.C.Stats.Class.Ranger.Skill        <- [5,  5,  10, 5,  10, 5,  10, 20];
::DEF.C.Stats.Class.Ranger.Defense      <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Ranger.Recovery     <- [1,  1,  1,  1,  1,  1,  1,  5];