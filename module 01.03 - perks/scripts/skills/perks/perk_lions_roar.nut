
this.perk_lions_roar <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.lions_roar";
		this.m.Name = ::Const.Strings.PerkName.LionsRoar;
		this.m.Description = ::Const.Strings.PerkDescription.LionsRoar;
		this.m.Icon = "ui/perks/lions_roar.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LionsRoar))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LionsRoar);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LionsRoar);
	}
});