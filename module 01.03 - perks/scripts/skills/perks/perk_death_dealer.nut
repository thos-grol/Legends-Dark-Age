
this.perk_death_dealer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.death_dealer";
		this.m.Name = ::Const.Strings.PerkName.DeathDealer;
		this.m.Description = ::Const.Strings.PerkDescription.DeathDealer;
		this.m.Icon = "ui/perks/death_dealer.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap()) return;

		local skills = this.getContainer().getSkillsByFunction((@(_skill) _skill.m.IsWeaponSkill && _skill.m.ActionPointCost >= 6).bindenv(this));
		if (skills.len() == 0) return;
		foreach (s in skills)
		{
			if (s != null)
			{
				s.m.ActionPointCost -= 2;
			}
		}
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 10;
	}
});