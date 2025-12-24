this.log_system <- this.inherit("scripts/skills/skill", {
	m = {
		notify_log_new_line = false
	},
	function create()
	{
		this.m.ID = "special.log_system";
		this.m.Name = "Log System";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;

		this.m.Description = "Does logging stuff";
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

	function isHidden()
	{
		return true;
	}

	//log fns

	function onTurnStart()
	{
		this.m.notify_log_new_line = true;
	}

	function onResumeTurn()
	{
		this.m.notify_log_new_line = true;
	}

});

