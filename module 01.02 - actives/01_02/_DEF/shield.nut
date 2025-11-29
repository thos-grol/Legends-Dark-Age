local ret = [];

::Legends.Active.Safeguard <- null;
ret.push({
	ID = "actives.safeguard",
	Script = "scripts/skills/actives/safeguard_skill",
	Const = "Safeguard",
	Name = "Safeguard",
});

::Legends.Actives.addActiveDefObjects(ret);