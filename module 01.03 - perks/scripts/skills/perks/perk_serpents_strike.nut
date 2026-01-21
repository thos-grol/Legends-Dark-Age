
this.perk_serpents_strike <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.serpents_strike";
		this.m.Name = ::Const.Strings.PerkName.SerpentsStrike;
		this.m.Description = ::Const.Strings.PerkDescription.SerpentsStrike;
		this.m.Icon = "ui/perks/serpents_strike.png";
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