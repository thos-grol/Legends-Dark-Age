
this.perk_uncanny_dodge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.uncanny_dodge";
		this.m.Name = ::Const.Strings.PerkName.UncannyDodge;
		this.m.Description = ::Const.Strings.PerkDescription.UncannyDodge;
		this.m.Icon = "ui/perks/uncanny_dodge.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});