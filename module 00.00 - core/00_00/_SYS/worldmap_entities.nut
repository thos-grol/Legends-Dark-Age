


::m.rawHook("scripts/entity/world/world_entity", function(p) {
    p.m.Capital <- false;
    p.m.Enterable <- false;
    p.is_enterable <- function()
    {
        return this.m.Enterable;
    }

    p.is_capital <- function()
    {
        return this.m.Capital;
    }
});
::m.rawHook("scripts/entity/world/settlements/city_state", function(p) {
    p.m.Capital <- true;
    p.m.Enterable <- true;
});
::m.rawHook("scripts/entity/world/settlements/legends_fort", function(p) {
    p.m.Capital <- true;
    p.m.Enterable <- true;
});

// ::mods_hookExactClass("entity/world/settlements/city_state", function(o) { o.m.Capital <- true; o.m.Enterable <- true;});
// ::mods_hookExactClass("entity/world/settlements/legends_fort", function(o) { o.m.Capital <- true; o.m.Enterable <- true;});

// hk - hide names and banners for villages
::mods_hookExactClass("entity/world/settlement", function(o)
{
    local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
        if (this.is_capital()) return;
        
		this.getLabel("name").Visible = false;
        local location_banner = this.getSprite("location_banner");
		location_banner.Visible = false;
	}

    o.make_less_apparent <- function()
	{
        if (this.is_capital()) return;

        this.setShowName(false);
        this.getLabel("name").Visible = false;
        local location_banner = this.getSprite("location_banner");
		location_banner.Visible = false;
	}
});

