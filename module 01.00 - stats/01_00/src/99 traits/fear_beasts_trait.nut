::mods_hookExactClass("skills/traits/fear_beasts_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fear_beasts";
		this.m.Name = "Fear of Beasts";
		this.m.Icon = "ui/traits/trait_icon_48.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what the monstrous beasts of the wild are capable of, making this character less reliable when facing beasts on the battlefield.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.hate_beasts",
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
				text = ::red("– 20") + " Mettle when in battle with beasts"
			},
		];
	}

	o.onUpdate <- function( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local fightingBeasts = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (::Const.EntityType.getDefaultFaction(enemy.getType()) == ::Const.FactionType.Beasts || enemy.getType() == ::Const.EntityType.BarbarianUnhold || enemy.getType() == ::Const.EntityType.BarbarianUnholdFrost)
			{
				fightingBeasts = true;
				break;
			}
		}

		if (fightingBeasts)
		{
			_properties.Bravery -= 20;
		}
	}

});

//FEATURE_8: rework to upgrade to hatred after kill threshold has been met
// also nerf atk and def in regards to enemies fighting this character
// make this perk tiered like luck. on inital roll, 50% to become fear or hatred tiers