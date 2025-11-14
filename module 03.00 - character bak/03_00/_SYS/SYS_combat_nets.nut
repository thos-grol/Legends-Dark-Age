::mods_hookExactClass("skills/perks/perk_legend_net_repair", function (o)
{
    o.m.Count <- 1;
    o.m.Refill <- false;

    o.create = function()
	{
		this.m.ID = "perk.legend_net_repair";
		this.m.Name = ::Const.Strings.PerkName.LegendNetRepair;
		this.m.Description = ::Const.Strings.PerkDescription.LegendNetRepair;
		this.m.Icon = "ui/perks/net_perk.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

    o.onTurnEnd <- function()
	{
        if (this.m.Refill)
        {
            this.getContainer().getActor().m.Items.equip(::new("scripts/items/tools/throwing_net"));
            this.m.Refill = false;
            this.m.Count -= 1;
        }
	}

	// onUpdate <- function( _properties ){}

    o.refill <- function()
    {
        if (this.m.Count > 0) this.m.Refill = true;
    }

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();

		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (item == null) this.getContainer().getActor().m.Items.equip(::new("scripts/items/tools/throwing_net"));

		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.ThrowNet) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
			agent.finalizeBehaviors();
		}
	}

	o.onCombatFinished <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled()) return;

		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (item == null) this.getContainer().getActor().m.Items.equip(::new("scripts/items/tools/throwing_net"));
	}

	o.onCombatStarted <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("perk.legend_net_casting")) this.m.Count = 3;
	}

});

::mods_hookExactClass("items/tools/throwing_net", function (o)
{
	local create = o.create;
	o.create <- function()
	{
		create();
		this.m.IsDroppedAsLoot = false;
	}
});

//======================================================================================================================
::Const.Strings.PerkName.LegendNetCasting = "Net Arsenal"
::Const.Strings.PerkDescription.LegendNetCasting = "A well equipped mercenary is a prepared mercenary..."
+ "\n\n" + ::MSU.Text.color(::DEF.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::green("+1") + " Net"
+ "\n"+::green("+20%") + " Net debuff effectiveness";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendNetCasting].Name = ::Const.Strings.PerkName.LegendNetCasting;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendNetCasting].Tooltip = ::Const.Strings.PerkDescription.LegendNetCasting;

::mods_hookExactClass("skills/perks/perk_legend_net_casting", function (o)
{
	o.onUpdate = function( _properties ) { }
	o.getItemActionCost = function( _items ) { return null; }
});

//======================================================================================================================
//remove net item drops from throwing nets
::mods_hookExactClass("skills/actives/throw_net", function (o)
{
    //rework nets to be dodgeable with escape artist perk
    //remove net drops
    //add logic to refill nets based on net mastery
    o.onUse = function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local roll = ::Math.rand(1, 100);
		local chance = ::Math.min(100, ::Math.round(targetEntity.getCurrentProperties().getMeleeDefense() * 0.75));
		local dodgeCheck = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") &&  roll <= chance;

		local net_item = _user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (net_item.m.Container != null)
		{
			net_item.m.Container.unequip(net_item);
			net_item.m.IsDroppedAsLoot = false;
		}

		local net_repair = _user.getSkills().getSkillByID("perk.legend_net_repair");
		if (net_repair != null) net_repair.refill();

        if (targetEntity.getCurrentProperties().IsImmuneToRoot || dodgeCheck)
        {
			if (this.m.SoundOnMiss.len() != 0) this.Sound.play(this.m.SoundOnMiss[::Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());

            if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to net " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Defense with -10 modifier, rolled " + roll + " vs " + chance + ", the net falls to the ground");
			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to net immune target " + ::Const.UI.getColorizedEntityName(targetEntity) + ", the net falls to the ground");
			}
			return false;
		}
        else
		{
			if (this.m.SoundOnHit.len() != 0) this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Defense with -10 modifier, rolled " + roll + " vs " + chance);

			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + ::Const.UI.getColorizedEntityName(targetEntity));
			}

			targetEntity.getSkills().add(::new("scripts/skills/effects/net_effect"));
			local breakFree = ::new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			breakFree.setChanceBonus(0);

			if (_user.getSkills().hasSkill("perk.legend_net_casting")) breakFree.setChanceBonus(-20);

			if (this.m.IsReinforced) breakFree.setDecal("net_destroyed_02");
			else breakFree.setDecal("net_destroyed");

			targetEntity.getSkills().add(breakFree);

			local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = this.m.IsReinforced
			});
		}

	}
});

