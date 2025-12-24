// this hooks the background class and descendants
// hk - recruits don't come with weapon and armor normally
::m.hookTree("scripts/skills/backgrounds/character_background", function(q) {

	// hk - recruits don't come with weapon and armor normally
	q.onAddEquipment <- function() 
	{
		local items = this.getContainer().getActor().getItems();
		if (this.m.IsNoble)
		{
			items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.noble_tunic]
			]));
		}
		else
		{
			items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.linen_tunic]
			]));
		}
	}
});