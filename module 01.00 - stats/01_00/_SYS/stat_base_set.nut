// hk purpose
// - modify base stats with our own
::mods_hookExactClass("skills/backgrounds/character_background", function (o){
	local buildAttributes = o.buildAttributes;
	o.buildAttributes = function( _tag = null, _attrs = null )
	{
		local ret = buildAttributes(_tag, _attrs);

		//hk - set base stats from template + background
		local b = this.getContainer().getActor().getBaseProperties();
		local c = this.onChangeAttributes();
		b.ActionPoints = 9;
		b.Hitpoints = c.Hitpoints[1] + ::DEF.C.Stats.Base.Hitpoints;
		b.Bravery = c.Bravery[1] + ::DEF.C.Stats.Base.Bravery;
		b.Stamina = c.Stamina[1] + ::DEF.C.Stats.Base.Stamina;
		b.MeleeSkill = c.MeleeSkill[1] + ::DEF.C.Stats.Base.MeleeSkill;
		b.MeleeDefense = c.MeleeDefense[1] + ::DEF.C.Stats.Base.MeleeDefense;
		b.Initiative = c.Initiative[1] + ::DEF.C.Stats.Base.Initiative;
		
		b.RangedSkill = c.RangedSkill[1] + ::DEF.C.Stats.Base.RangedSkill;
		b.RangedDefense = c.RangedDefense[1] + ::DEF.C.Stats.Base.RangedDefense;

		local actor = this.getContainer().getActor();
		// flags can be set here
		// actor.getFlags().set("trainable_hitpoints", ::Math.max(0, 120 - b.Hitpoints));

		actor.m.CurrentProperties = clone b;
		actor.setHitpoints(b.Hitpoints);
		return ret;
	}
});