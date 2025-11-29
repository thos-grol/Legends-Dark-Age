this.contract_entity <- this.inherit("scripts/entity/world/location", {
    m = {
        Description = "Unset",
        Contract = null,
        Settlement = null
    },
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

    // function set_details(tag)
    // {
    //     this.m.Name = tag.Name;
    //     this.m.Description = tag.Description;

    //     local body = this.addSprite("banner");
    //     local body_id = tag.IsStory ? "story_" : "radiant_";
    //     body_id += tag.Difficulty;
	// 	body.setBrush(body_id);
    //     banner.Visible = false;

    //     local label_name = this.addLabel("name");
	// 	label_name.Visible = this.m.IsShowingName && this.Const.World.AI.VisualizeNameOfUnits;
	// 	label_name.Offset = this.createVec(0, 0);
	// 	label_name.Text = this.getName();
    // }

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.ancient_statue";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 0;
        this.m.OnEnter = "event.location.ancient_statue";
        
        this.m.IsShowingName = true;
		this.m.IsShowingLabel = true;
        this.m.Is_Contract = true;
	}

    function destroy()
    {
        if (this.hasLabel("name")) this.getLabel("name").Visible = false;
        this.fadeOutAndDie();
    }

    function onEnter()
	{
		::logInfo("On Enter");
        // if (!this.m.IsVisited && this.isDiscovered() && this.m.OnEnter != null)
		// {
		// 	this.m.IsVisited = true;
		// 	::World.Events.fire(this.m.OnEnter);
		// 	return false;
		// }
		// else if (this.m.OnEnterCallback != null)
		// {
		// 	this.m.OnEnterCallback(this);
		// 	return false;
		// }
		// else
		// {
		// 	this.m.IsVisited = true;
		// 	return true;
		// }
        //TODO: trigger associated contract opening
	}

    // boilerplate

    function isEnterable() { return true; }

    function get_settlement() { return this.m.Settlement; }
	function set_settlement( _s ) { this.m.Settlement = this.WeakTableRef(_s); }

	function getDescription() { return this.m.Description; }
	
    function onDiscovered() { this.location.onDiscovered(); }

	function onSpawned() { this.location.onSpawned(); }

    function onInit()
	{
		this.location.onInit();
        local body = this.addSprite("body");
		body.setBrush("radiant_0");
        body.Visible = true;

		this.setRenderedTop(true);
        this.setDiscovered(true);
		this.setVisibleInFogOfWar(true);
	}

    // if destroying during serialization doesn't work, then
    // try creating a presave cleanup phase
        // function campaign_menu_module_onSavePressed( _campaignFileName )
        // {
        // 	this.saveCampaign(_campaignFileName);
        // 	this.m.MenuStack.pop();
        // }
    // function onSerialize( _out ) { destroy(); }
	// function onDeserialize( _in ) { }
});