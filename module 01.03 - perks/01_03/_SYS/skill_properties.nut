// this hooks the skill class
// - adds skill descriptor field
::m.rawHook("scripts/skills/skill", function(p) {

	// - adds skill descriptor field
	p.m.SkillType <- SKILL_TYPE.PHYSICAL;

});