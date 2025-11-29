::mods_hookExactClass("entity/world/settlements/city_state", function(o)
{
    o.m.Capital <- true;
});

::mods_hookExactClass("entity/world/settlements/legends_fort", function(o) {
    o.m.Capital <- true;
});

::mods_hookExactClass("entity/world/settlement", function(o)
{
    o.m.Capital <- false;

    local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
        if (this.m.Capital) return;
        
		this.getLabel("name").Visible = false;
        local location_banner = this.getSprite("location_banner");
		location_banner.Visible = false;
	}

    o.make_less_apparent <- function()
	{
		local location_banner = this.getSprite("location_banner");
		location_banner.Visible = false;
        this.setShowName(false);
	}
});

::mods_hookNewObject("factions/faction_manager", function(o)
{
    o.fix_settlement_display <- function()
	{
		foreach( s in this.World.EntityManager.getSettlements() )
		{
            if (s.m.Capital) continue;
            s.make_less_apparent();
		}
	}
});

