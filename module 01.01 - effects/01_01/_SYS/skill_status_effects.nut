::mods_hookBaseClass("skills/skill", function ( o )
{
    while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];
    
    // prevent resetting some effect durations ie. stun
    o.m.set_already <- false;
    o.m.can_reset <- true;
    o.set_turns <- function ( _t )
	{
        if (!this.m.can_reset && this.m.set_already) return;
        this.m.TurnsLeft = _t;
        this.m.set_already = true;
	}

    // set reduced flag indicating resistance
    o.m.reduced <- false;
    o.set_reduced <- function()
    {
        this.m.reduced = true;
    }
});