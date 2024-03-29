this.riposte_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.riposte";
		this.m.Name = "Riposte";
		this.m.Icon = "skills/status_effect_33.png";
		this.m.IconMini = "status_effect_33_mini";
		this.m.Overlay = "status_effect_33";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is prepared to immediately counter-attack on any failed attempt to attack him in melee.";
	}

	function onUpdate( _properties )
	{
		_properties.IsRiposting = true;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

