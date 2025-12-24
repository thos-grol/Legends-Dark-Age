local effectsDefs = [];

::Legends.Effect.Flaw <- null;
effectsDefs.push({
	ID = "effects.flaw",
	Script = "scripts/skills/effects/flaw_effect",
	Const = "Flaw",
	Name = "Flaw",
});

::Legends.Effect.Weakness <- null;
effectsDefs.push({
	ID = "effects.weakness",
	Script = "scripts/skills/effects/weakness_effect",
	Const = "Weakness",
	Name = "Weakness",
});

::Legends.Effect.Dazed <- null;
effectsDefs.push({
	ID = "effects.dazed",
	Script = "scripts/skills/effects/dazed_effect",
	Name = "Dazed",
	Const = "Dazed"
});

::Legends.Effects.addEffectDefObjects(effectsDefs);