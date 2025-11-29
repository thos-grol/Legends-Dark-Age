this.contract_entity <- this.inherit("scripts/entity/world/location", {
	m = {
		ContractID = null
	},
	function getDescription()
	{
		local contract = get_contract();
		if (contract == null) return "Unset";
		if (contract.m.Description == null || contract.m.Description == "") return "Unset";
		return contract.m.Description;
	}

	function trigger_contract()
	{
		local contract = ::World.Contracts.get_contract_by_id(this.m.ContractID);
		::World.Contracts.showContract(contract);
	}

	function get_contract()
	{
		return ::World.Contracts.get_contract_by_id(this.m.ContractID);
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
        this.m.ContractID = tag.ID;

        this.m.Name = tag.Name;
        local label = this.getLabel("name");
        label.Visible = true;
        label.Text = this.getName();

        // this.m.Description = tag.Description;

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

	function onSerialize( _out )
	{
		this.location.onSerialize(_out);
		_out.writeI32(this.m.ContractID);
	}

	function onDeserialize( _in )
	{
		this.location.onDeserialize( _in );
		this.m.ContractID = _in.readI32();
	}

});

