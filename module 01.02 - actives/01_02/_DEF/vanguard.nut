local ret = [];

::Legends.Active.Safeguard <- null;
ret.push({
	ID = "actives.safeguard",
	Script = "scripts/skills/actives/safeguard_skill",
	Const = "Safeguard",
	Name = "Safeguard",
});

::Legends.Active.StunStrike <- null;
ret.push({
	ID = "actives.stun_strike",
	Script = "scripts/skills/actives/stun_strike_skill",
	Const = "StunStrike",
	Name = "Stun Strike",
});

::Legends.Active.LionsRoar <- null;
ret.push({
	ID = "actives.stun_strike",
	Script = "scripts/skills/actives/lions_roar",
	Const = "LionsRoar",
	Name = "Lion\'s Roar",
});

::Legends.Actives.addActiveDefObjects(ret);