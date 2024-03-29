::Const.Strings.PerkName.SpecAxe = "Axe Proficiency";
::Const.Strings.PerkDescription.SpecAxe = ::MSU.Text.color(::Z.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Axes)"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "With axe equipped:")
+ "\n Headshots will "+::MSU.Text.colorRed("Cull")+", executing targets with less than "+::MSU.Text.colorRed("33%")+" Vitality after recieving the hit"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Split Shield")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue"
+ "\n " + ::MSU.Text.colorGreen("+50%") + " shield damage";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecAxe].Name = ::Const.Strings.PerkName.SpecAxe;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecAxe].Tooltip = ::Const.Strings.PerkDescription.SpecAxe;

this.perk_mastery_axe <- this.inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Threshold = 0.33,
		ThresholdExecutioner = 0.44,
	},
	function create()
	{
		this.m.ID = "perk.mastery.axe";
		this.m.Name = ::Const.Strings.PerkName.SpecAxe;
		this.m.Description = ::Const.Strings.PerkDescription.SpecAxe;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!isEnabled()) return;
		if (_bodyPart != ::Const.BodyPart.Head
			|| !_skill.isAttack() || !this.isEnabled()
			|| !_targetEntity.isAlive() || _targetEntity.isDying()
			|| _targetEntity.getSkills().hasSkill("effects.indomitable")
			|| _targetEntity.getSkills().hasSkill("perk.colossus")
			) return;

		local threshold = this.m.Container.hasSkill("perk.stance.executioner") ? this.m.ThresholdExecutioner : this.m.Threshold;

		local actor = this.getContainer().getActor();
		if (_targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0) < threshold)
		{
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.color(::Z.Color.BloodRed, " has been culled"));

			_targetEntity.kill(actor, _skill, ::Const.FatalityType.Decapitated);
		}
	}

	function onUpdate(_properties)
	{
		_properties.IsSpecializedInAxes = true;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;
		local actor = this.getContainer().getActor();
		if (!actor.getCurrentProperties().IsAbleToUseWeaponSkills) return false; //isDisarmed
		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Axe)) return false;
		return true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Axe"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Axe"));
	}

});

