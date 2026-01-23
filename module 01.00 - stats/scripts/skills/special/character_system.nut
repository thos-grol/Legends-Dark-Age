this.character_system <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.character_system";
		this.m.Name = "Details";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;

		this.m.Description = "Provides details about the character's progression and armor.";
	}

	// ui display fns - has helpers in the static fns

	function getTooltip()
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local p = actor.getCurrentProperties();
		local f = actor.getFlags();

		local ret = this.skill.getTooltip();

		local _class = null;
		if (f.has("Class")) _class = f.get("Class");
		::Z.S.get_class_passives(ret, _class)
		// ret.push({
		// 	id = 10,
		// 	type = "text",
		// 	icon = "ui/icons/fatigue.png",
		// 	text = ::green(::Z.S.log_roundf(p.FatigueEffectMult) * 100) + "% Fatigue Cost (Skill)"
		// });
		return ret;
	}



	// logic fns, implement passives given by level and class
	function onUpdate( _properties )
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local f = actor.getFlags();

		// implement class passives
		local _class = null;
		if (f.has("Class")) _class = f.get("Class");
		if (_class == "Vanguard")
		{
			_properties.SurroundedDefense += 5; // Underdog
		}
	}



	// on attacked
	function roll_flaw(actor, _targetEntity)
	{
		if (!actor.isAlive() || actor.isDying()) return;
		if (!_targetEntity.isAlive() || _targetEntity.isDying()) return;

		if (actor.isAlliedWith(_targetEntity)) return;
		if (actor.getID() == _targetEntity.getID()) return;

		local true_strike = actor.getSkills().getSkillByID("perk.true_strike") != null;
		local chance = 15;
		if (true_strike) chance += 10;
		if (::Math.rand(1, 100) > chance) return;

		local limit = 2;
		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > limit) return;

		::Z.S.add_effect_lite(actor, _targetEntity, ::Legends.Effect.Flaw);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local f = actor.getFlags();

		// implement class passives
		local _class = null;
		if (f.has("Class")) _class = f.get("Class");

		// rogue - keen instinct
		if (_class == "Rogue")
		{
			roll_flaw(actor, _targetEntity);
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local f = actor.getFlags();

		// implement class passives
		local _class = null;
		if (f.has("Class")) _class = f.get("Class");

		// rogue - keen instinct
		if (_class == "Rogue")
		{
			roll_flaw(actor, _targetEntity);
		}
	}

	

	// on being attacked
	function onMissed( _attacker, _skill )
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local f = actor.getFlags();

		// implement class passives
		local _class = null;
		if (f.has("Class")) _class = f.get("Class");

		// rogue - keen instinct
		if (_class == "Rogue")
		{
			roll_flaw(actor, _attacker);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local c = this.getContainer();
		local actor = c.getActor();
		local f = actor.getFlags();

		// implement class passives
		local _class = null;
		if (f.has("Class")) _class = f.get("Class");

		// rogue - keen instinct
		if (_class == "Rogue")
		{
			roll_flaw(actor, _attacker);
		}
	}
});

