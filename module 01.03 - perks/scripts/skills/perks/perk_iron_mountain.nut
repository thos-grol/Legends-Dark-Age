
this.perk_iron_mountain <- this.inherit("scripts/skills/skill", {
	m = {
		HARDNESS = 2,
		ACTIVE = false
	},
	function create()
	{
		this.m.ID = "perk.iron_mountain";
		this.m.Name = ::Const.Strings.PerkName.IronMountain;
		this.m.Description = ::Const.Strings.PerkDescription.IronMountain;
		this.m.Icon = "ui/perks/iron_mountain.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.m.ACTIVE = true;
	}

	function onTurnEnd()
	{
		this.m.ACTIVE = false;
	}

	function onUpdate( _properties )
	{
		//TODO: how damage works. Damage is rounded down after processing, BUT if damage > 0 and < 1. Then it becomes 1.
		//TODO: add this property to damage calc
		if (this.m.ACTIVE) _properties.Hardness += this.m.HARDNESS;
	}
});