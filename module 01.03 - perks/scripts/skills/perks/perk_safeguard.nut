
this.perk_safeguard <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
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

	//TODO: All shields provide this ability, but it is hidden and disabled unless if you have this perk.
	//TODO: you need to hook the safeguard active and make it functional
	//TODO: make shield wall turn ending, also do the ablative thing

	// function onAdded()
	// {
	// 	if (!::Legends.Actives.has(this, ::Legends.Active.LegendSafeguard))
	// 	{
	// 		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	// 	}
	// }

	// function onRemoved()
	// {
	// 	::Legends.Actives.remove(this, ::Legends.Active.LegendSafeguard);
	// }

	
});