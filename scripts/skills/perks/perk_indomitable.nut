::Const.Strings.PerkName.Indomitable = "Indomitable";
::Const.Strings.PerkDescription.Indomitable = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n" + "Indomitable, like the mountain..."

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Become Indomitable:")
+ "\n " + ::MSU.Text.colorGreen("– 50%") + " damage taken"
+ "\n" + ::MSU.Text.colorGreen("+Stun Immunity")
+ "\n" + ::MSU.Text.colorGreen("+Displacement Immunity");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Indomitable].Name = ::Const.Strings.PerkName.Indomitable;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Indomitable].Tooltip = ::Const.Strings.PerkDescription.Indomitable;

this.perk_indomitable <- this.inherit("scripts/skills/skill", {
	m = {
		On = false
	},
	function create()
	{
		this.m.ID = "perk.indomitable";
		this.m.Name = ::Const.Strings.PerkName.Indomitable;
		this.m.Description = ::Const.Strings.PerkDescription.Indomitable;
		this.m.Icon = "ui/perks/perk_30.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		// local projected_hitpoints_pct = actor.getHitpoints() / actor.getHitpointsMax();
		// if (projected_hitpoints_pct > 0.5) return;
		this.m.On = true;
		if (!this.getContainer().hasSkill("effects.indomitable"))
			this.m.Container.add(::new("scripts/skills/effects/indomitable_effect"));
	}

	function onCombatFinished()
	{
		this.m.On = false;
	}

	// function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	// {
	// 	if (this.m.On) return;
	// 	local actor = this.getContainer().getActor();
	// 	local projected_hitpoints_pct = actor.getHitpoints() / actor.getHitpointsMax();
	// 	if (projected_hitpoints_pct > 0.5) return;

	// 	this.m.On = true;
	// 	if (!this.getContainer().hasSkill("effects.indomitable"))
	// 		this.m.Container.add(::new("scripts/skills/effects/indomitable_effect"));

	// }

});

