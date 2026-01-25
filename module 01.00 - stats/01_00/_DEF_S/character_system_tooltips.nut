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

        case "Rogue":
            local ki_text = ::seagreen("Keen Insight") 
                + "\n "+ "Apply [Flaw] (Range 2):"
                + "\n "+ "• On attacked by an AOE melee"
                + "\n "+ "• 15% - Attacked"
                + "\n "+ "• 15% - Attacking";
            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/special_named.png",
                text = ki_text
            });

            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/special_named.png",
                text = ::seagreen("Footwork") + " - Adds the [Footwork] active"
            });

            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/special_named.png",
                text = ::seagreen("Throwing Proficiency") + ::red(" (at Lvl 3)") + " - Gain the ability to use Throwing weapons"
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
                text = ::seagreen("Underdog") + " - The defense malus due to being surrounded by opponents is reduced by 5"
            });
            break;
    }
}

// gets the weapon tree that would be added if button is pressed
::Z.S.tt_weapon_tree <- function(ret, _player)
{
    local key = "Weapon Trees";
    if (_player.getFlags().has(key))
    {
        local tree_str =  _player.getFlags().get(key);
        local trees = split(tree_str, "|");
        if (trees.len() == 1)
        {
            local tree_name = trees[0];
            local tree_def = ::Z.S.get_weapon_tree_to_add( _player, tree_name);
            if (tree_def != null)
            {
                ret.push({
                    id = 10,
                    type = "text",
                    icon = "ui/icons/warning.png",
                    text = ::seagreen(tree_def.Name) + " tree can be added"
                });
            }
        }
    }
    else
    {
        local tree_def = ::Z.S.get_weapon_tree_to_add( _player);
        if (tree_def != null)
        {
            ret.push({
                id = 10,
                type = "text",
                icon = "ui/icons/warning.png",
                text = ::seagreen(tree_def.Name) + " tree can be added"
            });
        }
    }

    
}

// =================================================================================================
// Helper
// =================================================================================================

::Z.S.sum_arr <- function(arr)
{
    local ret = 0;
    foreach( n in arr )
    {
        ret += n;
    }
    return ret;
}