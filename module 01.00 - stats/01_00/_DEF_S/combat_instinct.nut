// This file defines static functions involving travel

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

::Z.T.Instinct <- {}; // event logic namespace
::Z.T.Instinct.None <- 0;
::Z.T.Instinct.Head <- 0;
::Z.T.Instinct.Body <- 0;

::Z.T.Instinct.RESULT <- 0;
::Z.T.Instinct.INJURIES_BODY <- null;

::Z.T.Instinct.reset <- function()
{
    ::Z.T.Instinct.RESULT <- 0;
    ::Z.T.Instinct.INJURIES_BODY <- null;
}

// =========================================================================================
// Main
// =========================================================================================

//This fn rolls damage reduction from the instinct stat
::Z.S.roll_instinct <- function ( _hitInfo, _p )
{
    if (::MSU.Math.randf(0.0, 100.00) > _p.getInstinct() * 0.5) return;
	
    if (_hitInfo.BodyPart == ::Const.BodyPart.Head) //downgrade hit head to body
    {
        _hitInfo.BodyPart = ::Const.BodyPart.Body;
        _hitInfo.BodyDamageMult = ::Const.BodyPart.Body;
        _hitInfo.Injuries = ::Z.T.Instinct.INJURIES_BODY;

        ::Z.T.Instinct.RESULT <- ::Z.T.Instinct.Head;
    }
    else //downgrade hit body to graze
    {
        // _hitInfo.DamageRegular *= 0.1;
        // _hitInfo.DamageArmor *= 0.1;
        _hitInfo.BodyDamageMult = 0.1;

        ::Z.T.Instinct.RESULT <- ::Z.T.Instinct.Body;
    }

	return;
}


// =========================================================================================
// Helper
// =========================================================================================
