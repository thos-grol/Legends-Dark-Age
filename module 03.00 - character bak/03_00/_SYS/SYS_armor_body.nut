::mods_hookExactClass("items/legend_armor/legend_armor", function (o)
{
	o.onDamageReceived = function( _damage, _fatalityType, _attacker )
	{
		local totalDamage = _damage;
		for( local i = ::Const.Items.ArmorUpgrades.COUNT - 1; i >= 0; i = --i )
		{
			local u = this.m.Upgrades[i];
			if (u != null) totalDamage = u.onDamageReceived(totalDamage, _fatalityType, _attacker);
		}
		if (this.m.Condition == 0)
		{
			this.updateAppearance();
			return;
		}
		local prev_condition = this.m.Condition;
		this.m.Condition = ::Math.max(0, this.m.Condition - totalDamage) * 1.0;
		::Z.S.log_damage_armor(this.getContainer().getActor(), this.makeName(), this.m.Condition, prev_condition, _damage);

		if (this.m.Condition == 0 && !this.m.IsIndestructible && _attacker != null && _attacker.isPlayerControlled())
			this.Tactical.Entities.addArmorParts(this.getArmorMax());
		this.updateAppearance();
	}

	o.onUpdateProperties = function( _properties )
	{
		if (this.getContainer() == null) return;
		local actor = this.getContainer().getActor();
		if (actor == null) return;

		local staminaMult = 1.0;

		if (actor.getSkills().hasSkill("perk.brawny")) staminaMult *= 0.66;
		// if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_muscularity")) staminaMult *= 0.5;

		_properties.Armor[::Const.BodyPart.Body] += this.getArmor();
		_properties.ArmorMax[::Const.BodyPart.Body] += this.getArmorMax();
		_properties.Stamina += ::Math.ceil(this.getStaminaModifier() * staminaMult);
		this.doOnFunction("onUpdateProperties", [
			_properties
		]);
	}

});