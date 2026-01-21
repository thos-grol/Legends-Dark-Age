local ret = [];

::Legends.Active.Fleche <- null;
ret.push({
	ID = "actives.fleche",
	Script = "scripts/skills/actives/fleche_skill",
	Const = "Fleche",
	Name = "Fleche",
});

::Legends.Actives.addActiveDefObjects(ret);