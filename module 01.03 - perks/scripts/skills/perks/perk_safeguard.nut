
this.perk_safeguard <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.safeguard";
		this.m.Name = ::Const.Strings.PerkName.Safeguard;
		this.m.Description = ::Const.Strings.PerkDescription.Safeguard;
		this.m.Icon = "ui/perks/safeguard.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});