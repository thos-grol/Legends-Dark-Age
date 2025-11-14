// This file defines static functions involving travel

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

::Z.T.Event <- {}; // event logic namespace
::Z.T.Event.Stack <- []; //contains a list of event ids

::Z.T.Event.build_stack <- function () 
{
    //#0004 - travel - create event stack.
    // Can be used before travel to set stack of events to iterate
	for(local i = 0; i < ::Z.T.Travel.Days; i++ )
	{
		::Z.T.Event.Stack.append("event.travel.resolve");
		//FEATURE_1: add combat event
		//FEATURE_1: final roll encounters, events. create "roll table using msu"
	}
}

::Z.T.Event.build_stack_day <- function () 
{
	::Z.T.Event.Stack.append("event.travel.resolve");
}

::Z.T.Event.iterate_stack <- function () 
{
	//pops and fire event stack as long as there is still anything inside
    if (::Z.T.Event.Stack.len() > 0)
	{
		this.Time.scheduleEvent(this.TimeUnit.Real, 50, function ( _tag )
		{
			if (::World.Events.canFireEvent(true, true))
			{
				local event_id = ::Z.T.Event.Stack.pop();
				local event = ::World.Events.getEvent(event_id);
				::World.Events.fireEvent(event)
			}
		}, null);
	}
}

// =========================================================================================
// Main
// =========================================================================================


// =========================================================================================
// Helper
// =========================================================================================
