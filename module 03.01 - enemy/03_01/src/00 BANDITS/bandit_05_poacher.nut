::mods_hookExactClass("entity/tactical/enemies/legend_bandit_poacher", function (o)
{
	o.create <- function()
	{
		this.m.Type = this.Const.EntityType.BanditPoacher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}

		this.m.Name = "Poacher"
	}

	o.onInit <- function()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (::Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = ::Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
		// ::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		// ::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		// if (::Legends.isLegendaryDifficulty())
		// 	{
		// 	::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
		// 	::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		// 	this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		// 	}

	}

	o.onAppearanceChanged <- function( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	o.assignRandomEquipment <- function()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
	}
});
