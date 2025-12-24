
this.perk_vanguard <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.vanguard";
		this.m.Name = ::Const.Strings.PerkName.Vanguard;
		this.m.Description = ::Const.Strings.PerkDescription.Vanguard;
		this.m.Icon = "ui/perks/vanguard.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToSurrounding = true;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LineBreaker))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LineBreaker);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LineBreaker);
	}
});