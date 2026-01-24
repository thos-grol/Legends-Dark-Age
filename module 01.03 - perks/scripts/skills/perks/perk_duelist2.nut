
this.perk_duelist2 <- this.inherit("scripts/skills/skill", {
	m = {
		AllowedWeapons = [
			"_parrying_dagger",
			// "_hand_crossbow",
			"buckler",
			"legend_mummy_shield"
		],
		stacks = 0,
		max_stacks = 2
	},
	function create()
	{
		this.m.ID = "perk.duelist2";
		this.m.Name = ::Const.Strings.PerkName.Duelist2;
		this.m.Description = ::Const.Strings.PerkDescription.Duelist2;
		this.m.Icon = "ui/perks/duelist2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;

		this.m.Overlay = "duelist2";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isRanged()) return;
		_properties.DamageDirectAdd += this.getBonus();
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (_targetEntity.isAlliedWith(actor)) return;
		this.m.stacks = this.m.max_stacks;
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}

	function onUpdate( _properties )
	{
		if (this.m.stacks <= 0) return;
		_properties.DamageTotalMult *= 1.25;
		_properties.TargetAttractionMult *= 1.25;
	}

	// management

	function onTurnEnd()
	{
		if (this.m.stacks > 0) this.m.stacks--;
	}
	
	// helper

	function getBonus()
	{
		local main = getContainer().getActor().getMainhandItem();
		local off = getContainer().getActor().getOffhandItem();
		if (!isValid(main, off))
			return 0;

		if (isValidOffhand(main, off))
			return 0.25;

		return 0;
	}

	function isValidOffhand( _mainhand, _offhand )
	{
		if (_offhand == null) return false;
		foreach( valid in m.AllowedWeapons )
		{
			if (::MSU.String.endsWith(_offhand.getID(), valid))
				return true;
		}
		return false;
	}

	function isValid( _mainhand, _offhand )
	{
		if (_mainhand == null && _offhand == null) return false;
		return true;
	}

	
});