//FIXME: audit and refactor file

// =========================================================================================
// Temp
// =========================================================================================


// =========================================================================================
// Main
// =========================================================================================

// =========================================================================================
// Helper
// =========================================================================================


// =========================================================================================
// Audit
// =========================================================================================

::Z.S.Perks_add <- function (_actor, _perk, _perk_row=1, _add_skill=true)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(::Const.Perks.PerkDefObjects[_perk].ID))
    {
        _actor.getSkills().removeByID(::Const.Perks.PerkDefObjects[_perk].ID);
        ++_actor.m.PerkPoints;
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)

    //add non-refundable version of perk to tree and add the perk to skills
    _actor.getBackground().addPerk(_perk, _perk_row, false);
    if (_add_skill) _actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[_perk].Script));
}

::Z.S.Perks_remove <- function (_actor, _perk)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(::Const.Perks.PerkDefObjects[_perk].ID))
    {
        _actor.getSkills().removeByID(::Const.Perks.PerkDefObjects[_perk].ID);
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)
}

::Z.S.Perks_tree <- function (_item)
{
    if (_item.isItemType(::Const.Items.ItemType.Shield)) return ::Const.Perks.ShieldTree.Tree;
    else if (_item.m.ID == "tool.throwing_net") return ::Const.Perks.BeastClassTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Flail)) return ::Const.Perks.FlailTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Hammer)) return ::Const.Perks.HammerTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Axe)) return ::Const.Perks.AxeTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Cleaver)) return ::Const.Perks.CleaverTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Sword)) return ::Const.Perks.SwordTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Polearm)) return ::Const.Perks.PolearmTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Spear)) return ::Const.Perks.SpearTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Crossbow)) return ::Const.Perks.BowTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Bow)) return ::Const.Perks.BowTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Sling)) return ::Const.Perks.BowTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Firearm)) return ::Const.Perks.BowTree.Tree;
    else return ::Const.Perks.HammerTree.Tree;
}

::Z.S.Perks_isProficiency <- function (_id)
{
    return _id in ::DEF.C.Perks.Proficiency;
}

::Z.S.Perks_isDestiny <- function (_id)
{
    return _id in ::DEF.C.Perks.Destiny;
}

::Z.S.Perks_isStance <- function (_id)
{
    return _id in ::DEF.C.Perks.Stance;
}

::Z.S.Perks_verifyStance <- function (_actor, _id)
{
    return _actor.getSkills().hasSkill(::DEF.C.Perks.Stance[_id]);
}

::Z.S.Perks_getWeaponPerkTree <- function (_item)
{
    local ret = [];
    local weaponToPerkMap = {
        Axe = ::Const.Perks.AxeTree,
        Bow = ::Const.Perks.BowTree,
        Cleaver = ::Const.Perks.CleaverTree,
        Crossbow = ::Const.Perks.BowTree,
        Firearm = ::Const.Perks.BowTree,
        Flail = ::Const.Perks.FlailTree,
        Hammer = ::Const.Perks.HammerTree,
        Mace = ::Const.Perks.MaceTree,
        Polearm = ::Const.Perks.PolearmTree,
        Sling = ::Const.Perks.BowTree,
        Spear = ::Const.Perks.SpearTree,
        Sword = ::Const.Perks.SwordTree
    };

    foreach( weapon, tree in weaponToPerkMap )
    {
        if (_item.isWeaponType(::Const.Items.WeaponType[weapon])) ret.push(tree);
    }

    return ret;
}

::Z.S.getNeighbors <- function( _tile, _function = null )
{
	local ret = [];
	for (local i = 0; i < 6; i++)
	{
		if (_tile.hasNextTile(i))
		{
			local nextTile = _tile.getNextTile(i);
			if (_function == null || _function(nextTile))
				ret.push(nextTile);
		}
	}
	return ret;
}

::Z.S.hasVala <- function()
{
	local brothers = ::World.getPlayerRoster().getAll();
    foreach( bro in brothers )
    {
        if (bro.getBackground().getID() == "background.legend_vala") return true;
    }
    return false;
}