::ModJimmysTooltips.modTacticalTooltip <- function( tooltip, _targetedWithSkill, _entity )
{
	if(::ModJimmysTooltips.Mod.ModSettings.getSetting("DefaultTooltip").getValue()) {
		return tooltip;
	}

	if (tooltip.len() < 3) {
		return tooltip;
	}

	local shownPerks = {};
	local stackEffects = function ( effects )
	{
		local stacks = {};

		foreach( _, effect in effects )
		{
			local name = effect.getName();

			if (name in stacks)
			{
				stacks[name] += 1;
			}
			else
			{
				stacks[name] <- 1;
			}
		}

		return stacks;
	};
	local pushSectionName = function ( items, title, startID, icon = "")
	{
		if (items.len() && title)
		{
			local ret = {
				id = startID,
				type = "text",
				text = "[u][size=14]" + title + "[/size][/u]"
			};

			if (icon.len() > 0)
				ret.icon <- icon;

			tooltip.push(ret);
		}
	};
	local isPerk = @( _, _skill ) _skill.isType(::Const.SkillType.Perk);
	local isInjury = @( _, _skill ) _skill.isType(::Const.SkillType.TemporaryInjury);
	local isTextRow = @( _, row ) ("type" in row) && row.type == "text";

	local pushSection = function ( items, title, startID,filter = 0, prependIcon = "", stackInOneLine = false)
	{
		if (!items)
		{
			return;
		}

		if (filter == 1)
		{
			items = items.filter(isPerk);
		}
		else if (filter == 2)
		{
			items = items.filter(function ( i, item )
			{
				return !isPerk(i, item);
			});
		}

		local stacks = {};

		if (stackInOneLine)
		{
			stacks = stackEffects(items);
			local newItems = [];
			local added = {};

			foreach( i, item in items )
			{
				local name = item.getName();

				if (!(name in added))
				{
					newItems.push(item);
					added[name] <- 1;
				}
			}

			items = newItems;
		}

		pushSectionName(items, title, startID);
		startID = startID + 1;

		foreach( i, item in items )
		{
			local name = item.getName();
			local text = name;

			// debug for if there is a null entry so that the tt wont crash
			if(name == null && text == null){
				// ::logInfo("weird NULL issue for perk tooltips");
				::logWarning("There is a somthing with a null name: ");
				local id = item.getID();
				local desc = item.getDescription();
				local type = item.getType();
				::logInfo("id of the thing: " + id);
				::logInfo("description of the thing: " + desc);
				::logInfo("type of the thing: " + type);
				continue;
			}

			if (filter != 0)
			{
				shownPerks[name] <- 1;
			}

			if (stackInOneLine && stacks[name] > 1)
			{
				text = text + (" [color=" + ::Const.UI.Color.NegativeValue + "]" + "x" + stacks[name] + "[/color]");
			}

			if(title == "Ammo" && this.isKindOf(_entity, "player")){
				tooltip.push({
					id = startID + i,
					type = "text",
					icon = checkForIcon(prependIcon, item),
					text = text + " Ammo: " + item.getAmmo() + " / " + item.getAmmoMax()
				});
			} else if (title == "Ammo" && !this.isKindOf(_entity, "player"))
			{
				tooltip.push({
					id = startID + i,
					type = "text",
					icon = checkForIcon(prependIcon, item),
					text = text + " " + "Ammo: infinite"
				});
			}
			else{
				tooltip.push({
					id = startID + i,
					type = "text",
					icon = checkForIcon(prependIcon, item),
					text = text
				});
			}
		}
	};
	local removeDuplicates = function ( items )
	{
		if (!items)
		{
			return items;
		}

		return items.filter(function ( i, item )
		{
			return !(item.getName() in shownPerks);
		});
	};
	local getPlural = function ( items )
	{
		if (!items)
		{
			return "";
		}

		return items.len() > 1 ? "s" : "";
	};
	local patchedPerkIcons = {};
	patchedPerkIcons[::Const.Strings.PerkName.BatteringRam] <- "ui/settlement_status/settlement_effect_13.png";
	local getRealPerkIcon = function ( perk )
	{
		local realPerk = ::Const.Perks.findById(perk.getID());

		if (realPerk)
		{
			return realPerk.Icon;
		}

		local name = perk.getName();

		if (name in patchedPerkIcons)
		{
			return patchedPerkIcons[name];
		}

		return perk.getIcon();
	};

	if(true){

		if (!this.isKindOf(_entity, "player"))
		{
			local _type = "progressbar";

			foreach( i, row in tooltip )
			{
				if (("type" in row) && row.type == _type && ("id" in row) && "icon" in row)
				{
					if (row.id == 5 && row.icon == "ui/icons/armor_head.png")
					{
						row.text <- "" + _entity.getArmor(::Const.BodyPart.Head) + " / " + _entity.getArmorMax(::Const.BodyPart.Head) + "";
					}
					else if (row.id == 6 && row.icon == "ui/icons/armor_body.png")
					{
						row.text <- "" + _entity.getArmor(::Const.BodyPart.Body) + " / " + _entity.getArmorMax(::Const.BodyPart.Body) + "";
					}
					else if (row.id == 7 && row.icon == "ui/icons/health.png")
					{
						row.text <- "" + _entity.getHitpoints() + " / " + _entity.getHitpointsMax() + "";
					}
					else if (row.id == 9 && row.icon == "ui/icons/fatigue.png")
					{
						row.text <- "" + _entity.getFatigue() + " / " + _entity.getFatigueMax() + "";
					}
				}
			}
		}

		foreach( i, row in tooltip )
		{
			if (("type" in row) && row.type == "progressbar" && ("id" in row) && "icon" in row)
			{
				if (row.id == 8 && row.icon == "ui/icons/morale.png")
				{
					tooltip.remove(i);
					break;
				}
			}
		}
	}

	local pushRemainingAP = function ()
	{
		local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(_entity.getID());
		local remainingAP = _entity.m.IsTurnDone || turnsToGo == null ? 0 : _entity.getActionPoints();
		tooltip.push({
			id = 10,
			type = "progressbar",
			icon = "ui/icons/action_points.png",
			value = remainingAP,
			valueMax = _entity.getActionPointsMax(),
			text = "" + _entity.getActionPoints() + " / " + _entity.getActionPointsMax() + "",
			style = "action-points-slim"
		});
	};

	/*
	if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
	{
		local tile = this.getTile();

		if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
		{
			tooltip.push({
				id = 2048,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Expand tooltip"
			});
			return tooltip;
		}
	}
	*/

	local traits = _entity.getSkills().query(::Const.SkillType.Trait | ::Const.SkillType.Racial, false, true);
	traits = traits.filter(function ( _, item )
	{
		if (item.m.ID == "special.mood_check") return false;
		return true;
	});
	pushSection(traits, null, 1000, 0, "", false);
	//pushSection( items, title, startID,filter = 0, prependIcon = "", stackInOneLine = false)

	if (!::Tactical.Entities.getFlags().get("ModJimmysTooltips_ShowLootChance"))
	{
		local statusEffects = _entity.getSkills().query(::Const.SkillType.StatusEffect | ::Const.SkillType.TemporaryInjury, false, true);
		local count = tooltip.len() - statusEffects.len();

		
		

		if (statusEffects.len() && count > 0)
		{
			if (tooltip[count].text == statusEffects[0].getName())
			{
				tooltip.resize(count);
				// pushRemainingAP();
				statusEffects = statusEffects.filter(function ( _, item )
				{
					return !isInjury(_, item);
				});
				statusEffects = removeDuplicates(statusEffects);
				pushSection(statusEffects, null, 100, 2, "", true);
				local injuries = _entity.getSkills().query(::Const.SkillType.TemporaryInjury, false, true);

				foreach( i, injury in injuries )
				{
					local children = injury.getTooltip().filter(function ( _, row )
					{
						return isTextRow(_, row);
					});
					local addedTooltipHints = [];
					injury.addTooltipHint(addedTooltipHints);
					addedTooltipHints = addedTooltipHints.filter(function ( _, row )
					{
						return isTextRow(_, row);
					});
					local added_count = addedTooltipHints.len();

					if (added_count)
					{
						children.resize(children.len() - added_count);
					}

					local isUnderIronWill = function ()
					{
						local pattern = this.regexp("Iron Will");

						foreach( _, row in addedTooltipHints )
						{
							if (("text" in row) && pattern.search(row.text))
							{
								return true;
							}
						}

						return false;
					}();
					local injuryRow = {
						id = 133 + i,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName()
					};

					if (!isUnderIronWill)
					{
						injuryRow.children <- children;
					}
					else
					{
						injuryRow.text += "[color=" + ::Const.UI.Color.PositiveValue + "]" + " (Iron Will)[/color]";
					}

					tooltip.push(injuryRow);
				}

				statusEffects = removeDuplicates(statusEffects);
				pushSection(statusEffects, "Status perks", 150, 1);
			}
			else
			{
				foreach( _, row in tooltip )
				{
					if (("type" in row) && row.type == "text" && "text" in row)
					{
						shownPerks[row.text] <- 1;
					}
				}
			}
		}
		else if (!statusEffects.len())
		{
			// pushRemainingAP();
		}

		local activePerks = _entity.getSkills().query(::Const.SkillType.Active, false, true);
		activePerks = removeDuplicates(activePerks);
		pushSection(activePerks, "Usable perks", 200, 1);
		local thresholdToCompact = 0;
		local perks = _entity.getSkills().query(::Const.SkillType.Perk, false, true);
		perks = removeDuplicates(perks);
		pushSectionName(perks, "Perks", 300);

		if (perks.len() < thresholdToCompact)
		{
			foreach( i, perk in perks )
			{
				tooltip.push({
					id = 301 + i,
					type = "text",
					icon = getRealPerkIcon(perk),
					text = perk.getName()
				});
			}
		}
		else
		{
			local texts = "";

			foreach( _, perk in perks )
			{
				local name = perk.getName();

				if (name && name.len() > 1)
				{
					texts = texts + ("[color=" + ::Const.UI.Color.NegativeValue + "]" + name.slice(0, 1) + "[/color]" + name.slice(1) + ", ");
				}
			}

			if (texts.len() > 2)
			{
				texts = texts.slice(0, -2);
			}

			tooltip.push({
				id = 301,
				type = "text",
				icon = "ui/icons/perks.png",
				text = texts
			});
		}

		local mainhand = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if(::ModJimmysTooltips.Mod.ModSettings.getSetting("Items").getValue()){
			if(mainhand != null){
				local name = mainhand.getName();
				//::logInfo(name);
				pushSectionName(mainhand, "Equipped Items:", 400);
				if(mainhand.isItemType(::Const.Items.ItemType.Ammo)){
					tooltip.push({
						id = 401,
						type = "text",
						icon = checkForIcon("ui/items/", mainhand),
						text = name + " " + mainhand.getAmmo() + " / " + mainhand.getAmmoMax()
					});
				}
				else{
					tooltip.push({
						id = 401,
						type = "text",
						icon = checkForIcon("ui/items/", mainhand),
						text = name + " " + mainhand.getCondition() + " / " + mainhand.getConditionMax()
					});
				}
			}

			local offhand = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			if(offhand != null){
				local name = offhand.getName();
				// ::logInfo(name);
				if(offhand.isItemType(::Const.Items.ItemType.Ammo)){
					tooltip.push({
						id = 421,
						type = "text",
						icon = checkForIcon("ui/items/", offhand),
						text = name + " " + offhand.getAmmo() + " / " + offhand.getAmmoMax()
					});
				}
				else{
					tooltip.push({
						id = 421,
						type = "text",
						icon = checkForIcon("ui/items/", offhand),
						text = name + " " + offhand.getCondition() + " / " + offhand.getConditionMax()
					});
				}
			}

			local items = _entity.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
			foreach (item in items){
				local name = item.getName();
				// ::logInfo(name);
				pushSectionName(item, "Bags", 430);
				if(item.isItemType(::Const.Items.ItemType.Ammo)){
					tooltip.push({
						id = 431,
						type = "text",
						icon = checkForIcon("ui/items/", item),
						text = name + " " + item.getAmmo() + " / " + item.getAmmoMax()
					});
				}
				else{
					tooltip.push({
						id = 431,
						type = "text",
						icon = checkForIcon("ui/items/", item),
						text = name + " " + item.getCondition() + " / " + item.getConditionMax()
					});
				}
			}
		}

		local accessories = _entity.getItems().getAllItemsAtSlot(::Const.ItemSlot.Accessory);
		pushSection(accessories, "Accessory", 600, 0, "ui/items/");

		local ammos = _entity.getItems().getAllItemsAtSlot(::Const.ItemSlot.Ammo);
		pushSection(ammos, "Ammo", 700, 0, "ui/items/");

		if(_targetedWithSkill == null && ::ModJimmysTooltips.Mod.ModSettings.getSetting("Skills").getValue() && mainhand != null){
			local skills = mainhand.getSkills();
			local startID = 500;
			foreach (skill in skills){
				local skillID = skill.getID(); // todo it shows it in log, remove when problem with tooltips is gone - chopeks
				if (skill.getContainer() == null || !("getActor" in skill.getContainer()) || skill.getContainer().getActor() == null)
					continue;
				if(skill.isUsable()){
					pushSectionName(skill, skill.getName(), startID, "" + skill.getIcon());
					tooltip.extend(skill.noDescriptionDefaultTooltip(startID));
					startID = startID + 10;
				}
			}
		}

		local itemsOnGround = _entity.getTile().Items;
		pushSection(itemsOnGround, "Item" + getPlural(itemsOnGround) + " on ground", 700, 0, "ui/items/", true);
	}
	else
	{
		pushSectionName("ModJimmysTooltips_ShowLootChance", "Chance to loot equipment:", 700);
		tooltip.top().type = "hint"; // move this to hint to separate as sections
		tooltip.extend(::ModJimmysTooltips.modGetEquipmentLootChance(_entity, _targetedWithSkill, 700));
	}

	if(true){
		local properties = _entity.getCurrentProperties();
		tooltip.push({
			id = 600,
			type = "hint",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]"+properties.getMeleeSkill()+"[/color] Attack"
		});
		tooltip.push({
			id = 601,
			type = "hint",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]"+properties.getMeleeDefense()+"[/color] Defense"
		});
		tooltip.push({
			id = 602,
			type = "hint",
			icon = "ui/icons/strength.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]"+properties.getRangedSkill()+"[/color] Strength"
		});
		tooltip.push({
			id = 603,
			type = "hint",
			icon = "ui/icons/reflex.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]"+properties.getRangedDefense()+"[/color] Instinct"
		});
		tooltip.push({
			id = 604,
			type = "hint",
			icon = "ui/icons/initiative.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]"+_entity.getInitiative()+"[/color] Agility"
		});
		tooltip.push({
			id = 605,
			type = "hint",
			icon = "ui/icons/bravery.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]"+_entity.getBravery()+"[/color] Mettle"
			divider = "bottom" // add a diviver
		});
	}

	if (!::Tactical.Entities.getFlags().get("ModJimmysTooltips_ShowLootChance"))
		tooltip.push({
			id = 606,
			type = "hint",
			icon = "ui/skin/icon_wait.png",
			text = "Press \""
			+ ::MSU.System.Keybinds.KeybindsByMod[::ModJimmysTooltips.ID].rawget("updateTooltip").getKeyCombinations()
			+ "\" key to show the chance to loot equipment"
		});
	else
		tooltip.push({
			id = 606,
			type = "hint",
			icon = "ui/skin/icon_wait.png",
			text = "Press \""
			+ ::MSU.System.Keybinds.KeybindsByMod[::ModJimmysTooltips.ID].rawget("updateTooltip").getKeyCombinations()
			+ "\" key to show the default tooltip"
		});

	return tooltip;
};