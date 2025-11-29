//this function imprints the living's information on the corpse for use
::Z.S.imprint_corpse <- function(_actor, _tile)
{
    if (_actor.getFlags().has("abomination")) return;
    if (_actor.getFlags().has("ghost")) return;

    local corpse = null;

    try
    {
        corpse = _tile.Properties.get("Corpse");
    } catch(exception) { return;}


    if (corpse == null) return;

    try
    {
        corpse.Tile = _tile;
    } catch(exception) { return;}

    corpse.Skills <- [];
    corpse.BaseProperties <- {};

    local isHeadAttached = true;
    try{ isHeadAttached = corpse.IsHeadAttached} catch(exception){}

    local skills = _actor.m.Skills.m.Skills
    foreach(skill in skills)
    {
        if (skill.isGarbage()) continue;
        if (skill.isType(::Const.SkillType.DamageOverTime | ::Const.SkillType.StatusEffect)) continue;
        
        // FEATURE_7: Enemy overhaul - mark actives as racial so zombies can grab them
        if (skill.isType(::Const.SkillType.Trait | ::Const.SkillType.Racial | ::Const.SkillType.Perk))
        {
            corpse.Skills.push(skill);
            continue
        }
        corpse.Skills.push(skill);
    }

    corpse.BaseProperties["Bravery"] <- _actor.m.BaseProperties.Bravery;
    if (_actor.m.BaseProperties.Initiative < 160) corpse.BaseProperties["Initiative"] <- 160;
    else corpse.BaseProperties["Initiative"] <- _actor.m.BaseProperties.Initiative;
    if (_actor.m.BaseProperties.MeleeSkill < 75) corpse.BaseProperties["MeleeSkill"] <- 75;
    else corpse.BaseProperties["MeleeSkill"] <- _actor.m.BaseProperties.MeleeSkill;
    corpse.BaseProperties["RangedSkill"] <- _actor.m.BaseProperties.RangedSkill;
    corpse.BaseProperties["MeleeDefense"] <- _actor.m.BaseProperties.MeleeDefense;
    corpse.BaseProperties["RangedDefense"] <- _actor.m.BaseProperties.RangedDefense;
    corpse.BaseProperties["Armor"] <- _actor.m.BaseProperties.Armor;

    if (_actor.getFlags().has("zombie_minion") && isHeadAttached && corpse.IsResurrectable) return;

    if (!corpse.IsResurrectable)
    {
        if (_actor.getSkills().hasSkill("trait._ranged_focus")
        || (!_actor.isPlayerControlled() && _actor.getAIAgent().getProperties().IsRangedUnit))
        {
            corpse.Type = "scripts/entity/tactical/enemies/flesh_abomination_ranged";
        }
        else
        {
            corpse.Type = "scripts/entity/tactical/enemies/flesh_abomination";
        }
    }
}

::Z.S.apply_miasma <- function(_tile, _entity)
{
    this.Tactical.spawnIconEffect("decay", _tile, ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
    local sounds = [];

    if (_entity.getFlags().has("human"))
    {
        sounds = [
            "sounds/humans/human_coughing_01.wav",
            "sounds/humans/human_coughing_02.wav",
            "sounds/humans/human_coughing_03.wav",
            "sounds/humans/human_coughing_04.wav"
        ];
    }
    else
    {
        sounds = [
            "sounds/enemies/miasma_appears_01.wav",
            "sounds/enemies/miasma_appears_02.wav",
            "sounds/enemies/miasma_appears_03.wav"
        ];
    }

    this.Sound.play(sounds[::Math.rand(0, sounds.len() - 1)], ::Const.Sound.Volume.Actor, _entity.getPos());


    local tile_effect = _tile.Properties.Effect;

    if (_tile.getEntity().getSkills().getSkillByID("perk.meditation.omen_of_decay") == null)
    {
        local decay = ::new("scripts/skills/effects/decay_effect");
        decay.setActor(tile_effect.Actor);
        decay.setDamage((tile_effect.Damage));
        _tile.getEntity().getSkills().add(decay);
    }
}

::mods_hookExactClass("entity/tactical/actor", function (o)
{
	o.onResurrected = function( _info )
	{
        this.setFaction(_info.Faction);

        if (_info.IsResurrectable || this.getFlags().has("zombie_minion"))
		{
            this.getItems().clear();
            _info.Items.transferTo(this.getItems());

            if (_info.Name.len() != 0)
            {
                this.m.Name = _info.Name;
            }

            if (_info.Description.len() != 0)
            {
                this.m.Description = _info.Description;
            }

            this.m.Hitpoints = this.getHitpointsMax() * _info.Hitpoints;
            this.m.XP = ::Math.floor(this.m.XP * _info.Hitpoints);
            this.m.BaseProperties.Armor = _info.Armor;
            this.onUpdateInjuryLayer();
		}
        else
        {
            if (_info.Name.len() != 0) this.m.Name = "Flesh Abomination (" + _info.Name + ")";
            else if (_info.CorpseName.len() != 0) this.m.Name = "Flesh Abomination (" + _info.CorpseName + ")";

            if (_info.Description.len() != 0)
            {
                this.m.Description = _info.Description;
            }
        }

        if ("Skills" in _info)
        {
            foreach(skill in _info.Skills)
            {
                if (!getSkills().hasSkill(skill.m.ID)) getSkills().add(skill)
            }
        }

        if ("BaseProperties" in _info)
        {
            this.m.BaseProperties.Bravery = _info.BaseProperties["Bravery"];
            this.m.BaseProperties.Initiative = _info.BaseProperties["Initiative"];
            this.m.BaseProperties.MeleeSkill = _info.BaseProperties["MeleeSkill"];
            this.m.BaseProperties.RangedSkill = _info.BaseProperties["RangedSkill"];
            this.m.BaseProperties.MeleeDefense = _info.BaseProperties["MeleeDefense"];
            this.m.BaseProperties.RangedDefense = _info.BaseProperties["RangedDefense"];
        }

        this.m.Skills.update();

	}

    local addDefaultStatusSprites = o.addDefaultStatusSprites;
	o.addDefaultStatusSprites = function()
	{
		addDefaultStatusSprites();
		local compassion = this.addSprite("status_compassion");
		compassion.Visible = false;
	}

    o.drop_loot <- function(_tile){}
});

::Z.S.drop_loot <- function(_actor, tile)
{
    local no_killstealing = ::Legends.Effects.get(_actor, ::Legends.Effect.NoKillstealing);
    if (no_killstealing != null && !no_killstealing.isDroppingLoot()) return;
    _actor.drop_loot(tile);
}