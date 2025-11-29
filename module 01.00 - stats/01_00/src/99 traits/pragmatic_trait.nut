::mods_hookExactClass("skills/traits/legend_pragmatic_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendPragmatic);
		this.m.Name = "Pragmatic";
		this.m.Icon = "ui/traits/pragmatic_trait.png";
		this.m.Description = "Concerned more with matters of fact than with what could or should be.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),

			// remove Vicious traits
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
		];
	}

	o.getTooltip <- function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Attack"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Removes chance to hit head[/color]"
			}
		];
	}

	o.onAfterUpdate <- function( _properties )
	{
		_properties.HitChance[::Const.BodyPart.Head] = 0;
	}

	o.onUpdate <- function( _properties )
	{
		_properties.MeleeSkill += 10;
	}

});