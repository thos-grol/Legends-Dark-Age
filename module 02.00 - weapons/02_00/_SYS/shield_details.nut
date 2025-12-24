::mods_hookExactClass("items/shields/shield", function(o) {

    o.get_block_points <- function()
	{
		return 25;
	}
	
	// hk - remove ranged defense increase as we don't use that stat
    o.onUpdateProperties = function ( _properties )
	{
		if (this.m.Condition == 0) return;
		local mult = 1.0;

		// if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		// {
		// 	mult = 1.25;
		// }

		_properties.MeleeDefense += this.Math.floor(this.m.MeleeDefense * mult);
		_properties.Stamina += this.m.StaminaModifier;
	}
    
    o.getTooltip = function()
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
			id = 4,
			type = "progressbar",
			icon = "ui/icons/asset_supplies.png",
			value = this.getCondition(),
			valueMax = this.getConditionMax(),
			text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
			style = "armor-head-slim"
		});

		if (this.m.MeleeDefense > 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Melee Defense [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.MeleeDefense + "[/color]"
			});
		}

		// hk - remove ranged defense
        // if (this.m.RangedDefense > 0)
		// {
		// 	result.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/ranged_defense.png",
		// 		text = "Ranged Defense [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RangedDefense + "[/color]"
		// 	});
		// }

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.FatigueOnSkillUse > 0 && (this.getContainer() == null || !this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons))
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Shield skills build up [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue"
			});
		}
		else if (this.m.FatigueOnSkillUse < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Shield skills build up [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue"
			});
		}

		if (this.m.Condition == 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Broken and unusable[/color]"
			});
		}

		return result;
	}
});
