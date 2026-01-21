this.bag_poison <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "bag.oil_poison";
		this.m.Name = "Poisoned Oil";
		this.m.Description = "A flask of oil laced with concentrated poison.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_04.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 150;
	}

	function getTooltip()
	{
		local effect_str = "Inflict " + ::seagreen("T2 Poison")
		+ "\n" + "• " + ::green("50%") + " chance"
		+ "\n" + "• At least " + ::red("6") + " Health damage"
		+ "\n" + "• " + ::red("Cut") + " or " + ::red("Pierce") + " damage";

		local result = this.accessory.getTooltip();
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = effect_str
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::red("Only 1 poison can be applied per hit without the relevant mastery")
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
	}

	function onPutIntoBag()
	{
	}

});

