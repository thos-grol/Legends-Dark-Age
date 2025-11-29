// this hooks all descendants of the shield class
::m.hookTree("scripts/items/shields/shield", function(q) {
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
            info = ::DEF.C.Shields[this.m.ID];
        }
        catch(exception) { return; }
        try 
        {
            this.m.MeleeDefense = info.MeleeDefense;
        }
        catch(exception) {}
        try 
        {
            this.m.ShieldwallAP = info.ShieldwallAP;
        }
        catch(exception) {}

        this.m.RangedDefense = 0;
	}
});