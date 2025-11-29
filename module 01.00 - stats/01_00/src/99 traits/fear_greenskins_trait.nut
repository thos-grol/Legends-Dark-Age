::mods_hookExactClass("skills/traits/fear_greenskins_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.fear_greenskins";
		this.m.Name = "Fear of Greenskins";
		this.m.Icon = "ui/traits/trait_icon_49.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what greenskins are capable of, making this character less reliable when facing greenskins on the battlefield.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.hate_greenskins",
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
				text = ::red("– 20") + " Mettle when in battle with greenskins"
			}
		];
	}

	o.onUpdate <- function( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local fightingGreenskins = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (::Const.EntityType.getDefaultFaction(enemy.getType()) == ::Const.FactionType.Orcs || ::Const.EntityType.getDefaultFaction(enemy.getType()) == ::Const.FactionType.Goblins)
			{
				fightingGreenskins = true;
				break;
			}
		}

		if (fightingGreenskins)
		{
			_properties.Bravery -= 20;
		}
	}

});

//FEATURE_8: rework to upgrade to hatred after kill threshold has been met
// also nerf atk and def in regards to enemies fighting this character
// make this perk tiered like luck. on inital roll, 50% to become fear or hatred tiers