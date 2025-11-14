::mods_hookExactClass("entity/tactical/enemies/legend_bandit_rabble", function (o)
{
	o.create <- function()
	{
		this.m.Type = ::Const.EntityType.BanditRabble;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditRabble.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = ::Const.Faces.AllWhiteMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_rabble_agent");
		this.m.AIAgent.setActor(this);
		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}

		this.m.Name = "Rabble"
	}

	o.onInit <- function()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditRabble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (::Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (::Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (::Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.MeleeDefense += 5;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);
	}

	o.onAppearanceChanged <- function( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	o.makeMiniboss <- function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		// local weapons = [
		// 	"scripts/items/weapons/named/legend_named_blacksmith_hammer",
		// 	"scripts/items/weapons/named/legend_named_butchers_cleaver",
		// 	"scripts/items/weapons/named/legend_named_shovel",
		// 	"scripts/items/weapons/named/legend_named_sickle"
		// ];
		// this.m.Items.unequip(this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		// this.m.Items.equip(::new(weapons[::Math.rand(0, weapons.len() - 1)]));
	}
});
