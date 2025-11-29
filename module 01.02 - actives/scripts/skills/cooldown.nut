this.cooldown <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown_Max = 0,
		Cooldown = 0,
	},
	function create()
	{
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
		];

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = this.m.Cooldown_Max;
		return true;
	}

	function onTurnStart()
	{
		if (this.m.Cooldown > 0) this.m.Cooldown--;
	}

	function isUsable()
	{
		if (this.m.Cooldown > 0) return false;

		local a = this.m.Container.getActor();
		if (!this.m.IsUsable || !a.getCurrentProperties().IsAbleToUseSkills) return false;
		return true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() == ::Const.Faction.Player) return;
		loadAI();
	}

	function loadAI()
	{
	}
});