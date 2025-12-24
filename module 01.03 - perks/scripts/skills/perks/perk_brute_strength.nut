
this.perk_brute_strength <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 5
	},
	function create()
	{
		this.m.ID = "perk.brute_strength";
		this.m.Name = ::Const.Strings.PerkName.BruteStrength;
		this.m.Description = ::Const.Strings.PerkDescription.BruteStrength;
		this.m.Icon = "ui/perks/brute_strength.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.SkillType != SKILL_TYPE.PHYSICAL) return;

		local actor = this.getContainer().getActor();
		local level = actor.getFlags().getAsInt("Level Updated To");
		local mult = 1;
		if (level >= 3) mult++;
		if (level >= 5) mult += 2;

		_properties.DamageRegularMin += this.m.BUFF * mult;
		_properties.DamageRegularMax += this.m.BUFF * mult;
	}
});