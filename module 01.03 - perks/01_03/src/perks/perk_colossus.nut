::mods_hookExactClass("skills/perks/perk_colossus", function (o)
{
	o.m.BUFF <- 2;

	// o.create = @() function()
	// {
	// 	this.m.ID = "perk.colossus";
	// 	this.m.Name = ::Const.Strings.PerkName.Colossus;
	// 	this.m.Description = ::Const.Strings.PerkDescription.Colossus;
	// 	this.m.Icon = "ui/perks/perk_06.png";
	// 	this.m.Type = ::Const.SkillType.Perk;
	// 	this.m.Order = ::Const.SkillOrder.Perk;
	// 	this.m.IsActive = false;
	// 	this.m.IsStacking = false;
	// 	this.m.IsHidden = false;
	// }

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
		{
			actor.setHitpoints(actor.getHitpoints() + this.m.BUFF);
		}
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Hitpoints += this.m.BUFF;
	}
});

