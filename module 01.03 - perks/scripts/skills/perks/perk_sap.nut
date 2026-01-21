
this.perk_sap <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.sap";
		this.m.Name = ::Const.Strings.PerkName.Sap;
		this.m.Description = ::Const.Strings.PerkDescription.Sap;
		this.m.Icon = "ui/perks/sap.png";
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