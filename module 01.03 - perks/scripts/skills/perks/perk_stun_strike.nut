
this.perk_stun_strike <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stun_strike";
		this.m.Name = ::Const.Strings.PerkName.StunStrike;
		this.m.Description = ::Const.Strings.PerkDescription.StunStrike;
		this.m.Icon = "ui/perks/stun_strike.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.StunStrike))
		{
			::Legends.Actives.grant(this, ::Legends.Active.StunStrike);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.StunStrike);
	}
});