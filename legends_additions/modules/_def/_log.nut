::mods_hookExactClass("ui/screens/tactical/modules/topbar/tactical_screen_topbar_event_log", function (o)
{
	o.destroy = function(){}
	o.log_newline = function(){}
	o.log = function( _text ) { this.m.JSHandle.asyncCall("log", _text); }
	o.logIn <- function( _text ) { this.m.JSHandle.asyncCall("log_indent", _text); }
    o.logTi <- function( _text ) { this.m.JSHandle.asyncCall("log_title", _text); }
});

// function getColorizedEntityName( _entity )
// 	{
// 		if (_entity.isPlayerControlled() || _entity.getFaction() == ::Const.Faction.PlayerAnimals)
// 		{
// 			return "[color=#1e468f]" + _entity.getName() + "[/color]";
// 		}
// 		else
// 		{
// 			return "[color=#8f1e1e]" + _entity.getName() + "[/color]";
// 		}
// 	}

//HELPER FNS

::Z.Log.display_basic <- function(_user, _targetEntity, _skill_name, is_good)
{
    return ::Const.UI.getColorizedEntityName(_user) + " "
    + ( ::MSU.Text.color((is_good ? ::Z.Log.Color.NiceGreen : ::Z.Log.Color.BloodRed), "[" + _skill_name + "]") )
    + (_targetEntity != null ? " " + ::Const.UI.getColorizedEntityName(_targetEntity): "");
}

::Z.Log.display_result <- function(_result_string, is_good)
{
    return ::MSU.Text.color((is_good ? ::Z.Log.Color.NiceGreen : ::Z.Log.Color.BloodRed), " " + "[" + _result_string + "]" + " ");
}

::Z.Log.display_chance <- function(rolled, toHit)
{
    return " » (" + rolled + " < " + ::Math.min(95, ::Math.max(5, toHit))+ ")";
}

//FNS

::Z.Log.next_round <- function(_turn)
{
    ::Tactical.EventLog.logTi("\n\nROUND " + _turn + "\n\n");
};

::Z.Log.next_turn <- function()
{
    if (::Z.Log.HasActed)
    {
        ::Tactical.EventLog.logEx("\n");
        ::Z.Log.HasActed = false;
    }
};

::Z.Log.skill <- function(_user, _targetEntity, _skill_name, rolled, toHit, _result_string, is_good=true, is_showing_chance=true)
{
    ::Tactical.EventLog.logEx(
        ::Z.Log.display_basic(_user, _targetEntity, _skill_name, is_good)
        + (is_showing_chance ? ::Z.Log.display_chance(rolled, toHit) : "")
    );
    ::Z.Log.HasActed = true;
};

::Z.Log.damage_armor <- function(_targetEntity, _target, _cur, _prev, _damage)
{
    ::Tactical.EventLog.logIn(
        ::Const.UI.getColorizedEntityName(_targetEntity) + " "
        + "[" + _target + "]"
        + " » " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _prev) + " › " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _cur)
        + " ([b]" + ::MSU.Text.color(::Z.Log.Color.BloodRed, _damage) + "[/b])"
    );
    ::Z.Log.HasActed = true;
};

::Z.Log.damage_body <- function(_targetEntity, _target, _cur, _prev, _damage)
{
    ::Tactical.EventLog.logIn(
       ::Const.UI.getColorizedEntityName(_targetEntity) + " "
        + "[" + ::MSU.String.capitalizeFirst( _target ) + "]"
        + " » " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _prev) + " › " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _cur)
        + " ([b]" + ::MSU.Text.color(::Z.Log.Color.BloodRed, _damage) + "[/b])");
    ::Z.Log.HasActed = true;
};

::Z.Log.kill <- function(_targetEntity)
{
    ::Tactical.EventLog.logIn(
        ::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.color(::Z.Log.Color.BloodRed, " KILLED")
    );
};

::Z.Log.status <- function(_targetEntity, _string)
{
    ::Tactical.EventLog.logIn(
        ::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.color(::Z.Log.Color.BloodRed, " is " + _string)
    );
};




::Z.Log.suffer_injury <- function(_targetEntity, _injury)
{
    ::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " suffers " + ::MSU.Text.color(::Z.Log.Color.BloodRed,  _injury ) );
};

::Z.Log.hair_armor <- function()
{
    ::Tactical.EventLog.logIn("[" + ::MSU.Text.colorRed("Hair Armor") + "] nullified direct damage.");
};

::Z.Log.nine_lives <- function(_targetEntity)
{
    ::Tactical.EventLog.logIn("[" + ::Const.UI.getColorizedEntityName(_targetEntity) + "] triggers [" + ::MSU.Text.colorRed("Nine Lives") + "]");
};