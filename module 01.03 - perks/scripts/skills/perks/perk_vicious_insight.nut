
this.perk_vicious_insight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.vicious_insight";
		this.m.Name = ::Const.Strings.PerkName.ViciousInsight;
		this.m.Description = ::Const.Strings.PerkDescription.ViciousInsight;
		this.m.Icon = "ui/perks/vicious_insight.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});