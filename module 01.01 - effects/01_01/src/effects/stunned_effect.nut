::mods_hookExactClass("skills/effects/stunned_effect", function(o)
{
    o.m.can_reset <- false;
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
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::red("-25%") + " Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::red("-25%") + " Initiative"
			}
		];
	}

    o.onAdded = function ()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.Shieldwall);
        ::Legends.Effects.remove(this, ::Legends.Effect.Spearwall);
        ::Legends.Effects.remove(this, ::Legends.Effect.Riposte);
        ::Legends.Effects.remove(this, ::Legends.Effect.LegendReturnFavor);
        ::Legends.Effects.remove(this, ::Legends.Effect.PossessedUndead);
        ::Legends.Effects.remove(this, ::Legends.Effect.LegendValaCurrentlyChanting);
        ::Legends.Effects.remove(this, ::Legends.Effect.LegendValaInTrance);
	}

	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();
		if (this.m.TurnsLeft != 0)
		{
			_properties.IsStunned = true;
			actor.setActionPoints(0);

			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").setBrush(this.Const.Combat.StunnedBrush);
				actor.getSprite("status_stunned").Visible = true;
			}

			actor.setDirty(true);
		}
		else
		{
			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").Visible = false;
			}

			actor.setDirty(true);
		}

		_properties.MeleeDefenseMult *= 0.75;
		_properties.InitiativeMult *= 0.75;
	}
});