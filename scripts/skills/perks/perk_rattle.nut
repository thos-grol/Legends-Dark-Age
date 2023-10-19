::Const.Strings.PerkName.Rattle <- "Rattle";
::Const.Strings.PerkDescription.Rattle <- "Rattle their bones..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Attack hit:")
+ "\nRattle the target"
+ "\n "+::MSU.Text.colorRed("Must inflict at least 5 Hitpoint damage to trigger. 2H weapons inflict an additional stack of rattled")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "Rattle: (Duration: 1)")
+ "\n "+::MSU.Text.colorRed("– 10% Damage Dealt");


::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rattle].Name = ::Const.Strings.PerkName.Rattle;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rattle].Tooltip = ::Const.Strings.PerkDescription.Rattle;

this.perk_rattle <- this.inherit("scripts/skills/skill", {
	m = {
		MinimumDamage = 5
	},
	function create()
	{
		this.m.ID = "perk.rattle";
		this.m.Name = this.Const.Strings.PerkName.Rattle;
		this.m.Description = this.Const.Strings.PerkDescription.Rattle;
		this.m.Icon = "ui/perks/rattle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints < this.m.MinimumDamage) return;
		local actor = this.getContainer().getActor();
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor)) return;
		if (!_skill.isAttack()) return;

		local actor = this.getContainer().getActor();

		local stacks = 1;
		local weapon = actor.getMainhandItem();
		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded)) stacks += 1;
		if (this.m.Container.hasSkill("perk.stance.seismic_slam")) stacks *= 2;

		local rattled = !this.m.Container.hasSkill("effects.rattled") ? ::new("scripts/skills/effects/rattled_effect") : this.m.Container.getSkillByID("effects.rattled");
		rattled.m.Stacks += stacks;
		if (!this.m.Container.hasSkill("effects.rattled")) _targetEntity.getSkills().add(rattled);
	}
});
