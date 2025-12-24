this.c_system <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.class_system";
		this.m.Name = "Class System";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
		this.m.Description = "";
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local f = actor.getFlags();

		if (!actor.isPlayerControlled()) return;
		if (!f.has("Level Updated To")) return;

		local c = null;
		if (f.has("Class")) c = f.get("Class");
		if (c == null) return;

		// get class stat table
		local class_stats = ::DEF.C.Stats.Class[c];

		//set fat recovery because it's not serialized
		_properties.FatigueRecoveryRate += class_stats["Recovery"][actor.m.Level];
	}
	
});

