//This file has logic for the improved combat log

// hk - hook log screen to add new sq fns
::mods_hookExactClass("ui/screens/tactical/modules/topbar/tactical_screen_topbar_event_log", function (o)
{
	o.destroy = function(){}
	o.log_newline = function(){}
	o.log = function( _text ) { this.m.JSHandle.asyncCall("log", _text); }
	o.logIn <- function( _text ) { this.m.JSHandle.asyncCall("log_indent", _text); }
    o.logTi <- function( _text ) { this.m.JSHandle.asyncCall("log_title", _text); }
});

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

::Z.T.Log <- {}; // event logic namespace
::Z.T.Log.Turn_Has_Acted <- false;

::Z.T.Log.reset_turn <- function()
{
    if (!::Z.T.Log.Turn_Has_Acted) return;
    ::Tactical.EventLog.logEx("\n");
    ::Z.T.Log.Turn_Has_Acted <- false;
};

::Z.T.last_name <- "";

::Z.T.Log.cd_obdr_msg <- false;
::Z.T.Log.cd_obdr_str <- "";

// =========================================================================================
// Main
// =========================================================================================

::Z.S.log_skill <- function(_user, _targetEntity, _skill_name, rolled, toHit, _result_string, _is_good=true, is_showing_chance=true)
{
    local start = "";
    if (::Z.T.last_name != _user.getName())
    {
        ::Z.T.last_name = _user.getName();
        start = "\n";
    }
    local skill_result = ::Z.S.log_skill_result(_user, _targetEntity, _skill_name, _is_good);
    local chance = (is_showing_chance ? ::Z.S.log_chance(rolled, toHit) : "");
    ::Tactical.EventLog.logEx(start + skill_result + chance);
};

::Z.S.log_damage_armor <- function(_targetEntity, _target, _cur, _prev, _damage, _is_natural=false)
{
    ::Z.T.Log.Turn_Has_Acted <- true;

    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local target = " [" + ::MSU.String.capitalizeFirst( _target );
    if (_is_natural) target += " (NATURAL ARMOR)";
    target += "] ";
    local ar_current = ::MSU.Text.color(::DEF.Color.BloodRed, _cur);
    local ar_previous = ::MSU.Text.color(::DEF.Color.BloodRed, _prev);
    local damage = " ([b]" + ::MSU.Text.color(::DEF.Color.BloodRed, _damage) + "[/b])";

    ::Tactical.EventLog.logIn(entity + target + "» " + ar_previous + " › " + ar_current + damage);
};

::Z.S.log_damage_flesh <- function(_targetEntity, _target, _cur, _prev, _damage)
{
    ::Z.T.Log.Turn_Has_Acted <- true;

    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local target = " [" + ::MSU.String.capitalizeFirst( _target ) + "] ";
    local hp_current = ::MSU.Text.color(::DEF.Color.BloodRed, _cur);
    local hp_previous = ::MSU.Text.color(::DEF.Color.BloodRed, _prev);
    local damage = " ([b]" + ::MSU.Text.color(::DEF.Color.BloodRed, _damage) + "[/b])";

    ::Tactical.EventLog.logIn(entity + target + "» " + hp_previous + " › " + hp_current + damage);
};

::Z.S.log_status <- function(_targetEntity, _string)
{
    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local status = ::MSU.Text.color(::DEF.Color.BloodRed, " is " + _string);
    ::Tactical.EventLog.logIn(entity + status);
};

::Z.S.log_injury <- function(_targetEntity, _injury)
{
    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local injury = ::MSU.Text.color(::DEF.Color.BloodRed, _injury);
    ::Tactical.EventLog.logIn(entity + " suffers " +  injury);
};

::Z.S.log_msg_in <- function(_targetEntity, _msg)
{
    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    ::Tactical.EventLog.logIn(entity + " " + _msg);
};

::Z.S.log_msg <- function(_targetEntity, _msg)
{
    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    ::Tactical.EventLog.logEx(entity + " " + _msg);
};

// =========================================================================================
// Main 2 - Minor fns
// =========================================================================================

::Z.S.log_instinct_trigger <- function()
{
    if (::Z.T.Instinct.RESULT == 0) 
    {
        // usually this means instinct calculation has completed
        ::Z.T.Instinct.reset();
        return;
    }

    ::Tactical.EventLog.logIn(
        ::MSU.Text.color(::DEF.Color.BloodRed, "INSTINCT TRIGGERED - ") + (::Z.T.Instinct.RESULT == 1 ? "Downgraded to body hit" : "Downgraded to graze (10% dmg)")
    );

    // usually this means instinct calculation has completed
    ::Z.T.Instinct.reset();
};

::Z.S.log_skill_nine_lives <- function(_targetEntity)
{
    local entity = "[" + ::Const.UI.getColorizedEntityName(_targetEntity) + "]";
    local skill_text = "[" + ::MSU.Text.colorRed("Nine Lives") + "]"
    ::Tactical.EventLog.logIn(entity + " triggers " + skill_text);
};

// =========================================================================================
// Main 3 - Unimplemented Minor fns //FIXME: log - audit and implement whole section
// =========================================================================================



::Z.S.log_hair_armor <- function()
{
    ::Tactical.EventLog.logIn("[" + ::MSU.Text.colorRed("Hair Armor") + "] nullified direct damage.");
};



::Z.S.log_next_round <- function(_turn)
{
    ::Tactical.EventLog.logTi("\n\nROUND " + _turn + "\n\n");
};

::Z.S.log_kill <- function(_targetEntity)
{
    ::Tactical.EventLog.logIn(
        ::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.color(::DEF.Color.BloodRed, " KILLED")
    );
};


// =========================================================================================
// Helper 
// =========================================================================================

::Z.S.log_skill_result <- function(_user, _targetEntity, _skill_name, _is_good)
{
    ::Z.T.Log.Turn_Has_Acted <- true;
    return ::Const.UI.getColorizedEntityName(_user) + " "
    + ( ::MSU.Text.color((_is_good ? ::DEF.Color.NiceGreen : ::DEF.Color.BloodRed), "[" + _skill_name + "]") )
    + (_targetEntity != null ? " " + ::Const.UI.getColorizedEntityName(_targetEntity): "");
}

::Z.S.log_chance <- function(rolled, toHit)
{
    local success = rolled <= toHit;
    local rolled_str = ::MSU.Text.color((success ? ::DEF.Color.NiceGreen : ::DEF.Color.BloodRed), "" + rolled);
    return " » (" + rolled_str + " < " + ::Math.min(95, ::Math.max(5, toHit))+ ")";
}

::Z.S.log_display_result <- function(_result_string, _is_good)
{
    return ::MSU.Text.color((_is_good ? ::DEF.Color.NiceGreen : ::DEF.Color.BloodRed), " " + "[" + _result_string + "]" + " ");
}

::Z.S.get_bodypart_name <- function(_hitInfo)
{
    return ::Const.Strings.BodyPartName[_hitInfo.BodyPart];
}


::Z.S.log_roundf <- function(val, decimalPoints=2)
{
    local f = ::Math.pow(10, decimalPoints) * 1.0;
    local newVal = val * f;
    newVal = ::Math.floor(newVal + 0.5)
    newVal = (newVal * 1.0) / f;
    return newVal;
}