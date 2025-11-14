::mods_hookExactClass("states/world_state", function(o) {

	//calls the ui to confirm fast travel
	o.ask_travel <- function()
	{
		::Z.Screen.Fast_Travel.ask_travel();
	}

	//event manager calls this function to tp
	o.do_travel <- function()
	{
		local entity = ::Z.S.get_settlement_from_name(::Z.T.Travel.ID);
		::Z.S.do_travel(entity);
		::Z.T.Travel.reset();
	}

	// modifies mouse input on world screen
	// this function is modified heavily, removing alot of uneeded logic
	// we don't move around by clicking anymore or start combat from the map screen
	o.onMouseInput = function( _mouse )
	{
		if (::MSU.Key.isKnownMouse(_mouse) && ::MSU.System.Keybinds.onMouseInput(_mouse, this, ::MSU.Key.State.World)) return false;
		
		if (this.isInLoadingScreen()) return true;
		local mouseMoved = _mouse.getID() == 6;
		if (mouseMoved) this.Cursor.setPosition(_mouse.getX(), _mouse.getY());
		if (this.m.MenuStack.hasBacksteps()) return false;
		

		if (_mouse.getID() == 7)
		{
			if (_mouse.getState() == 3)
			{
				::World.getCamera().zoomBy(-this.Time.getDelta() * ::Math.max(60, this.Time.getFPS()) * 0.3);
				return true;
			}
			else if (_mouse.getState() == 4)
			{
				::World.getCamera().zoomBy(this.Time.getDelta() * ::Math.max(60, this.Time.getFPS()) * 0.3);
				return true;
			}
		}

		if (mouseMoved) this.updateCursorAndTooltip();
		this.updateCamera(_mouse);

		if (_mouse.getState() == 1 && !this.isInCameraMovementMode() && !this.m.WasInCameraMovementMode)
		{
			local dest = ::World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY());
			local destTile = ::World.worldToTile(dest);
			local forceAttack = this.m.IsForcingAttack && ::World.Contracts.getActiveContract() == null;
			this.m.AutoEnterLocation = null;
			this.m.AutoAttack = null;
			this.m.LastAutoAttackPath = 0.0;

			local entities = ::World.getAllEntitiesAndOneLocationAtPos(::World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY()), 1.0);

			
			local closest_settlement = ::Z.S.get_settlement_closest();
			foreach( entity in entities )
			{
				if (entity == closest_settlement)
				{
					this.m.AutoEnterLocation = null;
					this.m.LastEnteredTown = this.WeakTableRef(entity);
					// this.m.LastEnteredLocation = this.WeakTableRef(entity);
					this.showTownScreen();
					break
				}
				if (entity.getID() == this.m.Player.getID()) continue;
				if (!closest_settlement.isConnectedToByRoads(entity)) continue;
				local distance = ::Z.S.get_distance_by_road(closest_settlement.getTile(), entity.getTile());
				local days = ::Z.S.get_distance_by_road_days(distance, ::Const.World.MovementSettings.Speed * 0.6, true);

				if (days > 1.1) continue;
				
				//prep variables for fast travel
				::Z.T.Travel.Days <- ::Math.round(days);
				::Z.T.Travel.ID <- entity.getName();
				this.ask_travel();
				break
			}

		}

		return false;
	}

});