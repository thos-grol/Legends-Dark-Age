// Defines functions to apply bag status effects
//  - ie. poison

// =================================================================================================
// Associated tmp variables and managers
// =================================================================================================

::Z.T.POISON_SOUNDS <- [
    "sounds/enemies/dlc2/giant_spider_poison_01.wav",
    "sounds/enemies/dlc2/giant_spider_poison_02.wav"
];

// =================================================================================================
// Main
// =================================================================================================

::Z.S.apply_poison <- function(tag)
{

    // _SKILL = _skill,

    // 1. check valid
    if (!tag._target.isAlive()) return;
    if (tag._target.getHitpoints() <= 0) return;
    if (tag._target.getFlags().has("undead")) return;

    if (tag._damage < ::Const.Combat.PoisonEffectMinDamage) return; // not enough damage
    if (tag._SKILL.m.InjuriesOnBody == ::Const.Injury.BluntBody) return; // blunt weapon skills ignored

    local poisoner = tag._actor.getSkills().getSkillByID("perk.poisoner") != null;

    local chance = tag._effect_chance;
    if (poisoner) chance += 25;
    if (::Math.rand(1, 100) > chance) return;

    // 2. check resistances & apply the effect
    local level = tag._effect_level;
    if (poisoner) level += 1;
    ::Z.S.add_effect( tag._actor, tag._target, tag._effect_def, level);

    // play poisoning sound
    if (!tag._target.isHiddenToPlayer())
    {
        ::Sound.play(::Z.T.POISON_SOUNDS[::Math.rand(0, ::Z.T.POISON_SOUNDS.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, tag._target.getPos());
    }

    // 4. apply any other modifiers on successful apply
    if (tag._actor.getSkills().getSkillByID("perk.lotus_poison") != null)
    {
        //TODO: lotus poison apply weakness
    }
}

// =================================================================================================
// Helper
// =================================================================================================
