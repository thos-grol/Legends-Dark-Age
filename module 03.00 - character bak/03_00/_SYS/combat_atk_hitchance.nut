::mods_hookExactClass("skills/skill", function (o)
{
	while(!("m" in o && "ID" in o.m)) o=o[o.SuperName];
	o.getHitchance = function( _targetEntity )
	{
		if (!_targetEntity.isAttackable()) return 0;
		
		local user = this.m.Container.getActor();
		local properties = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, _targetEntity));
		if (!this.isUsingHitchance()) return 100;
		
		local allowDiversion = this.m.IsRanged && this.m.MaxRangeBonus > 1;
		local defenderProperties = _targetEntity.getSkills().buildPropertiesForDefense(user, this);

		local RET = ::Z.S.get_ranged_details(_user);
		local ranged_mult = RET.ranged_mult;
		local melee_mult = RET.melee_mult;
		local skill = properties.MeleeSkill * properties.MeleeSkillMult;
		skill *= this.m.IsRanged ? ranged_mult : melee_mult;

		local defense = _targetEntity.getDefense(user, this, defenderProperties);
		local levelDifference = _targetEntity.getTile().Level - user.getTile().Level;
		local distanceToTarget = user.getTile().getDistanceTo(_targetEntity.getTile());
		local toHit = skill - defense;

		if (this.m.IsRanged)
		{
			toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
		}
		if (levelDifference < 0)
		{
			toHit = toHit + ::Const.Combat.LevelDifferenceToHitBonus;
		}
		else
		{
			toHit = toHit + ::Const.Combat.LevelDifferenceToHitMalus * levelDifference;
		}
		
		// if (!this.m.IsShieldRelevant)
		// {
		// 	local shield = _targetEntity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		// 	if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield))
		// 	{
		// 		local shieldBonus = (this.m.IsRanged ? ::Math.round(shield.getMeleeDefense() * 0.75) : shield.getMeleeDefense());
		// 		toHit = toHit + shieldBonus;

		// 		if (!this.m.IsShieldwallRelevant && _targetEntity.getSkills().hasSkill("effects.shieldwall"))
		// 		{
		// 			toHit = toHit + shieldBonus;
		// 		}
		// 	}
		// }

		toHit = toHit * properties.TotalAttackToHitMult;
		toHit = toHit + ::Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);
		
		local userTile = user.getTile();
		if (allowDiversion && this.m.IsRanged && userTile.getDistanceTo(_targetEntity.getTile()) > 1)
		{
			local blockedTiles = ::Const.Tactical.Common.getBlockedTiles(userTile, _targetEntity.getTile(), user.getFaction(), true);

			if (blockedTiles.len() != 0)
			{
				local blockChance = ::Const.Combat.RangedAttackBlockedChance * properties.RangedAttackBlockedChanceMult;
				toHit = ::Math.floor(toHit * (1.0 - blockChance));
			}
		}

		return ::Math.max(5, ::Math.min(95, toHit));
	}
});