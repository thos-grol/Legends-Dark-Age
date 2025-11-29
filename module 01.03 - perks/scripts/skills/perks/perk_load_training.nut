
this.perk_load_training <- this.inherit("scripts/skills/skill", {
	m = {
		BUFF = 1
	},
	function create()
	{
		this.m.ID = "perk.load_training";
		this.m.Name = ::Const.Strings.PerkName.LoadTraining;
		this.m.Description = ::Const.Strings.PerkDescription.LoadTraining;
		this.m.Icon = "ui/perks/load_training.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += BUFF;
	}
});