::Const.Strings.PerkName.LegendAdaptive <- "Adaptive";
::Const.Strings.PerkDescription.LegendAdaptive <- "Inspire those around you..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+1") + " perk point"
+ "\n"+::MSU.Text.colorRed("Pick Order:")
+ "\n"+::MSU.Text.colorRed("Gain a shield tree based on the equipped shield")
+ "\n"+::MSU.Text.colorRed("Gain a weapon tree based on the equipped weapon")
+ "\n"+::MSU.Text.colorRed("Gain an armor tree based on the weight class");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAdaptive].Name = ::Const.Strings.PerkName.LegendAdaptive;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAdaptive].Tooltip = ::Const.Strings.PerkDescription.LegendAdaptive;

this.perk_legend_adaptive <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_adaptive";
		this.m.Name = ::Const.Strings.PerkName.LegendAdaptive;
		this.m.Description = ::Const.Strings.PerkDescription.LegendAdaptive;
		this.m.Icon = "ui/perks/adaptive_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.NoRefundPerk <- true;
	}

	function onAdded()
	{
		if (!this.m.IsNew || this.m.IsForPerkTooltip) return;
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;
		this.m.IsNew = false;
		actor.m.PerkPointsSpent -= 1;
		actor.m.PerkPoints += 1;

		local possibleTrees = this.getPossibleTrees();
		this.chooseAndAddTree(possibleTrees);
	}

	function getUnactivatedPerkTooltipHints()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/tooltips/negative.png",
				text = "No new tree can be unlocked now"
			}
		];

		try
		{
			local possibleTrees = this.getPossibleTrees();
			local descText = "";
			local possibleTreesText = "";

			if (typeof possibleTrees != "array" || possibleTrees.len() > 0)
			{
				local name = typeof possibleTrees != "array" ? possibleTrees.Name : possibleTrees[0].Name;
				descText = "Activating this Perk will grant the following Perk Group:\n";
				possibleTreesText = "[color=#0b0084]" + name + "[/color]";
			}

			if (possibleTreesText != "")
				ret = [
					{
						id = 3,
						type = "hint",
						icon = "ui/tooltips/positive.png",
						text = descText + possibleTreesText
					}
				];
		} catch(exception) {}

		return ret;
	}

	function getPossibleTrees()
	{
		local item;
		local itemtype;
		local newTree;
		local actor = this.getContainer().getActor();

		if (actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) != null)
		{
			item = actor.getMainhandItem();

			if (item.isItemType(this.Const.Items.ItemType.Shield))
			{
				newTree = this.Const.Perks.ShieldTree;
			}

			newTree = this.getOnlyNonExistingTrees(newTree);

			if (newTree != null && newTree.len() > 0)
			{
				return newTree;
			}
		}

		if (actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null)
		{
			item = actor.getMainhandItem();

			if (item.isItemType(::Const.Items.ItemType.Weapon))
			{
				newTree = ::Z.Perks.getWeaponPerkTree(item);
			}

			newTree = this.getOnlyNonExistingTrees(newTree);

			if (newTree != null && newTree.len() > 0)
			{
				return newTree;
			}
		}

		

		local weight = this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
		local armorTree;
		if (weight <= 20) armorTree = this.Const.Perks.LightArmorTree;
        else if (weight <= 40) armorTree = this.Const.Perks.MediumArmorTree;
        else armorTree = this.Const.Perks.HeavyArmorTree;
		armorTree = this.getOnlyNonExistingTrees(armorTree);
		if (armorTree != null && armorTree.len() > 0) return armorTree;
		

		return newTree;
	}

	function getOnlyNonExistingTrees( _newTree )
	{
		if (_newTree == null || typeof _newTree == "array" && _newTree.len() < 1)
		{
			return [];
		}

		local actor = this.getContainer().getActor();

		if (typeof _newTree != "array")
		{
			return actor.getBackground().hasPerkGroup(_newTree) ? null : _newTree;
		}

		local ret = [];

		foreach( tree in _newTree )
		{
			if (!actor.getBackground().hasPerkGroup(tree))
			{
				ret.append(tree);
			}
		}

		return ret;
	}

	function chooseAndAddTree( _newTree )
	{
		local actor = this.getContainer().getActor();

		try {
			if (typeof _newTree != "array")
			{
				actor.getBackground().addPerkGroup(_newTree.Tree);
			}
			else if (_newTree.len() > 0)
			{
				actor.getBackground().addPerkGroup(_newTree[0].Tree);
			}
			else
			{
				this.logWarning("Adaptive Perk had no Tree to add");
				this.removeSelf();
				return;
			}
		} catch(exception) {
			this.removeSelf();
			return;
		}

		actor.getFlags().set("perk_legend_adaptive", true);
	}

});

