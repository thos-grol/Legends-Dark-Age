::DEF.C.Traits_AI_Blacklisted <- {
    "trait.bright" : 0,
    "trait.fear_beasts" : 0,
    "trait.fear_undead" : 0,
    "trait.fear_greenskins" : 0,
    "trait.fear_humans" : 0,
};

::DEF.C.Traits_Character <- [
	::Legends.Trait.Fainthearthed, //FIXME: fix id typo when legends fixes it
	::Legends.Trait.Hesistant, //FIXME: fix id typo when legends fixes it
	::Legends.Trait.Tough,
	::Legends.Trait.Strong,
	::Legends.Trait.Quick,
	::Legends.Trait.Tiny,
	::Legends.Trait.Cocky,
	::Legends.Trait.Clumsy,
	::Legends.Trait.Fearless,
	::Legends.Trait.Fat,
	::Legends.Trait.Bright,
	::Legends.Trait.Bleeder,
	::Legends.Trait.Ailing,
	::Legends.Trait.Determined,
	::Legends.Trait.Deathwish,
	::Legends.Trait.Fragile,
	::Legends.Trait.Insecure,
	// ::Legends.Trait.Superstitious,
	::Legends.Trait.Brave,
	::Legends.Trait.Dexterous,
	::Legends.Trait.SureFooting,
	::Legends.Trait.Asthmatic,
	::Legends.Trait.IronLungs,
	::Legends.Trait.Craven,
	::Legends.Trait.Greedy,
	::Legends.Trait.Athletic,
	::Legends.Trait.Brute,
	// ::Legends.Trait.Clubfooted, //removed, this perk barely does anything
	// ::Legends.Trait.Loyal,
	// ::Legends.Trait.Disloyal,
	::Legends.Trait.Bloodthirsty,
	::Legends.Trait.IronJaw,
	::Legends.Trait.Survivor,
	::Legends.Trait.Swift,
	::Legends.Trait.NightBlind,
	// ::Legends.Trait.NightOwl,
	::Legends.Trait.Paranoid,
	// ::Legends.Trait.HateGreenskins, //removed, merge
	// ::Legends.Trait.HateUndead,
	// ::Legends.Trait.HateBeasts,
	::Legends.Trait.FearBeasts,
	::Legends.Trait.FearUndead,
	::Legends.Trait.FearGreenskins,
	::Legends.Trait.Teamplayer,
	// ::Legends.Trait.Weasel,
	::Legends.Trait.Huge,
	::Legends.Trait.Lucky,
	::Legends.Trait.Natural,
	::Legends.Trait.LegendPragmatic,
];


::DEF.C.Traits_map_id_stat <- {
	"AgileTree" : ::Const.Attributes.Initiative,
	"IndestructibleTree" : ::Const.Attributes.Bravery,
	"CalmTree" : ::Const.Attributes.RangedDefense,
	"LargeTree" : ::Const.Attributes.RangedSkill,
	"SturdyTree" : ::Const.Attributes.Hitpoints,
	"FitTree" : ::Const.Attributes.Fatigue,
};