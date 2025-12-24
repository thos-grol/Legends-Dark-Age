// this hooks the shield class
// hk - remove knockback skill
::m.hookTree("scripts/items/shields/shield", function(q) {

	// hk - remove knockback skill
	q.onEquip <- function() 
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
	}
});