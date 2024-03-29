::Const.Strings.PerkName.StanceSeismicSlam <- "Seismic Slam";
::Const.Strings.PerkDescription.StanceSeismicSlam <- ::MSU.Text.color(::Z.Color.Purple, "Stance")
+ "\nEarthshaking..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorRed("– 25%") + " Agility"
+ "\n"+::MSU.Text.colorRed("+3") + " Attack AP Cost up to 9"
+ "\nDouble the amount of rattle stacks inflicted"
+ "\nAttacks ignore Freedom of Movement and are unparriable"
+ "\n"+::MSU.Text.colorGreen("+25%") + " damage"
+ "\nAttack will stagger and seal the enemy"

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Stagger: (Removed on turn start)")
+ "\n"+::MSU.Text.colorRed("– 50% Agility")
+ "\n"+::MSU.Text.colorRed("– 25 Defense")
+ "\n"+::MSU.Text.colorRed("+Cancels Shieldwall, Spearwall, Return Favor, and Riposte")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Seal: (Duration: 1)")
+ "\n"+::MSU.Text.colorRed("– 4 AP")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Rattle: (Duration: 1)")
+ "\n "+::MSU.Text.colorRed("– 10% Damage Dealt, caps at 50%");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceSeismicSlam].Name = ::Const.Strings.PerkName.StanceSeismicSlam;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceSeismicSlam].Tooltip = ::Const.Strings.PerkDescription.StanceSeismicSlam;

this.perk_stance_seismic_slam <- this.inherit("scripts/skills/skill", {
	m = {
		APSpent = 0,
	},
	function create()
	{
		this.m.ID = "perk.stance.seismic_slam";
		this.m.Name = ::Const.Strings.PerkName.StanceSeismicSlam;
		this.m.Description = ::Const.Strings.PerkDescription.StanceSeismicSlam;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function onUpdate(_properties)
	{
		_properties.InitiativeMult *= 0.75;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.m.IsAttack)
		{
			_properties.DamageTotalMult *= 1.25;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying() && _skill.m.IsAttack)
		{
			if (!_targetEntity.getSkills().hasSkill("effects.staggered"))
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
				if (!_targetEntity.isHiddenToPlayer()) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has been staggered");
			}

			if (!_targetEntity.getSkills().hasSkill("effects.seal"))
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/seal_effect"));
				if (!_targetEntity.isHiddenToPlayer()) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + "\'s movements have been sealed");
			}

		}
	}

	function onAfterUpdate(_properties)
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return;
		foreach (skill in this.getContainer().getSkillsByFunction(@(_skill) _skill.isAttack()))
		{
			skill.m.ActionPointCost = ::Math.min(9, skill.m.ActionPointCost + 3);
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (_skill != null)
		{
			foreach (skill in this.getContainer().getSkillsByFunction(@(s) s.isAttack()))
			{
				this.modifyPreviewField(skill, "ActionPointCost", ::Math.min(9, skill.m.ActionPointCost + 3), false);
			}
		}
	}



});

