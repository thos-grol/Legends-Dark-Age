local decks = [
    "ROLL",
    "TURN",
];
local factions = [
    "ADELHEIM",
];
local types = [
    "CAPITAL",
    "VILLAGE",
];

foreach( deck in decks )
{
    ::DEF.C.Factions.Decks[deck] <- {};
    foreach( faction in factions )
    {
        ::DEF.C.Factions.Decks[deck][faction] <- {};
        foreach( type in types )
        {
            ::DEF.C.Factions.Decks[deck][faction][type] <- [];
        }
    }
}

::DEF.C.Factions.Decks["GLOBAL"] <- [];
::DEF.C.Factions.Decks["GLOBAL"].push("scripts/factions/contracts/generate_village_contracts_action");