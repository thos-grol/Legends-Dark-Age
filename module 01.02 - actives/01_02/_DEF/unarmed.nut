local ret = [];

::Legends.Active.H2H <- null;
ret.push({
	ID = "actives.hand_to_hand",
	Script = "scripts/skills/actives/h2h",
	Const = "H2H",
	Name = "H2H",
});

::Legends.Actives.addActiveDefObjects(ret);