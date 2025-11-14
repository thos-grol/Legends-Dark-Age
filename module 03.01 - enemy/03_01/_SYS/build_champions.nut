::mods_hookBaseClass("entity/tactical/entity", function ( o )
{
	while(!("Flags" in o.m)) o=o[o.SuperName];
    o.makeMiniboss <- function()
    {
        if (!::Const.DLC.Wildmen) return false;

        this.m.XP *= 1.5;
        // this.m.Skills.add(::new("scripts/skills/racial/champion_racial"));
        this.m.IsMiniboss = true;
        this.m.IsGeneratingKillName = false;
        return true;
    }
});

::mods_hookBaseClass("entity/tactical/actor", function ( o )
{
    o.makeMiniboss <- function()
    {
        if (!::Const.DLC.Wildmen) return false;

        this.m.XP *= 1.5;
        // this.m.Skills.add(::new("scripts/skills/racial/champion_racial"));
        this.m.IsMiniboss = true;
        this.m.IsGeneratingKillName = false;
        return true;
    }
});