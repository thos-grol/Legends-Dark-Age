::DEF.C.Effects <- {};
::DEF.C.EffectsType <- {};

::DEF.C.EffectsType["effects.stunned"] <- "Physical";
::DEF.C.Effects["effects.stunned"] <- [
    { // 0
        "result" : "REMOVED",
    },
    { // 1
        "result" : "REPLACED",
        "effect" : ::Legends.Effect.LegendDazed,
        "tier" : 2,
    },
    { // 2
        "result" : "ADD",
        "duration" : 1,
    },
    { // 3
        "result" : "ADD",
        "duration" : 2,
    },
    { // 4
        "result" : "ADD",
        "duration" : 2,
    },
    { // 5
        "result" : "ADD",
        "duration" : 3,
    },
];

::DEF.C.EffectsType["effects.dazed"] <- "Physical";
::DEF.C.Effects["effects.dazed"] <- [
    { // 0
        "result" : "REMOVED",
    },
    { // 1
        "result" : "ADD",
        "duration" : 1,
    },
    { // 2
        "result" : "ADD",
        "duration" : 1,
    },
    { // 3
        "result" : "ADD",
        "duration" : 2,
    },
    { // 4
        "result" : "ADD",
        "duration" : 2,
    },
    { // 5
        "result" : "ADD",
        "duration" : 3,
    },
];

::DEF.C.EffectsType["effects.weakness"] <- "Physical";
::DEF.C.Effects["effects.weakness"] <- [
    { // 0
        "result" : "REMOVED",
    },
    { // 1
        "result" : "ADD",
        "duration" : 1,
    },
    { // 2
        "result" : "ADD",
        "duration" : 1,
    },
    { // 3
        "result" : "ADD",
        "duration" : 2,
    },
    { // 4
        "result" : "ADD",
        "duration" : 2,
    },
    { // 5
        "result" : "ADD",
        "duration" : 3,
    },
];

// Bleed

::DEF.C.EffectsType["effects.bleeding"] <- "Bleed";
::DEF.C.Effects["effects.bleeding"] <- [
    { // 0
        "result" : "REMOVED",
    },
    { // 1
        "result" : "ADD",
        "duration" : 1,
    },
    { // 2
        "result" : "ADD",
        "duration" : 1,
    },
    { // 3
        "result" : "ADD",
        "duration" : 2,
    },
    { // 4
        "result" : "ADD",
        "duration" : 2,
    },
    { // 5
        "result" : "ADD",
        "duration" : 3,
    },
];

// Poison

::DEF.C.EffectsType["effects.spider_poison"] <- "Poison";
::DEF.C.Effects["effects.spider_poison"] <- [
    { // 0
        "result" : "REMOVED",
    },
    { // 1
        "result" : "REDUCED",
        "duration" : 1,
    },
    { // 2
        "result" : "ADD",
        "duration" : 1,
    },
    { // 3
        "result" : "ADD",
        "duration" : 2,
    },
    { // 4
        "result" : "ADD",
        "duration" : 2,
    },
    { // 5
        "result" : "ADD",
        "duration" : 3,
    },
];

::DEF.C.EffectsType["effects.goblin_poison"] <- "Poison";
::DEF.C.Effects["effects.goblin_poison"] <- [
    { // 0
        "result" : "REMOVED",
    },
    { // 1
        "result" : "REDUCED",
        "duration" : 1,
    },
    { // 2
        "result" : "ADD",
        "duration" : 1,
    },
    { // 3
        "result" : "ADD",
        "duration" : 2,
    },
    { // 4
        "result" : "ADD",
        "duration" : 2,
    },
    { // 5
        "result" : "ADD",
        "duration" : 3,
    },
];