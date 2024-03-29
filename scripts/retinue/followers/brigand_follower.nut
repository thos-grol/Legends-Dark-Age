this.brigand_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.brigand";
		this.m.Name = "Brigand";
		this.m.Description = "The Brigand may be old and weak now, but at one point his name was feared across the land. In exchange for a hot meal and some coin, he happily shares with you what he learns from his contacts about caravans on the road.";
		this.m.Image = "ui/campfire/brigand_01";
		this.m.Cost = 300;
		this.m.Effects = [
			"See the movements of all caravans on the map",
			"See up to 3 of the most valuable items on a caravan"
		];
	}

	function onUpdate()
	{
		if ("IsBrigand" in this.World.Assets.m)
		{
			this.World.Assets.m.IsBrigand = true;
		}
	}

});

