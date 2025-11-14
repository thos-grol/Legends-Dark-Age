// hk purpose
// 
::mods_hookExactClass("entity/tactical/actor", function ( o ) {
    o.getDefense = function( _attackingEntity, _skill, _properties )
    {
        local malus = 0;
        local d = 0;
        local shield_defense = 0;
    
        if (!this.m.CurrentProperties.IsImmuneToSurrounding)
        {
            malus = _attackingEntity != null ? ::Math.max(0, _attackingEntity.getCurrentProperties().SurroundedBonus * _attackingEntity.getCurrentProperties().SurroundedBonusMult - this.getCurrentProperties().SurroundedDefense) * this.getSurroundedCount() : ::Math.max(0, 5 - this.getCurrentProperties().SurroundedDefense) * this.getSurroundedCount();
        }
    
        local shield = this.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
        if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield))
        {
            shield_defense = shield.getMeleeDefense() * (this.m.CurrentProperties.IsSpecializedInShields ? 1.25 : 1.0);
        }

        d = _properties.getMeleeDefense();
        if (!_skill.isShieldRelevant()) d = d - shield_defense;
        if (d > ::Const.Tactical.Settings.AttributeDefenseSoftCap)
        {
            local e = d - ::Const.Tactical.Settings.AttributeDefenseSoftCap;
            d = ::Const.Tactical.Settings.AttributeDefenseSoftCap + e * 0.5;
        }
    
        if (!_skill.isRanged()) d = d - malus;
        else d *= 0.75; 

        d = ::Math.round(d);
        return d;
    }
}); 