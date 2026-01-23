
this.perk_duelist2 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.duelist2";
		this.m.Name = ::Const.Strings.PerkName.Duelist2;
		this.m.Description = ::Const.Strings.PerkDescription.Duelist2;
		this.m.Icon = "ui/perks/duelist2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});