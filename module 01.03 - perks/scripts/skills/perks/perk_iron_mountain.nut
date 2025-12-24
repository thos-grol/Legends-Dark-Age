
this.perk_iron_mountain <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 10,
		enabled = false
	},
	function create()
	{
		this.m.ID = "perk.iron_mountain";
		this.m.Name = ::Const.Strings.PerkName.IronMountain;
		this.m.Description = ::Const.Strings.PerkDescription.IronMountain;
		this.m.Icon = "ui/perks/iron_mountain.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.Overlay = "iron_mountain";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		this.m.enabled = false;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.m.enabled = true;
		
		// spawn overlay effect
		local _c = this.getContainer();
		if (_c != null && _c.getActor().isPlacedOnMap() && this.m.Overlay != "")
		{
			this.spawnIcon(this.m.Overlay, _c.getActor().getTile());
		}
	}

	function onUpdate( _properties )
	{
		if (!this.m.enabled) return;
		_properties.Hardness += this.m.BUFF;
	}
});