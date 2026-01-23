
this.perk_quick_hands2 <- this.inherit("scripts/skills/skill", {
	m = {
		is_spent = false
	},
	function create()
	{
		this.m.ID = "perk.quick_hands2";
		this.m.Name = ::Const.Strings.PerkName.QuickHands2;
		this.m.Description = ::Const.Strings.PerkDescription.QuickHands2;
		this.m.Icon = "ui/perks/quick_hands2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.ItemActionOrder = ::Const.ItemActionOrder.Any;
	}

	function onPayForItemAction( _skill, _items )
	{
		if (_skill == this)
		{
			this.m.is_spent = true;
		}
	}

	// helper
	function getItemActionCost( _items )
	{
		// foreach (item in _items)
		// {
		// 	if (item != null && item.isItemType(::Const.Items.ItemType.Shield))
		// 	{
		// 		return null;
		// 	}
		// }
		return this.m.is_spent ? null : 0;
	}

	// management

	function onTurnStart()
	{
		this.m.is_spent = false;
	}

	function onCombatStarted()
	{
		this.m.is_spent = false;
	}

	function onCombatFinished()
	{
		this.m.is_spent = false;
	}
});