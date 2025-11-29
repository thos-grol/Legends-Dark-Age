::mods_hookExactClass("skills/effects/shieldwall_effect", function(o)
{
    o.create <- function()
	{
		this.m.ID = "effects.shieldwall";
		this.m.Name = "Shieldwall";
		this.m.Description = "Having raised the shield to a protective stance, gaining Armor Points until next turn start.";
		this.m.Icon = "skills/status_effect_03.png";
		this.m.IconMini = "status_effect_03_mini";
		this.m.Overlay = "status_effect_03";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
        this.m.IsHidden = true;
	}

    o.onUpdate <- function( _properties ) { }
    o.onBeingAttacked <- function ( _attacker, _skill, _properties ) { }

    o.onAfterUpdate <- function( _properties )
	{
        if (!("State" in this.Tactical) || this.Tactical.State == null) return;

        local actor = this.getContainer().getActor();
        local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (!item.isItemType(::Const.Items.ItemType.Shield)) return;
		
        local bonus = item.m.ShieldwallAP;
        if (actor.getCurrentProperties().BlockMastery) bonus *= 2;

        _properties.Armor[::Const.BodyPart.Body] += bonus;
        _properties.Armor[::Const.BodyPart.Head] += bonus;
        _properties.ArmorMax[::Const.BodyPart.Body] += bonus;
        _properties.ArmorMax[::Const.BodyPart.Head] += bonus;

		// TODO: prob be best handled as extra armor added by skill,
		// then in damage calc subtract this first?
		// 		"calc item armor dmg" section subtract outgoing damage from there from skill armor
	}

    o.onTurnStart <- function()
	{
		this.removeSelf();
	}
});