// Defines functions to help calculate damage

// =================================================================================================
// Associated tmp variables and managers
// =================================================================================================


// =================================================================================================
// Main
// =================================================================================================

::Z.S.get_class_passives <- function(ret, class_name)
{
    ret.push({
        id = 1,
        type = "text",
        text = "[u][size=14]Class Passives[/size][/u]"
    });

    switch (class_name) 
    {
        case null:
            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/warning.png",
                text = ::red("This character does not have a class yet")
            });
            break;

        case "Vanguard":
            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/special_named.png",
                text = ::seagreen("Brawny") + " - All armor weight is reduced by 70%"
            });
            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/special_named.png",
                text = ::seagreen("Underdog") + " - The defense malus due to being surrounded by opponents is reduced by 5."
            });
            break;
    }
}

// =================================================================================================
// Helper
// =================================================================================================

