::Const.Tactical.Actor.FreeCompanyArcher = {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 50,
	Stamina = 110,
	MeleeSkill = 55,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/free_company_archer", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyArcher);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	o.assignRandomEquipment = function()
	{
		local r = this.Math.rand(1, 100);

		if (r <= 95)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
		}

		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		this.m.Items.equip;
		this.free_company_abstract.assignRandomEquipment();
	}

});
