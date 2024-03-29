this.smoke_bomb_item <- this.inherit("scripts/items/tools/alchemy_tool", {
	m = {},
	function create()
	{
		this.alchemy_tool.create();
		this.m.ID = "weapon.smoke_bomb";
		this.m.Name = "Smoke Pot";
		this.m.Description = "A small pot that quickly creates a dense smoke cloud when broken on the ground. Useful for covering movement.";
		this.m.IconLarge = "tools/smoke_bomb_01.png";
		this.m.Icon = "tools/smoke_bomb_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Tool;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_smoke_bomb_01";
		this.m.Value = 400;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = 0;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color] tiles"
		});
		result.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Covers [color=" + ::Const.UI.Color.DamageValue + "]7[/color] tiles in smoke for one round, allowing anyone inside to move freely and ignore zones of control"
		});
		if (this.m.Ammo <= 0.0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Needs to be restocked by an alchemist[/color]"
			});
		}
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/move_pot_clay_01.wav", ::Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_smoke_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

});

