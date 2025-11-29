
this.perk_conservation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.conservation";
		this.m.Name = ::Const.Strings.PerkName.Conservation;
		this.m.Description = ::Const.Strings.PerkDescription.Conservation;
		this.m.Icon = "ui/perks/conservation.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueEffectMult *= 0.75;
		
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Class")) 
		{
			switch(actor.getFlags().get("Class"))
			{
				case "Vanguard":
					_properties.IsProficientWithShieldWall = true;
					break;

			}
			
		}
		
	}
});