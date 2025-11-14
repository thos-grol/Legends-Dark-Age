::mods_hookExactClass("entity/tactical/enemies/legend_bandit_rabble_poacher", function (o)
{
	o.create <- function()
	{
		this.m.Type = ::Const.EntityType.BanditRabblePoacher;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditRabble.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}

		this.m.Name = "Rabble"
	}

	o.assignRandomEquipment <- function()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
	}
});
