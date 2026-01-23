local traitDefs = [];

::Legends.Trait.Rogue <- null;
traitDefs.push({
	ID = "trait.rogue",
	Script = "scripts/skills/traits/rogue_trait",
	Const = "Rogue",
	Random = false
});

::Legends.Traits.addTraitDefObjects(traitDefs);