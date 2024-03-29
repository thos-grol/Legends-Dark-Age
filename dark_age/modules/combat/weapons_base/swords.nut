::mods_hookExactClass("items/weapons/oriental/saif", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/scimitar", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/named/named_shamshir", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/shamshir", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/named/named_shamshir", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/oriental/qatal_dagger", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Sword | ::Const.Items.WeaponType.Dagger;
	}
});

::mods_hookExactClass("items/weapons/named/named_qatal_dagger", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Sword | ::Const.Items.WeaponType.Dagger;
	}
});

::mods_hookExactClass("items/weapons/oriental/two_handed_scimitar", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Sword | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/named/named_two_handed_scimitar", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Sword;
	}
});

::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Sword;
	}
});
