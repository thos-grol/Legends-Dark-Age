::Const.Perks.WeaponTrees <- {
	Tree = [
		::Const.Perks.FistsTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ShieldTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID) != null)
			{
				//this.logInfo("Excluding " + t.ID)
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}
};

::Const.Perks.MeleeWeaponTrees <- {
	Tree = [
		::Const.Perks.FistsTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.TwoHandedTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}
};

::Const.Perks.RangedWeaponTrees <- {
	Tree = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree)
		{
			foreach (p in row)
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}

};

::Z.T.map_weapon_str_to_tree <- {
    "Mace" : ::Const.Perks.MaceTree,
    "Flail" : ::Const.Perks.FlailTree,
    "Hammer" : ::Const.Perks.HammerTree,
    "Axe" : ::Const.Perks.AxeTree,
    "Cleaver" : ::Const.Perks.CleaverTree,
    "Sword" : ::Const.Perks.SwordTree,
    "Dagger" : ::Const.Perks.DaggerTree,
    "Polearm" : ::Const.Perks.PolearmTree,
    "Spear" : ::Const.Perks.SpearTree,
    "Crossbow" : ::Const.Perks.CrossbowTree,
    "Bow" : ::Const.Perks.BowTree,
    "Sling" : ::Const.Perks.SlingTree,
    "Shield" : ::Const.Perks.ShieldTree
}

::Z.S.set_weapon_tree <- function ( _player, _newTree )
{
    _player.getBackground().add_perk_group(_newTree.Tree);

    // update trees
    local key = "Weapon Trees";
    if (!_player.getFlags().has(key)) 
    {
        _player.getFlags().set(key, _newTree.Name);
    }
    else
    {
        local tree_str =  _player.getFlags().get(key);
        tree_str += "|" + _newTree.Name;
        _player.getFlags().set(key, tree_str);
    }

    // update ui
    _player.updateLevel();
}