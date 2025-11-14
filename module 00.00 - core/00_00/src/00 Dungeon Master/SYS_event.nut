//system - event chain
::mods_hookExactClass("events/event_manager", function(o)
{
	// #0004 - travel - hook event manager to use event id stack
	//we hook processInput to add logic to chain events
	o.processInput = function( _option )
	{
		if (this.m.ActiveEvent != null)
		{
			if (!this.m.ActiveEvent.processInput(_option) && this.m.ActiveEvent != null)
			{
				//vanilla code to cleanup event
				if (this.m.VictoryScreen == null && this.m.DefeatScreen == null)
				{
					this.m.LastEventID = this.m.ActiveEvent.getID();
					this.m.ActiveEvent.clear();
					this.m.ActiveEvent = null;
					this.m.ForceScreen = null;
				}

				this.m.IsEventShown = false;
				::World.State.getMenuStack().pop(true);
				
				// #0004 - travel - hook event manager to use eventid stack
				// after an event in the event stack resolves, we can pop and run the next
				if (::Z.T.Event.Stack.len() > 0)
				{
					::Z.T.Event.iterate_stack();
				}
			}
			else
			{
				::World.State.getEventScreen().show(this.m.ActiveEvent);
			}
		}
	}

	// function to fire event using the event itself, not the id
	// this is so we can perhaps add modifications before firing the event
	o.fireEvent <- function (_event) {
		if (_event != null && this.m.ActiveEvent != null && this.m.ActiveEvent.getID() != _event.getID()) {
			this.logInfo("Failed to fire event - another event with id \'" + this.m.ActiveEvent.getID() + "\' is already queued.");
			return false;
		}
		if (_event != null) {
			this.m.ActiveEvent = _event;
			this.m.ActiveEvent.fire();

			if (::World.State.showEventScreen(this.m.ActiveEvent)) {
				return true;
			} else {
				this.m.ActiveEvent.clear();
				this.m.ActiveEvent = null;
				return false;
			}
		} else {
			this.logInfo("Failed to fire event - with id \'" + _event.getID() + "\' not found.");
			return false;
		}
	}
});
