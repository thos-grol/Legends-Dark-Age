
this.perk_blade_dancer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.blade_dancer";
		this.m.Name = ::Const.Strings.PerkName.BladeDancer;
		this.m.Description = ::Const.Strings.PerkDescription.BladeDancer;
		this.m.Icon = "ui/perks/blade_dancer.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.Overlay = "blade_dancer";
	}

	function onMissed( _attacker, _skill )
	{
		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_attacker)) return;

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon(this.m.Overlay, actor.getTile());
			::Tactical.EventLog.logIn(::color_name(actor) + " [Blade Dancer]");
		}

		local fleche = actor.getSkills().getSkillByID("actives.fleche");
		if (fleche != null)
		{
			fleche.m.cooldown = ::Math.max(0, fleche.m.cooldown - 1);
		}

		local footwork = actor.getSkills().getSkillByID("actives.footwork");
		if (footwork != null)
		{
			footwork.m.cooldown = ::Math.max(0, footwork.m.cooldown - 1);
		}

		if (::Math.rand(1, 100) > 25) return;
		local escape = actor.getSkills().getSkillByID("perk.escape");
		if (escape != null)
		{
			escape.m.cooldown = ::Math.max(0, escape.m.cooldown - 1);
		}
	}
});