//adds logic to taunt players
::m.hookTree("scripts/skills/skill", function(q) {
	q.onVerifyTarget = @(__original) function(_originTile, _targetTile) {
        // end here if original skill fails
        if (!__original(_originTile, _targetTile)) return false;

        local user = _originTile.getEntity();
        if (user == null) return true;
        if (!user.isPlayerControlled()) return true; //this only applies to players

        local taunt = this.getContainer().getSkillByID("effects.taunted");
        if (taunt == null) return true;
        if (taunt.m.forced_target == null) return true;

        try 
        {
            local target = _targetTile.getEntity();
            if (target == null) return true;
            return taunt.m.forced_target == target;
        } 
        catch(exception) 
        {
            taunt.m.forced_target = null;
        }
        return true;
	}
});

::mods_hookExactClass("skills/skill/taunted_effect", function (o)
{
    o.m.forced_target <- null;

});