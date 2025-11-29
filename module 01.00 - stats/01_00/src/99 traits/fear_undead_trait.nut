::mods_hookExactClass("skills/traits/fear_undead_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fear_undead";
		this.m.Name = "Fear of Undead";
		this.m.Icon = "ui/traits/trait_icon_47.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what the walking dead are capable of, making this character less reliable when facing the undead on the battlefield.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.hate_undead",
			"trait.aggressive",
			"trait.pragmatic",
			"trait.ambitious",
			"trait.natural"
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
				icon = "ui/icons/bravery.png",
				text = ::red("– 20") + " Mettle when in battle with undead"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local fightingUndead = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (::Const.EntityType.getDefaultFaction(enemy.getType()) == ::Const.FactionType.Zombies || ::Const.EntityType.getDefaultFaction(enemy.getType()) == ::Const.FactionType.Undead)
			{
				fightingUndead = true;
				break;
			}
		}

		if (fightingUndead)
		{
			_properties.Bravery -= 20;
		}
	}

});

//FEATURE_8: rework to upgrade to hatred after kill threshold has been met
// also nerf atk and def in regards to enemies fighting this character
// make this perk tiered like luck. on inital roll, 50% to become fear or hatred tiers

//FEATURE_8: add a hatred for humans perk