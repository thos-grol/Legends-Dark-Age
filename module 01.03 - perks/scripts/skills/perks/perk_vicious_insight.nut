
this.perk_vicious_insight <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.vicious_insight";
		this.m.Name = ::Const.Strings.PerkName.ViciousInsight;
		this.m.Description = ::Const.Strings.PerkDescription.ViciousInsight;
		this.m.Icon = "ui/perks/vicious_insight.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		
		_properties.DamageRegularMin += this.m.BUFF;
		_properties.DamageRegularMax += this.m.BUFF;
	}
 
	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 2.0;
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