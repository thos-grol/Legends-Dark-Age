// // hooks skill container for stat damage calculations
// ::mods_hookNewObject("skills/skill_container", function ( o )
// {
// 	o.buildPropertiesForUse = function( _caller, _targetEntity )
// 	{
// 		local superCurrent = this.m.Actor.getCurrentProperties().getClone();
// 		local updating = this.m.IsUpdating;
// 		this.m.IsUpdating = true;
// 		foreach( i, skill in this.m.Skills )
// 		{
// 			skill.onAnySkillUsed(_caller, _targetEntity, superCurrent);
// 		}

		
// 		//hk - strength implementation
// 		local strength = superCurrent.getStrength();
// 		superCurrent.MeleeDamageMult *= 1.0 + strength / 100.0;
// 		superCurrent.RangedDamageMult *= 1.0 + strength / 100.0;

		
// 		this.m.IsUpdating = updating;
// 		return superCurrent;
// 	}
// });
