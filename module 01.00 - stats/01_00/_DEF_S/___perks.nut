// This file defines static functions involving player perks
// - deals with class system
// - deals with weapon system

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

// placeholders that will be loaded later

::Z.T.map_weapon_str_to_tree <- {}

// =========================================================================================
// Main
// =========================================================================================

// called when a class is randomly assigned
::Z.S.set_class_random <- function ( _player )
{
    local _newTree = ::Const.Perks.ClassTrees.getRandom(null);
    ::Z.S.set_class(_player, _newTree);
}

// called when an item sets the class
::Z.S.set_class <- function ( _player, _newTree )
{
    _player.getBackground().addPerkGroup(_newTree.Tree);
    _player.getFlags().add("Class Added");
    _player.getFlags().set("Class", _newTree.Name);

    if (_newTree.Name == "Rogue")
    {
        ::Legends.Traits.grant(_player, ::Legends.Trait.Rogue);
    }

    // update ui
    _player.updateLevel();
}

// placeholder, real function is defined in upcoming modules
::Z.S.set_weapon_tree <- function ( _player, _newTree )
{
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.get_weapon_tree_to_add <- function ( _player, _existing_tree = null )
{
    // if has main hand item
    ::logInfo("mainhand");
    local mainhand = _player.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
    if (mainhand != null)
    {
        ::logInfo("reached");
        local categories = split(mainhand.m.Categories, ","); //ie. "Sword, One-Handed"
        foreach (category in categories)
        {
            local category_str = strip(category);
            ::logInfo(category_str);
            if (category_str == "One-Handed") continue;
            if (category_str == "Two-Handed") continue;
            if (_existing_tree != null && category_str == _existing_tree) break;

            if (category_str in ::Z.T.map_weapon_str_to_tree)
                return ::Z.T.map_weapon_str_to_tree[category_str];
        }
    }
    else // fists
    {
        if (_existing_tree != "Unarmed")
        {
            return ::Const.Perks.FistsTree;
        }
    }

    local offhand = _player.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
	if (offhand != null)
    {
        if (offhand.isItemType(::Const.Items.ItemType.Shield) && _existing_tree != "Shield")
        {
            return ::Const.Perks.ShieldTree;
        }
    }
            
    // for bag items
    local bag_items = _player.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
    foreach (item in bag_items)
    {
        if (item.m.Categories == "") continue;
        local categories = split(item.m.Categories, ","); //ie. "Sword, One-Handed"
        foreach (category in categories)
        {
            local category_str = strip(category);
            if (category_str == "One-Handed") continue;
            if (category_str == "Two-Handed") continue;
            if (_existing_tree != null && category_str == _existing_tree) break;

            if (category_str == "Throwing Weapon") return ::Const.Perks.ThrowingTree;
        }
    }

    return null;
}

//TODO: on character details show what weapon tree will be added while there is < 2
::Z.S.is_add_weapon_tree_button_enabled <- function ( _player )
{
    // don't add weapon trees before class trees
    if (!_player.getFlags().has("Class Added")) return false;

    local key = "Weapon Trees";
    if (!_player.getFlags().has(key)) return true;

    local tree_str =  _player.getFlags().get(key);
    local trees = split(tree_str, "|");

    if (trees.len() >= 2) return false;
    if (trees.len() == 1)
    {
        local tree_name = trees[0];
        return ::Z.S.get_weapon_tree_to_add( _player, tree_name ) != null;
    }
    return true;
}