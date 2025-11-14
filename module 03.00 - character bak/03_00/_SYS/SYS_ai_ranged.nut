::mods_hookExactClass("entity/tactical/actor", function ( o )
{
	o.hasRangedWeapon = function( _trueRangedOnly = false )
	{
		local items = [];
		local mainhand = this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand);

		if (mainhand != null)
		{
			items.push(mainhand);
		}

		local bags = this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag);

		if (bags.len() != 0)
		{
			items.extend(bags);
		}

		if (items.len() == 0)
		{
			return false;
		}

		foreach( it in items )
		{
			if (it.isItemType(::Const.Items.ItemType.RangedWeapon) && (!_trueRangedOnly || ::Math.min(it.getRangeMax(), this.m.CurrentProperties.getVision()) >= 6 && ::Z.S.get_ranged_details(this).is_ranged_unit ))
			{
				if (it.getAmmoMax() == 0 && it.getAmmoID() == "")
				{
					return true;
				}
				else if (it.getAmmoMax() == 0)
				{
					local ammo = this.m.Items.getItemAtSlot(::Const.ItemSlot.Ammo);

					if (ammo != null && ammo.getID() == it.getAmmoID() && ammo.getAmmo() > 0)
					{
						return true;
					}

					foreach( ammo in bags )
					{
						if (ammo != null && ammo.getID() == it.getAmmoID() && ammo.getAmmo() > 0)
						{
							return true;
						}
					}
				}
				else if (it.getAmmo() > 0)
				{
					return true;
				}
			}
		}

		return false;
	}

	o.getRangedWeaponInfo = function()
	{
		local items = [];
		local result = {
			HasRangedWeapon = false,
			IsTrueRangedWeapon = false,
			Range = 0,
			RangeWithLevel = 0
		};
		local mainhand = this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand);

		if (mainhand != null)
		{
			items.push(mainhand);
		}

		local bags = this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag);

		if (bags.len() != 0)
		{
			items.extend(bags);
		}

		if (items.len() == 0)
		{
			return result;
		}

		foreach( it in items )
		{
			if (it.isItemType(::Const.Items.ItemType.RangedWeapon))
			{
				local isViable = false;

				if (it.getAmmoMax() == 0 && it.getAmmoID() == "")
				{
					isViable = true;
				}
				else if (it.getAmmo() > 0)
				{
					isViable = true;
				}
				else if (it.getAmmoMax() == 0)
				{
					local ammo = this.m.Items.getItemAtSlot(::Const.ItemSlot.Ammo);

					if (ammo != null && ammo.getID() == it.getAmmoID() && ammo.getAmmo() > 0)
					{
						isViable = true;
					}

					foreach( ammo in bags )
					{
						if (ammo != null && ammo.getID() == it.getAmmoID() && ammo.getAmmo() > 0)
						{
							isViable = true;
						}
					}
				}

				if (isViable)
				{
					result.HasRangedWeapon = true;
					local range = ::Math.min(it.getRangeEffective() + it.getAdditionalRange(this), this.m.CurrentProperties.getVision());

					if (range >= 6 && ::Z.S.get_ranged_details(this).is_ranged_unit) result.IsTrueRangedWeapon = true;

					result.Range = ::Math.max(result.Range, range);
					result.RangeWithLevel = ::Math.max(result.RangeWithLevel, range + ::Math.min(it.getRangeMaxBonus(), this.getTile().Level));
				}
			}
		}

		return result;
	}	
});

::mods_hookBaseClass("ai/tactical/behavior", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.isRangedUnit = function ( _entity )
	{
		if (_entity == null)
		{
			return false;
		}

		if (!("hasRangedWeapon" in _entity))
		{
			return false;
		}

		local hasRangedWeapon = _entity.hasRangedWeapon();
		if (hasRangedWeapon && _entity.getCurrentProperties().getVision() > 4
			&& ::Z.S.get_ranged_details(_entity).is_ranged_unit
		)
		{
			return true;
		}

		return false;
	};
	o.queryBestMeleeTarget = function ( _entity, _skill, _targets )
	{
		local bestTarget;
		local bestScore = -9000;
		local ret = {
			Score = 0.0,
			Target = null
		};

		foreach( target in _targets )
		{
			if (_skill != null && !_skill.isUsableOn(target.getTile()))
			{
				continue;
			}

			local score = this.queryTargetValue(_entity, target, _skill);

			if (this.getAgent().getForcedOpponent() != null && this.getAgent().getForcedOpponent().getID() == target.getID())
			{
				score = score * 1000;
			}

			if (score > bestScore)
			{
				bestTarget = target;
				bestScore = score;
			}
		}

		if (bestTarget != null)
		{
			ret.Score = bestScore;
			ret.Target = bestTarget;
		}

		return ret;
	};
});

