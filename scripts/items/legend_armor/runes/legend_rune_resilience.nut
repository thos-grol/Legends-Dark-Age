this.legend_rune_resilience <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.legend_rune_resilience";
		this.m.Type = ::Const.Items.ArmorUpgrades.Rune;
		this.m.Name = "Armor Rune Sigil: Resilience";
		this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
		this.m.ArmorDescription = "Includes An inscribed rock that grants additional resilience bonuses.";
		this.m.Icon = "rune_sigils/rune_stone_3.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "layers/glow_runed_icon.png";
		this.m.OverlayIconLarge = "layers/glow_runed_inventory.png";
		this.m.SpriteFront = "";
		this.m.SpriteBack = "";
		this.m.SpriteDamagedFront = "";
		this.m.SpriteDamagedBack = "";
		this.m.SpriteCorpseFront = "";
		this.m.SpriteCorpseBack = "";
		this.m.Value = 1200;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Resilience:\n[color=" + ::Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs."
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Resilience:\n[color=" + ::Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs."
		});
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		return _damage;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

	function onUse( _actor, _item = null )
	{
		if (!::Z.hasVala()) return false
		if (this.isUsed()) return false;
		local armor = _item == null ? _actor.getItems().getItemAtSlot(::Const.ItemSlot.Body) : _item;
		if (armor == null) return false;
		local success = armor.setUpgrade(this);
		if (success) this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", ::Const.Sound.Volume.Inventory);
		return success;
	}

	function onUnequip()
	{
		if (!::Z.hasVala()) return false
		this.item.onUnequip();
		if (::Legends.Mod.ModSettings.getSetting("AutoRepairLayer").getValue() && this.getCondition() != this.getConditionMax())
		{
			this.setToBeRepaired(true, 0);
		}
		this.setCurrentSlotType(::Const.ItemSlot.None);
	}

});

