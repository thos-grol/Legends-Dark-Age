// this hooks the weapon class
// - remove unused stats from the tooltip
// - remove weapon deterioration
::m.rawHook("scripts/items/weapons/weapon", function(p) {

	// - remove weapon deterioration
	p.onUse = function(_skill) {}
	p.lowerCondition = function(_value = 0) {}
	
	// - disable shield damage
	p.getShieldDamage = function () { return 0; }

	// - remove condition from the tooltip
	p.getTooltip = function() {
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
			id = 65,
			type = "text",
			text = this.m.Categories
		});
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		// hk
		// - remove condition from the tooltip, we don't use it
		// if (this.m.ConditionMax > 1)
		// {
		// 	result.push({
		// 		id = 4,
		// 		type = "progressbar",
		// 		icon = "ui/icons/asset_supplies.png",
		// 		value = this.getCondition(),
		// 		valueMax = this.getConditionMax(),
		// 		text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
		// 		style = "armor-body-slim"
		// 	});
		// }
		// hk end

		if (this.m.RegularDamage > 0)
		{
			result.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::damagered(this.m.RegularDamage) + " - " + ::damagered(this.m.RegularDamageMax) + " damage"
			});
		}

		// hk
		// - remove DirectDamageMult from the tooltip, we don't use it
		// if (this.m.DirectDamageMult > 0)
		// {
		// 	result.push({
		// 		id = 64,
		// 		type = "text",
		// 		icon = "ui/icons/direct_damage.png",
		// 		text = "[color=" + ::Const.UI.Color.DamageValue + "]" + ::Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor"
		// 	});
		// }
		//hk end

		// hk
		// - remove ArmorDamageMult from the tooltip, we don't use it
		// if (this.m.ArmorDamageMult > 0)
		// {
		// 	result.push({
		// 		id = 5,
		// 		type = "text",
		// 		icon = "ui/icons/armor_damage.png",
		// 		text = "[color=" + ::Const.UI.Color.DamageValue + "]" + ::Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor"
		// 	});
		// }
		//hk end

		// hk
		// shields have been reworked, we don't do shield damage anymore
		// if (this.m.ShieldDamage > 0)
		// {
		// 	result.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/shield_damage.png",
		// 		text = "Shield damage of [color=" + ::Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color]"
		// 	});
		// }
		// hk end

		if (this.m.ChanceToHitHead > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Chance to hit head [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color]"
			});
		}

		if (this.m.AdditionalAccuracy > 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}
		else if (this.m.AdditionalAccuracy < 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}

		if (this.m.RangeMax > 1)
		{
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Range of [color=" + ::Const.UI.Color.PositiveValue + "]" + this.getRangeMax() + "[/color] tiles"
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.FatigueOnSkillUse > 0 && (this.getContainer() == null || !this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons))
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue"
			});
		}
		else if (this.m.FatigueOnSkillUse < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue"
			});
		}

		if (this.m.AmmoMax > 0)
		{
			if (this.m.Ammo != 0)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/ammo.png",
					text = "Contains ammo for [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
				});
			}
			else
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + ::Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
				});
			}
		}

		return result;
	}
});