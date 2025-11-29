
this.perk_steadfast2 <- this.inherit("scripts/skills/skill", {
	m = {
		FatigueReceivedPerHitMult = 0.0
	},
	function create()
	{
		this.m.ID = "perk.steadfast2";
		this.m.Name = ::Const.Strings.PerkName.Steadfast2;
		this.m.Description = ::Const.Strings.PerkDescription.Steadfast2;
		this.m.Icon = "ui/perks/steadfast.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueReceivedPerHitMult = this.m.FatigueReceivedPerHitMult;
		//FEATURE_1: create new property to remove FatigueLossOnBeingMissed
		//FEATURE_1: overhaul fatigue system on hit/miss
		// this.m.Fatigue = ::Math.min(this.getFatigueMax(), ::Math.round(this.m.Fatigue + ::Const.Combat.FatigueLossOnBeingMissed * this.m.CurrentProperties.FatigueEffectMult * this.m.CurrentProperties.FatigueLossOnAnyAttackMult));
	}
});