//======================================================================================================================

::mods_hookExactClass("skills/actives/web_skill", function (o)
{
	o.onUse = function( _user, _targetTile )
	{
		this.m.Cooldown = 3;
		local targetEntity = _targetTile.getEntity();

		local roll = ::Math.rand(1, 100);
		local chance = ::Math.min(100, _user.getCurrentProperties().getMeleeDefense() - 10);

		local dodgeCheck = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") &&  roll <= chance;

		if (targetEntity.getCurrentProperties().IsImmuneToRoot || dodgeCheck)
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[::Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to web " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Defense with -10 modifier, rolled " + roll + " vs " + chance);
			}

			return false;
		}
		else
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			targetEntity.getSkills().add(::new("scripts/skills/effects/web_effect"));
			local breakFree = ::new("scripts/skills/actives/break_free_skill");
			breakFree.setDecal("web_destroyed");
			breakFree.m.Icon = "skills/active_113.png";
			breakFree.m.IconDisabled = "skills/active_113_sw.png";
			breakFree.m.Overlay = "active_113";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect("bust_web2", this.createColor("#ffffff"), _targetTile, 0, 4, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), targetEntity);

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " webs " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Defense with -10 modifier, rolled " + roll + " vs " + chance);

			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " webs " + ::Const.UI.getColorizedEntityName(targetEntity));
			}
			return true;
		}
	}

});

//======================================================================================================================

::mods_hookExactClass("skills/actives/root_skill", function(o) {
	o.m.Cooldown <- ::Math.rand(1, 3);

	o.isUsable = function()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee() && this.m.Cooldown == 0;
	}

	o.onTurnStart <- function()
	{
		this.m.Cooldown = ::Math.max(0, this.m.Cooldown - 1);
	}

	o.onUse = function( _user, _targetTile )
	{
		local targets = [];

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();

			if (this.isViableTarget(_user, entity))
			{
				targets.push(entity);
			}
		}

		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local adjacent = _targetTile.getNextTile(i);

				if (adjacent.IsOccupiedByActor)
				{
					local entity = adjacent.getEntity();

					if (this.isViableTarget(_user, entity))
					{
						targets.push(entity);
					}
				}
			}

			i = ++i;
		}

		foreach( target in targets )
		{

			local roll = ::Math.rand(1, 100);
			local chance = ::Math.min(100, _user.getCurrentProperties().getMeleeDefense() - 10);
			local dodgeCheck = target.getSkills().hasSkill("perk.legend_escape_artist") &&  roll <= chance;

			if (!dodgeCheck)
			{
				target.getSkills().add(::new("scripts/skills/effects/rooted_effect"));
				local breakFree = ::new("scripts/skills/actives/break_free_skill");
				breakFree.setDecal("roots_destroyed");
				breakFree.m.Icon = "skills/active_75.png";
				breakFree.m.IconDisabled = "skills/active_75_sw.png";
				breakFree.m.Overlay = "active_75";
				breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
				target.getSkills().add(breakFree);
				target.raiseRootsFromGround("bust_roots", "bust_roots_back");

				if (target.getSkills().hasSkill("perk.legend_escape_artist"))
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " roots " + ::Const.UI.getColorizedEntityName(target) + ". Using Defense with -10 modifier, rolled " + roll + " vs " + chance);
				}
			}
			else
			{
				if (target.getSkills().hasSkill("perk.legend_escape_artist"))
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to root " + ::Const.UI.getColorizedEntityName(target) + ". Using Defense with -10 modifier, rolled " + roll + " vs " + chance);
				}
			}
		}

		if (targets.len() > 0 && this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, this.targetEntity.getPos());
		}

		this.m.Cooldown = 3;
		return true;

	}
});