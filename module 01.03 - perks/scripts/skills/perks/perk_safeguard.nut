
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

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Safeguard))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Safeguard);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Safeguard);
	}
});