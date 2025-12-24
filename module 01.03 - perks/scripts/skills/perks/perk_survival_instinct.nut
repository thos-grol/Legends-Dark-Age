
this.perk_survival_instinct <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.survival_instinct";
		this.m.Name = ::Const.Strings.PerkName.SurvivalInstinct;
		this.m.Description = ::Const.Strings.PerkDescription.SurvivalInstinct;
		this.m.Icon = "ui/perks/survival_instinct.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 5;
		local pct = this.getContainer().getActor().getHitpointsPct();
		if (pct <= 0.33) _properties.MeleeDefense += 20;
		else if (pct <= 0.66) _properties.MeleeDefense += 10;
	}
});