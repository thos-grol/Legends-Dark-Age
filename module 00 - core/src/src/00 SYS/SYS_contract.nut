// This file sets up contracts
::mods_hookBaseClass("contracts/contract", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];
    local create = o.create;
    o.create = function()
    {
        create();
        // hk - This seed is set to "preserve" rolled enemies
        // use ::Math.seedRandom(this.Time.getRealTime());
        this.m.Flags.set("Seed", this.Time.getRealTime()); 
    }
});