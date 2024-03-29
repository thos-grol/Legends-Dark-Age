this.recruiter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.recruiter";
		this.m.Name = "Recruiter";
		this.m.Description = "The recruiter will help the company scour for talents.";
		this.m.Image = "ui/campfire/recruiter_01";
		this.m.Cost = 300;
		this.m.Effects = [
			"Every settlement has 1 additional recruits"
		];
	}

	function onUpdate()
	{
		if ("RosterSizeAdditionalMin" in this.World.Assets.m)
			this.World.Assets.m.RosterSizeAdditionalMin += 1;

		if ("RosterSizeAdditionalMax" in this.World.Assets.m)
			this.World.Assets.m.RosterSizeAdditionalMax += 1;
	}

});

