// This file defines static functions involving character classes

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

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

// =========================================================================================
// Helper
// =========================================================================================
