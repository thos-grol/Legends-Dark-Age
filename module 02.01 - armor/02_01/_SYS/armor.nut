// this hooks the armor class
// - implements hardness stat
// - display hardness
::m.rawHook("scripts/items/legend_armor/legend_armor", function(p) {

	// - implement hardness stat
	p.m.Hardness <- 0;
	p.get_hardness <- function() { return this.m.Hardness; }

	// hook onUpdateProperties to change how armor stats function
	p.onUpdateProperties = function( _properties )
	{
		if (this.getContainer() == null) return;
		if (this.getContainer().getActor() == null) return;

		// hk
		// - implement vanguard passive armor reduction
		// - implement hardness stat
		
		local stamina_modifier = ::Math.ceil(this.getStaminaModifier());
		//FEATURE_1: create new vanguard trait passive. make it flat reduction
		//FEATURE_1: vanguard passive, copy over underdog logic
		// if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Brawny))
		// {
		//  stamina_modifier = ::Math.min(0, stamina_modifier + 1); 
		// }
		_properties.Stamina += stamina_modifier;

		_properties.Armor[::Const.BodyPart.Body] += this.getArmor();
		_properties.ArmorMax[::Const.BodyPart.Body] += this.getArmorMax();
		
		_properties.Hardness += this.get_hardness();
		//hk end

		this.doOnFunction("onUpdateProperties", [_properties]);
	}

	p.getTooltip = function()
	{
		local description = this.getDescription();

		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				description += " " + u.getArmorDescription();
			}
		}

		local result = [
			{
				id = 1,
				type = "title",
				text = this.makeName()
			},
			{
				id = 2,
				type = "description",
				text = description
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		result.push({
			id = 3,
			type = "image",
			image = this.m.IconLarge != "" ? this.m.IconLarge : this.m.Icon,
			isLarge = this.m.IconLarge != "" ? true : false
		});


		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				if (u.getIconLarge() != null)
				{
					result.push({
						id = 3,
						type = "image",
						image = u.getIconLarge(),
						isLarge = true
					});
				}
				else
				{
					result.push({
						id = 3,
						type = "image",
						image = u.getIcon()
					});
				}
			}
		}

		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_body.png",
			value = ::Math.floor(this.getArmor()),
			valueMax = ::Math.floor(this.getArmorMax()),
			text = "" + ::Math.floor(this.getArmor()) + " / " + ::Math.floor(this.getArmorMax()) + "",
			style = "armor-body-slim"
		});

		//hk
		// - display hardness
		if (this.get_hardness() > 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/melee_defense_named.png",
				text = "Hardness: " + ::green(this.get_hardness())
			});
		}
		//hk end

		if (this.getStaminaModifier() != 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weight: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + ::Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
			});
		}

		if (this.getStaminaModifier() < 0 && ::Legends.Mod.ModSettings.getSetting("ShowArmorPerFatigueValue").getValue() )
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = format("(%.1f Armor per 1 Weight)", this.getArmorMax() / (1.0 * ::Math.abs(this.getStaminaModifier())))
			});
		}

		local upgradeNum = this.m.Upgrades.filter(@(idx, val) val != null).len();
		if ( upgradeNum > 0 && ::Legends.Mod.ModSettings.getSetting("ShowExpandedArmorLayerTooltip").getValue() )
		{
			result.push({	// An empty line is put in to improve formatting
				id = 10,
				type = "text",
				icon = "ui/icons/blank.png",
				text = " "
			});
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[u]" + this.getName() + "[/u]"
			});
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Armor: " + this.m.ConditionMax
			});
			if ( this.m.StaminaModifier != 0 )
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weight: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.m.StaminaModifier) + ::Math.abs(this.m.StaminaModifier), this.m.StaminaModifier)
				});
			}
		}

		this.doOnFunction("getArmorTooltip", [result]);

		if (this.isRuned())
		{
			result.push({	// An empty line is put in to improve formatting
				id = 20,
				type = "text",
				icon = "ui/icons/blank.png",
				text = " "
			});
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		if (upgradeNum > 0){
			result.push({
				id = 65,
				type = "hint",
				icon = "ui/icons/mouse_right_button_shift.png",
				text = "Shift + Right-click to remove all layers."
			});
		}

		return result;
	}

	
});