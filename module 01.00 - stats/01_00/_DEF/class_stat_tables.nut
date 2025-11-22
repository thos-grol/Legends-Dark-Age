
::DEF.C.Stats.Class.Vanguard <- {};
::DEF.C.Stats.Class.Rogue <- {};

// Vanguards focuses on health and endurance and ignore agility
//                              Levels     1   2   3   4   5   6   7   8
::DEF.C.Stats.Class.Vanguard.Hitpoints <- [10, 10, 10, 10, 10, 10, 10, 20];
::DEF.C.Stats.Class.Vanguard.Endurance <- [10, 10, 10, 10, 10, 10, 10, 20];
::DEF.C.Stats.Class.Vanguard.Agility   <- [0,  0,  0,  0,  0,  0,  0,  10];
::DEF.C.Stats.Class.Vanguard.Mettle    <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Vanguard.Skill     <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Vanguard.Defense   <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Vanguard.Recovery  <- [1,  1,  1,  1,  1,  1,  1,  5];

// Rogues focuses on skill and agility and ignore mettle
//                              Levels     1   2   3   4   5   6   7   8
::DEF.C.Stats.Class.Rogue.Hitpoints    <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Rogue.Endurance    <- [5,  5,  5,  5,  5,  5,  5,  10];
::DEF.C.Stats.Class.Rogue.Agility      <- [10, 10, 10, 10, 10, 10, 10, 20];
::DEF.C.Stats.Class.Rogue.Mettle       <- [0,  0,  0,  0,  0,  0,  0,  10];
::DEF.C.Stats.Class.Rogue.Skill        <- [5,  5,  10, 5,  10, 5,  10, 20];
::DEF.C.Stats.Class.Rogue.Defense      <- [0,  0,  5,  5,  0,  5,  5,  10];
::DEF.C.Stats.Class.Rogue.Recovery     <- [1,  1,  1,  1,  1,  1,  1,  5];

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