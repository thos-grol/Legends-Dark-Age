this.bag_system <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.bag_system";
		this.m.Name = "Bag System";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;

		this.m.Description = "Logic for bag items";
	}


	// core for on hit passives
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) 
	{
		local actor = this.getContainer().getActor();
		local bag_items = actor.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);

		local poison_master = actor.getSkills().getSkillByID("perk.poison_master") != null;
		local poison_count = 0;

		foreach (item in bag_items)
		{
			switch(item.getID())
			{
				case "bag.oil_poison":
					if (!poison_master && poison_count > 0) break;

					::Z.S.apply_poison({
						_effect_def = ::Legends.Effect.SpiderPoison,
						_effect_level = 2,
						_effect_chance = 33,

						_SKILL = _skill,

						_actor = actor,
						_target = _targetEntity,

						_damage = _damageInflictedHitpoints
					});

					poison_count++;
				break;
				
			}
			
		}
	}
});

