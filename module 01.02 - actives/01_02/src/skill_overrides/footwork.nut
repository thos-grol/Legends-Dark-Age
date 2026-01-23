::mods_hookExactClass("skills/actives/footwork", function(o)
{
	o.m.cooldown <- 0;
	o.m.cooldown_max <- 2;

	o.create = function()
	{
		this.m.ID = "actives.footwork";
		this.m.Name = "Footwork";
		this.m.Description = "Use skillful footwork to leave a Zone of Control without triggering free attacks.";
		this.m.Icon = "ui/perks/perk_25_active.png";
		this.m.IconDisabled = "ui/perks/perk_25_active_sw.png";
		this.m.Overlay = "perk_25_active";
		this.m.SoundOnUse = [
			"sounds/combat/footwork_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
	}

	o.onAfterUpdate = function (_properties)
	{
		// if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip)) {
		// 	this.m.MaxRange = 2;
		// }
		// _properties.SkillCostAdjustments.push({ // fix vanilla bullshit with hard setting fat cost in onAfterUpdate
		// 	ID = this.m.ID,
		// 	APAdjust = this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") ? -1 : 0,
		// 	FatigueMultAdjust = _properties.IsFleetfooted ? 0.5 : 1.0
		// });
		this.m.FatigueCostMult *= _properties.IsProficientWithRogue ? 0.75 : 1.0;

		local actor = this.getContainer().getActor();
		local blade_dancer = actor.getSkills().getSkillByID("perk.blade_dancer") != null;
		if (blade_dancer) this.m.ActionPointCost = 0;
	}

	
	
	// logic fns to make this skill a cooldown skill

	o.get_cooldown_max <- function()
	{
		local cd = this.m.cooldown_max
		local actor = this.getContainer().getActor();
		if (actor.getSkills().getSkillByID("perk.escape") != null) cd--;
		return ::Math.max(cd, 0);
	}

	local onUse = o.onUse;
	o.onUse <- function( _user, _targetTile )
	{
		this.m.cooldown = get_cooldown_max();
		return onUse(_user, _targetTile);
	}

	o.onTurnStart <- function()
	{
		if (this.m.cooldown > 0) this.m.cooldown--;
	}

	o.onCombatStarted <- function()
	{
		this.m.cooldown = 0;
	}

	o.onCombatFinished <- function()
	{
		this.m.cooldown = 0;
	}

	local isUsable = o.isUsable;
	o.isUsable <- function()
	{
		return this.m.cooldown == 0 && isUsable();
	}

	o.getTooltip <- function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		ret.push({
			id = 4,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Cooldown: " + this.m.cooldown + "/" + get_cooldown_max()
		});

		if (this.Tactical.isActive() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can only be used when in an opponent\'s Zone of Control[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}
});
