
this.perk_poisoner <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.poisoner";
		this.m.Name = ::Const.Strings.PerkName.Poisoner;
		this.m.Description = ::Const.Strings.PerkDescription.Poisoner;
		this.m.Icon = "ui/perks/poisoner.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
 
	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled()) return;

		local f = actor.getFlags();
		if (f.has("perk.poisoner item added")) return;

		//0. check if bag slots are available
		local items = actor.getItems();

		local free_bag_slot = false;
		local num_bag_slots = items.getUnlockedBagSlots();
		for(local i = 0; i < ::Const.ItemSlotSpaces[::Const.ItemSlot.Bag]; i++)
		{
			if (i >= num_bag_slots) break;
			if (items.getItemAtBagSlot(i) == null) 
			{
				free_bag_slot = true;
				break;
			}
		}
		
		if (free_bag_slot)
		{
			
			if (!f.has("perk.poisoner item added"))
			{
				items.addToBag(::new("scripts/items/bag/bag_poison"));
				f.set("perk.poisoner item added", true);
			}
		}
		else //if not, refund the perk
		{
			actor.m.PerkPoints += 1;
			actor.m.PerkPointsSpent -= 1;
			this.removeSelf();
		}
	}
});