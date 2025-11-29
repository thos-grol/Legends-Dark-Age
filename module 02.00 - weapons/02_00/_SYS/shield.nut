::mods_hookExactClass("items/shields/shield", function(o) {
	
	// disable shield damage
	o.m.getValue <- function() { return this.m.Value; }
	o.applyShieldDamage = function ( _damage, _playHitSound = true ) { }

	o.onEquip <- function()
	{
		this.item.onEquip();
		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}
		this.updateAppearance();

		// make safeguard skill global but hidden
		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	}

	// remove modifications and just use basic shield properties
	o.onUpdateProperties = function (_properties)
	{
		_properties.MeleeDefense += this.m.MeleeDefense;
		_properties.Stamina += this.m.StaminaModifier;
	}

	// fix tooltip to be relevant
	o.getTooltip <- function()
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
		// result.push({
		// 	id = 4,
		// 	type = "progressbar",
		// 	icon = "ui/icons/asset_supplies.png",
		// 	value = this.getCondition(),
		// 	valueMax = this.getConditionMax(),
		// 	text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
		// 	style = "armor-head-slim"
		// });

		if (this.m.MeleeDefense > 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::green("+" + this.m.MeleeDefense) + " Defense"
			});
		}

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

		// if (this.m.Condition == 0)
		// {
		// 	result.push({
		// 		id = 10,
		// 		type = "text",
		// 		icon = "ui/tooltips/warning.png",
		// 		text = "[color=" + this.Const.UI.Color.NegativeValue + "]Broken and unusable[/color]"
		// 	});
		// }

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
			result.push({
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When scrapped, rune will be refunded"
			});
		}

		return result;
	}
});
