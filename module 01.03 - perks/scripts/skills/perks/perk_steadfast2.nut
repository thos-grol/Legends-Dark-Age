
this.perk_steadfast2 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.steadfast2";
		this.m.Name = ::Const.Strings.PerkName.Steadfast2;
		this.m.Description = ::Const.Strings.PerkDescription.Steadfast2;
		this.m.Icon = "ui/perks/passive_03.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		// hit and miss fatiuge reduction
		_properties.FatigueReceivedPerHitMult = 0.0;
		_properties.IsAffectedByStaminaHitDamage = false;

		// mental resilience
		_properties.IsAffectedByApproachingEnemies = false;
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
	}
});