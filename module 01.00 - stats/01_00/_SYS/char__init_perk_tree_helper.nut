

// hk - modify fn definition to use actor flags, so we can record information
// into the actor
::Const.Perks.GetDynamicPerkTree <- function ( _flags )
{
	local tree = [ [], [], [], [], [], [], [], [], [], [], [] ];

	local TREES = {
		Traits = [],
	}

	// if ("Traits" in _map) {
	// 	foreach (p in _map.Traits)
	// 	{
	// 		TREES.Traits.push(p);
	// 	}
	// }
	
	for (local i = 0; i < 2; i = ++i)
	{
		local _exclude = [];
		foreach (tt in TREES.Traits)
		{
			_exclude.push(tt.ID);
		}
		local t = ::Const.Perks.TraitsTrees.get_random(_exclude, _flags, i);
		TREES.Traits.push(t);
	}

	local _totals = {}
	local _overflows = {}
	foreach (type_tree in TREES)
	{
		local idx = 0;
		foreach(T in type_tree)
		{
			foreach (i, row in T.Tree)
			{
				if (!(i in _totals)) {
					_totals[i] <- 0;
					_overflows[i] <- [];
				}

				foreach(j, p in row)
				{
					if (_totals[i] >= 13)
					{
						_overflows[i].push(p);
						continue;
					}
					_totals[i] += 1;
					tree[i].push(p);
				}
			}
			idx++;
		}
	}

	//Handle overlow of perks in a row
	// local _direction = 1
	foreach (index, L in _overflows)
	{
		local nextIndex = index;
		local foundIndexToSlot = true;
		for (local i = 0; i < L.len(); i = ++i)
		{
			while (nextIndex < 7 && _totals[nextIndex] >= 13 ) { //assume we start index 6, last row
				nextIndex++; //attatch to row 7, actually tier 8 of perk tree
				if (nextIndex > 6) { //adds new index to our tree for this
					foundIndexToSlot = false //if this is ever false than our starting row and everything past it is overflowed, so we go back one
				}
			}
			if (foundIndexToSlot == false)
			{
				nextIndex = index;
				foundIndexToSlot = true;
				while(nextIndex > 0 && _totals[nextIndex] >= 13) { //if nextIndex is ever somehow -1 that means everything past the row it tried was overflow and everything before it, so we just drop the perk then
					nextIndex--;
					if (nextIndex < 0) {
						foundIndexToSlot = false;
					}
				}
			}
			if (foundIndexToSlot) //if we somehow haven't found an index to slot a perk it just gets junked because the entire tree is max perk, guarantees an overflow. can change this
			{
				// this.logWarning("Originally had a perk on index: " + index + ", put it on index: " + nextIndex);
				tree[nextIndex].push(L[i]);
				_totals[nextIndex] += 1;
			}
		}
	}

	foreach (t in TREES.Traits)
	{
		if (!_flags.has("traits")) _flags.set("traits", "Traits: ");
        _flags.set("traits", _flags.get("traits") + t.Name + ", ");
	}

	return tree;
}



::Const.Perks.BuildCustomPerkTree <- function (_custom)
{
	local pT = {
		Tree = [],
		Map = {}
	}
	pT.addPerk <- function (_perk, _row=0)
	{
		local perk = clone this.Const.Perks.PerkDefObjects[_perk];
		//Dont add dupes
		// if (perk.ID in this.Map)
		// {
		// 	return;
		// }
		perk.Row <- _row;
		perk.Unlocks <- _row;
		perk.IsRefundable <- true;
		for (local i = this.Tree.len(); i < _row + 1; i = ++i)
		{
			this.Tree.push([]);
		}
		this.Tree[_row].push(perk);
		this.Map[perk.ID] <- perk;
	}

	pT.addTree <- function (_tree)
	{
		foreach(i, row in _tree)
		{
			foreach (p in row)
			{
				this.addPerk(p, i);
			}
		}
	}

	for( local row = 0; row < _custom.len(); row = ++row )
	{
		for( local i = 0; i < _custom[row].len(); i = ++i )
		{
			pT.addPerk(_custom[row][i], row)
		}
	}

	return pT;
};

// hk - set min number of perk trees
::mods_hookExactClass("skills/backgrounds/character_background", function (o){
	o.getPerkTreeDynamicMins <- function ()
	{
		return this.m.PerkTreeDynamicMins;
	}
});