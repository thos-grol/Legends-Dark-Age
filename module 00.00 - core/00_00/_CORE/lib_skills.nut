// !! For core core stuff, see scripts/config

::has_skill <- function(_actor, _skill_id)
{
    return _actor.getSkills().hasSkill(_skill_id);
}