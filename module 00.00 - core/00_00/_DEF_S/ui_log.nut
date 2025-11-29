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

::Z.S.log_skill <- function(info)
{
    // local _info = {
    //     User = _user,
    //     Target = _targetEntity,
    //     Name = getName(),

    //     Roll = r,
    //     Chance = 0,
    //     GrazeBand = graze_band,
    //     HitResult = hit_result,
    //     ResultType = ...,

    //     IsUsingHitchance = is_using_hitchance,
    //     Astray = astray,
    // };

    // if there is a new entity acting, we want to add line breaks
    local ret = "";
    if (::Z.T.last_name != info.User.getName())
    {
        ::Z.T.last_name = info.User.getName();
        ret = "\n";
    }
    ret += ::Z.S.log_target_info(info.User, info.Target, info.Name, info.HitResult); // user [skill] target
    if ("Astray" in info && info.Astray)
    {
        ret += "[ASTRAY]"
    }
    ret += info.IsUsingHitchance ? ::Z.S.log_result(info) : ""; // shows hit miss roll or graze band roll

    ::Tactical.EventLog.logEx(ret);
}

::Z.S.log_damage_armor <- function(_targetEntity, _target, _cur, _prev, _damage, _is_innate=false)
{
    ::Z.T.Log.Turn_Has_Acted <- true;

    if (typeof _target != "string")
    {
        if (_is_innate) _target = _target == this.Const.BodyPart.Head ? "Head" : "Body";
        else _target = "?";
    }
    
    local target = " [" + ::MSU.String.capitalizeFirst( _target );
    if (_is_innate) target += " (INNATE ARMOR)";
    target += "] ";

    local damage = " ([b]" + ::bloodred(_damage) + "[/b])";

    ::Tactical.EventLog.logIn(::color_name(_targetEntity) + target + "» " + ::bloodred(_prev) + " › " + ::bloodred(_cur) + damage);
};

::Z.S.log_damage_flesh <- function(_targetEntity, _target, _cur, _prev, _damage)
{
    ::Z.T.Log.Turn_Has_Acted <- true;

    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local target = " [" + ::MSU.String.capitalizeFirst( _target ) + "] ";
    local hp_current = ::bloodred(_cur);
    local hp_previous = ::bloodred(_prev);
    local damage = " ([b]" + ::bloodred(_damage) + "[/b])";

    ::Tactical.EventLog.logIn(entity + target + "» " + hp_previous + " › " + hp_current + damage);
};

::Z.S.log_status <- function(_targetEntity, _string)
{
    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local status = ::bloodred(" is " + _string);
    ::Tactical.EventLog.logIn(entity + status);
};

::Z.S.log_injury <- function(_targetEntity, _injury)
{
    local entity = ::Const.UI.getColorizedEntityName(_targetEntity);
    local injury = ::bloodred(_injury);
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

::Z.S.log_skill_nine_lives <- function(_targetEntity)
{
    local entity = "[" + ::Const.UI.getColorizedEntityName(_targetEntity) + "]";
    local skill_text = "[" + ::red("Nine Lives") + "]"
    ::Tactical.EventLog.logIn(entity + " triggers " + skill_text);
};

// =========================================================================================
// Main 3 - Unimplemented Minor fns //FIXME: log - audit and implement whole section
// =========================================================================================



::Z.S.log_hair_armor <- function()
{
    ::Tactical.EventLog.logIn("[" + ::red("Hair Armor") + "] nullified direct damage.");
};



::Z.S.log_next_round <- function(_turn)
{
    ::Tactical.EventLog.logTi("\n\nROUND " + _turn + "\n\n");
};

::Z.S.log_kill <- function(_targetEntity)
{
    ::Tactical.EventLog.logIn(
        ::Const.UI.getColorizedEntityName(_targetEntity) + ::bloodred(" KILLED")
    );
};


// =========================================================================================
// Helper 
// =========================================================================================

::Z.S.log_target_info <- function(_user, _target, _skill_name, _result)
{
    // user [skill] target
    ::Z.T.Log.Turn_Has_Acted <- true;

    local ret = ::color_name(_user) + " " + ::color(::Color.hit_result[_result], "[" + _skill_name + "]");
    if (_target != null) ret += " " + ::color_name(_target);

    return ret;
}

::Z.S.log_result <- function(info)
{
    // local _info = {
    //     User = _user,
    //     TargetEntity = _targetEntity,
    //     Name = getName(),

    //     Roll = r,
    //     Chance = 0,
    //     GrazeBand = graze_band,
    //     HitResult = hit_result,
    //     ResultType = ...,

    //     IsUsingHitchance = is_using_hitchance,
    //     Astray = astray,
    // };
    switch (info.ResultType) {
        case RESULT_TYPE.HIT_MISS:
            local result = ::color(::Color.hit_result[info.HitResult], "" + info.Roll);
            return " » (" + result + " < " + ::Math.min(100, ::Math.max(0, info.Chance))+ ")";
        case RESULT_TYPE.GRAZE_BAND:
            // { 0 | 45 | 100 } (60)
            local gb = info.GrazeBand;
            return " {" + ::nicered(""+gb[0]) + "|" 
                + ::niceyellow(""+::Math.min(100, gb[1])) + "|" 
                + ::nicegreen(""+::Math.min(100, gb[2])) + "} » (" 
                + ::color(::Color.hit_result[info.HitResult], "" + info.Roll) + ")";
    }

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