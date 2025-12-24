::mods_hookExactClass("skills/effects/shieldwall_effect", function(o)
{
	o.m.Block_Points <- 0;
	local onAdded = o.onAdded;
	o.onAdded = function()
	{
		onAdded();
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item.isItemType(this.Const.Items.ItemType.Shield) && item.getCondition() > 0)
		{
			this.m.Block_Points = item.get_block_points();

			local req = this.getContainer().getSkillByID("perk.block_mastery");
			if (req != null) this.m.Block_Points *= 2;
		}
	}

	o.onBeingAttacked = function ( _attacker, _skill, _properties ) {}
	o.getTooltip = function()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;

		// if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		// {
		// 	mult = mult * 1.25;
		// }

		// if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills)
		// {
		// 	proficiencyBonus = 5;
		// }

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getMeleeDefense() * mult + proficiencyBonus) + "[/color] Melee Defense"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item.isItemType(this.Const.Items.ItemType.Shield) && item.getCondition() > 0)
		{
			local mult = 1.0;
			local proficiencyBonus = 0;

			// if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
			// {
			// 	mult = mult * 1.25;
			// }

			// if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills)
			// {
			// 	proficiencyBonus = 5;
			// }

			_properties.MeleeDefense += this.Math.floor(item.getMeleeDefense() * mult) + proficiencyBonus;
		}
	}

	


});
