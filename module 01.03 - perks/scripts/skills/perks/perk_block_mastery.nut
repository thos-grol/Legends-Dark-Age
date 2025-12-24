this.perk_block_mastery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.block_mastery";
		this.m.Name = ::Const.Strings.PerkName.BlockMastery;
		this.m.Description = ::Const.Strings.PerkDescription.BlockMastery;
		this.m.Icon = "ui/perks/block_mastery.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.BlockMastery = true;
	}
});