// this hooks all descendants of the weapon class
::m.hookTree("scripts/items/weapons/weapon", function(q) {
    q.create = @(__original) function() {
		__original();
        // if ("ID" in this.m && this.m.ID in ::DEF.C.Weapons)
        // {
        //     local info = ::DEF.C.Weapons[this.m.ID];
        //     this.m.StaminaModifier = info.StaminaModifier;
        //     this.m.RegularDamage = info.RegularDamage;
        //     this.m.RegularDamageMax = info.RegularDamageMax;
        //     this.m.ArmorDamageMult = info.ArmorDamageMult;
        //     this.m.DirectDamageMult = info.DirectDamageMult;

        //     ::logInfo(this.m.ID);
        //     ::logInfo(info.RegularDamage);
        // }

        local info;

        try 
        {
            info = ::DEF.C.Weapons[this.m.ID];
        }
        catch(exception) { return; }

        try 
        {
            this.m.StaminaModifier = info.StaminaModifier;
        }
        catch(exception) {}
        try 
        {
            this.m.RegularDamage = info.RegularDamage;
        }
        catch(exception) {}
        try 
        {
            this.m.RegularDamageMax = info.RegularDamageMax;
        }
        catch(exception) {}
        try 
        {
            this.m.ArmorDamageMult = info.ArmorDamageMult;
        }
        catch(exception) {}
        try 
        {
            this.m.DirectDamageMult = info.DirectDamageMult;
        }
        catch(exception) {}

        ::logInfo(this.m.ID);
        ::logInfo(info.RegularDamage);
	}
});