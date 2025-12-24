this.weakness_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2,
		can_reset = false
	},
	function create()
	{
		this.m.ID = "effects.weakness";
		this.m.Name = "Weakness";
		this.m.Icon = "ui/perks/weakness.png";
		this.m.IconMini = "weakness_mini";
		this.m.Overlay = "weakness";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This feels a weakness that soften their blows. Will wear off in [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
	{
		return [
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
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-50%[/color] Damage"
			}
		];
	}

	function onAdded()
	{
	}

	function onRefresh()
	{
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_87", this.getContainer().getActor().getTile());
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 0.5;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

