this.contract_entity <- this.inherit("scripts/entity/world/location", {
	m = {
		Description = "Unset",
        Contract = null,
        Settlement = null
	},
	function getDescription()
	{
		return "A huge statue glittering in the sun that towers over the surrounding landscape.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.ancient_statue";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnEnter = "event.location.ancient_statue";

		this.m.IsShowingName = true;
		this.m.IsShowingLabel = true;
        this.m.Is_Contract = true;
	}

	function set_details(tag)
    {
        this.m.Name = tag.Name;
        local label = this.getLabel("name");
        label.Visible = true;
        label.Text = this.getName();

        this.m.Description = tag.Description;

        local body_id = tag.IsStory ? "story_" : "radiant_";
        body_id += tag.Difficulty;
        
        local body = this.getSprite("body");
        body.setBrush(body_id);
        body.Visible = true;
    }

	function onSpawned()
	{
		this.m.Name = "Ancient Statue";
		this.location.onSpawned();
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		this.World.Flags.increment("LegendaryLocationsDiscovered", 1);

		if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 10)
		{
			this.updateAchievement("FamedExplorer", 1, 1);
		}
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_ancient_statue");
	}

});

