// -40 difficulty means you need about 130 resolve to ignore the check
// -30, 120
//   0, 80
// -20, 60

// Make morale checks more brutal to encourage investing in mettle
::Const.Morale.OnHitBaseDifficulty <- -50; // used to be -40
::Const.Morale.AllyKilledBaseDifficulty <- 15; // used to be 20
::Const.Morale.AllyFleeingBaseDifficulty <- 25; // used to be 30