::mods_hookExactClass("skills/actives/shieldwall", function(o)
{
	o.create <- function()
	{
		this.m.ID = "actives.shieldwall";
		this.m.Name = "Shieldwall";
		this.m.Description = "The shield is raised to a protective stance, gaining Armor Points until next turn start.";
		this.m.Icon = "skills/active_15.png";
		this.m.IconDisabled = "skills/active_15_sw.png";
		this.m.Overlay = "active_15";
		this.m.SoundOnUse = [
			"sounds/combat/shieldwall_01.wav",
			"sounds/combat/shieldwall_02.wav",
			"sounds/combat/shieldwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	o.isUsable = function ()
	{
		if (!this.skill.isUsable()) return false;
		if (this.getContainer().hasEffect(::Legends.Effect.LegendSafeguarding)) return false;
		if (this.getContainer().hasEffect(::Legends.Effect.Shieldwall)) return false;
		return true;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		return true;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult *= _properties.IsProficientWithShieldWall ? 0.25 : 1.0;
		this.m.FatigueCostMult *= _properties.BlockMastery ? 0.75 : 1.0;
	}

});
