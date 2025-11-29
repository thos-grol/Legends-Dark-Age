this.character_system <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.character_system";
		this.m.Name = "Details";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;

		this.m.Description = "Provides details about the character's progression and armor.";
	}

	function getTooltip()
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local p = actor.getCurrentProperties();

		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::green(::Z.S.log_roundf(p.FatigueEffectMult) * 100) + "% Fatigue Cost (Skill)"
		});
		return ret;
	}

});

