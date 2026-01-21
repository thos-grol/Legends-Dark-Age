
this.perk_fleche <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.fleche";
		this.m.Name = ::Const.Strings.PerkName.Fleche;
		this.m.Description = ::Const.Strings.PerkDescription.Fleche;
		this.m.Icon = "ui/perks/fleche.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Fleche))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Fleche);
		}
	}
 
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Fleche);
	}
});