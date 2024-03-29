::Const.Strings.PerkName.ShieldExpert = "Shield Expert";
::Const.Strings.PerkDescription.ShieldExpert = "Become proficient in shields"
+"\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 33%") + " skill fatigue (Shields)"
+ "\n"+::MSU.Text.colorGreen("– 10%") + " damage taken while using a shield"
+ "\n " + ::MSU.Text.colorGreen("– 50%") + " shield damage recieved to a minimum of 1"

+"\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On turn end:")
+ "\nThis unit shieldwalls or fortifies if it hasn't already. Has 4 charges."
+ "\n " + ::MSU.Text.colorRed("Charges only decrement with enemy in ZOC.")

+"\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Modifies Knock Back:")
+ "\n " + ::MSU.Text.colorGreen("+25%") + " chance to hit for Knockback";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ShieldExpert].Name = ::Const.Strings.PerkName.ShieldExpert;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ShieldExpert].Tooltip = ::Const.Strings.PerkDescription.ShieldExpert;

this.perk_shield_expert <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4,
		Skills = [
			"actives.legend_fortify_skill",
			"actives.shieldwall"
		]
	},
	function create()
	{
		this.m.ID = "perk.shield_expert";
		this.m.Name = ::Const.Strings.PerkName.ShieldExpert;
		this.m.Description = ::Const.Strings.PerkDescription.ShieldExpert;
		this.m.Icon = "ui/perks/perk_05.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInShields = true;

		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield))
		{
			_properties.DamageReceivedRegularMult *= 0.9;
		}
	}

	function onCombatStarted()
	{
		this.m.TurnsLeft = 4;
	}

	function onCombatFinished()
	{
		this.m.TurnsLeft = 0;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();

		if (this.m.TurnsLeft > 0 && actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) != null && actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand).isItemType(::Const.Items.ItemType.Shield))
		{
			local skills = this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this));
			if (skills.len() == 0) return;
			foreach (s in skills)
			{
				if (s == null) continue;
				if (s.m.ID == "actives.legend_fortify_skill" && !this.m.Container.hasSkill("effects.legend_fortify"))
				{
					this.m.Container.add(::new("scripts/skills/effects/legend_fortify_effect"));
					if (!actor.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " uses Fortify");
					}
					break;
				}

				if (s.m.ID == "actives.shieldwall" && !this.m.Container.hasSkill("effects.shieldwall"))
				{
					this.m.Container.add(::new("scripts/skills/effects/shieldwall_effect"));
					if (!actor.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " uses Shieldwall");
					}
					break;
				}
			}

			if (actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions())) this.m.TurnsLeft--;
		}

	}

});

