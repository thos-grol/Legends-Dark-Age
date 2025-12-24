
this.perk_true_strike <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.true_strike";
		this.m.Name = ::Const.Strings.PerkName.TrueStrike;
		this.m.Description = ::Const.Strings.PerkDescription.TrueStrike;
		this.m.Icon = "ui/perks/true_strike.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Strike_Attack = true;
		_properties.MeleeSkill += 10;
	}
});