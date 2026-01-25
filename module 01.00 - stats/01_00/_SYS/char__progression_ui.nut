// This file defines logic for character progression ui - storage, getters, and setters
::mods_hookExactClass("entity/tactical/player", function (o){

    // class button to assign class
    o.class_button_is_showing <- function()
    {
        // ::logInfo(
        //     "Name: " + this.m.Name + "\n" +
        //     "Class Added: " + this.getFlags().has("Class Added") + "\n"
        // );
        return !this.getFlags().has("Class Added") && this.m.Level > 1;
    }

    o.class_button_logic <- function()
    {
        ::Z.S.set_class_random(this);
    }

});

// where we send data to the ui
::mods_hookNewObjectOnce("ui/global/data_helper", function(o) {

    local addCharacterToUIData = o.addCharacterToUIData;
	o.addCharacterToUIData = function ( _entity, _target )
	{
		addCharacterToUIData(_entity, _target);
		_target.class_button_is_showing <- _entity.class_button_is_showing();
        _target.is_add_weapon_tree_button_enabled <- ::Z.S.is_add_weapon_tree_button_enabled( _entity );
	}

});

// ::mods_hookNewObjectOnce("ui/global/data_helper", function(o) {

//     local convertEntityToUIData = o.convertEntityToUIData;
// 	o.convertEntityToUIData = function ( _entity, _activeEntity )
// 	{
// 		local result = convertEntityToUIData(_entity, _activeEntity);

//         result.is_add_weapon_tree_button_enabled <- ::Z.S.is_add_weapon_tree_button_enabled( _entity );
// 		return result;
// 	}

// });