
this.perk_reflex <- this.inherit("scripts/skills/skill", {
	m = {
		enabled = false
	},
	function create()
	{
		this.m.ID = "perk.reflex";
		this.m.Name = ::Const.Strings.PerkName.Reflex;
		this.m.Description = ::Const.Strings.PerkDescription.Reflex;
		this.m.Icon = "ui/perks/reflex.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.Overlay = "reflex";
	}

	function trigger()
	{
		if (this.m.enabled) return;
		this.m.enabled = true;

		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - 15));
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, actor.getPos());
			}

			this.spawnIcon(this.m.Overlay, actor.getTile());
			::Tactical.EventLog.logIn(::color_name(actor) + " [Reflex]");
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (::Math.rand(1, 100) > 20) return;
		trigger();
	}

	function onMissed( _attacker, _skill )
	{
		if (::Math.rand(1, 100) > 20) return;
		trigger();
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 5;
		if (this.m.enabled)
		{
			_properties.ActionPoints += 4;
		}
	}

	function onTurnEnd()
	{
		this.m.enabled = false;
	}
});