
this.perk_alert2 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.alert2";
		this.m.Name = ::Const.Strings.PerkName.Alert2;
		this.m.Description = ::Const.Strings.PerkDescription.Alert2;
		this.m.Icon = "ui/perks/alert2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local f = actor.getFlags();

		if (!f.has("Level Updated To")) return;
		local level = f.getAsInt("Level Updated To");
		
		local mult = 0;
		if (level >= 3) mult++;
		if (level >= 5) mult++;
		
		_properties.Initiative += 10 * mult;

		if (::has_skill(actor, "effects.dazed")) return;
		if (::has_skill(actor, "effects.stunned")) return;
		
		_properties.Alert_Defense = true;
	}
});