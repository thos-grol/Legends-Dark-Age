::mods_hookExactClass("items/item_container", function (o)
{
    o.dropAll <- function( _tile, _killer, _flip = false )
	{
		local actor = this.m.Actor;
        local isPlayer = actor.getFaction() == ::Const.Faction.Player || this.isKindOf(actor.get(), "player");
        local IsDroppingLoot = true;
		local emergency = false;

        //no killstealing
		local no_killstealing = ::Legends.Effects.get(actor, ::Legends.Effect.NoKillstealing);
		if (no_killstealing != null) IsDroppingLoot = no_killstealing.isDroppingLoot();

		//no looting allies
		if (_killer != null && _killer.isPlayerControlled() && !isPlayer && _killer.isAlliedWith(actor)) IsDroppingLoot = false;

		if (_tile == null)
		{
			if (actor.isPlacedOnMap())
			{
				_tile = actor.getTile();
				emergency = true;
			}
			else return;
		}

		for( local i = 0; i < ::Const.ItemSlot.COUNT; i = ++i )
		{
			for( local j = 0; j < this.m.Items[i].len(); j = ++j )
			{
				if (this.m.Items[i][j] == null || this.m.Items[i][j] == -1)
				{
				}
				else if (this.m.Items[i][j].isChangeableInBattle() || emergency)
				{
					if (IsDroppingLoot || this.m.Items[i][j].isItemType(::Const.Items.ItemType.Legendary))
					{
						this.m.Items[i][j].drop(_tile);
					}
					else
					{
						this.m.Items[i][j].m.IsDroppedAsLoot = false;
					}
				}
				else if (!IsDroppingLoot && !this.m.Items[i][j].isItemType(::Const.Items.ItemType.Legendary))
				{
					this.m.Items[i][j].m.IsDroppedAsLoot = false;
				}
			}
		}

		_tile.IsContainingItemsFlipped = _flip;
	}
});