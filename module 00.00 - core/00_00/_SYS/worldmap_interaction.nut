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
			local entities = ::World.getAllEntitiesAndOneLocationAtPos(dest, 1.0);
			if (entities.len() <= 0) return false;
			
			local destTile = ::World.worldToTile(dest);
			local forceAttack = this.m.IsForcingAttack && ::World.Contracts.getActiveContract() == null;
			this.m.AutoEnterLocation = null;
			this.m.AutoAttack = null;
			this.m.LastAutoAttackPath = 0.0;

			// local closest_settlement = ::Z.S.get_settlement_closest();
			foreach( entity in entities )
			{
				::logInfo(entity.m.Name);
				if (entity.is_enterable())
				{
					this.m.AutoEnterLocation = null;
					this.m.LastEnteredTown = this.WeakTableRef(entity);
					// this.m.LastEnteredLocation = this.WeakTableRef(entity);
					this.showTownScreen();
					break
				}

				if (entity.is_contract_entity())
				{
					// contract is clicked so we want to open up the squad screen with data
					local contract = entity.get_contract();
					::Z.S.store_contract_info(contract);
					::World.State.showCharacterScreen();
					break
				}
				// if (entity.getID() == this.m.Player.getID()) continue;
				// if (!closest_settlement.isConnectedToByRoads(entity)) continue;
				// local distance = ::Z.S.get_distance_by_road(closest_settlement.getTile(), entity.getTile());
				// local days = ::Z.S.get_distance_by_road_days(distance, ::Const.World.MovementSettings.Speed * 0.6, true);

				// if (days > 1.1) continue;
				
				// //prep variables for fast travel
				// ::Z.T.Travel.Days <- ::Math.round(days);
				// ::Z.T.Travel.ID <- entity.getName();
				// this.ask_travel();
				// break
			}

		}

		return false;
	}

	// o.updateCursorAndTooltip <- function()
	// {
	// 	if (this.m.MenuStack.hasBacksteps())
	// 	{
	// 		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
	// 		return;
	// 	}

	// 	local cursorX = this.Cursor.getX();
	// 	local cursorY = this.Cursor.getY();

	// 	if (this.Cursor.isOverUI())
	// 	{
	// 		if (this.m.LastEntityHovered != null || this.m.LastTileHovered != null)
	// 		{
	// 			this.Tooltip.mouseLeaveTile();
	// 			this.m.LastEntityHovered = null;
	// 			this.m.LastTileHovered = null;
	// 		}

	// 		if (!this.Cursor.wasOverUI())
	// 		{
	// 			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
	// 		}

	// 		return;
	// 	}

	// 	if ((this.m.LastEntityHovered != null || this.m.LastTileHovered != null) && this.isInCameraMovementMode())
	// 	{
	// 		this.m.LastEntityHovered = null;
	// 		this.m.LastTileHovered = null;
	// 		this.Tooltip.mouseLeaveTile();
	// 		return;
	// 	}

	// 	if (!this.isInCameraMovementMode())
	// 	{
	// 		local entity;
	// 		local entities = this.World.getAllEntitiesAndOneLocationAtPos(this.World.getCamera().screenToWorld(cursorX, cursorY), 1.0);

	// 		if (entities.len() > 0)
	// 		{
	// 			foreach( e in entities )
	// 			{
	// 				::logInfo(e.getName());
	// 			}
	// 		}

	// 		foreach( e in entities )
	// 		{
	// 			if (e.getID() == this.m.Player.getID())
	// 			{
	// 				continue;
	// 			}

	// 			if (!e.isDiscovered())
	// 			{
	// 				continue;
	// 			}

	// 			if (e.isParty() && e.isHiddenToPlayer())
	// 			{
	// 				continue;
	// 			}

	// 			entity = e;
	// 			break;
	// 		}

	// 		if (entity != null)
	// 		{
	// 			this.m.LastTileHovered = null;

	// 			if (this.m.LastEntityHovered == null || this.m.LastEntityHovered.getID() != entity.getID())
	// 			{
	// 				this.m.LastEntityHovered = entity;
	// 				this.Tooltip.mouseLeaveTile();
	// 				this.Tooltip.mouseEnterTile(cursorX, cursorY, this.m.LastEntityHovered.getID());

					
	// 			}
	// 			else
	// 			{
	// 				this.Tooltip.mouseHoverTile(cursorX, cursorY);
	// 			}

	// 			if (entity.isParty())
	// 			{
	// 				if (entity.isPlayerControlled() || entity.isAlliedWith(this.World.getPlayerEntity()))
	// 				{
	// 					if (this.m.IsForcingAttack && this.World.Contracts.getActiveContract() == null)
	// 					{
	// 						this.Cursor.setCursor(this.Const.UI.Cursor.Attack);
	// 					}
	// 					else
	// 					{
	// 						this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
	// 					}
	// 				}
	// 				else
	// 				{
	// 					this.Cursor.setCursor(this.Const.UI.Cursor.Attack);
	// 				}
	// 			}
	// 			else if (entity.isAttackable() && entity.getVisibilityMult() != 0 && !entity.isAlliedWithPlayer())
	// 			{
	// 				this.Cursor.setCursor(this.Const.UI.Cursor.Attack);
	// 			}
	// 			else if (entity.isLocationType(this.Const.World.LocationType.Settlement) && entity.isAlliedWithPlayer() || entity.isLocationType(this.Const.World.LocationType.Unique) && !entity.isVisited() || entity.getOnEnterCallback() != null)
	// 			{
	// 				this.Cursor.setCursor(this.Const.UI.Cursor.Enter);
	// 			}
	// 			else
	// 			{
	// 				this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
	// 			}

	// 			return;
	// 		}
	// 	}

	// 	if (this.m.LastEntityHovered != null)
	// 	{
	// 		this.m.LastEntityHovered = null;
	// 		this.Tooltip.mouseLeaveTile();
	// 	}

	// 	local tile = this.World.getTile(this.World.screenToTile(cursorX, cursorY));

	// 	if (tile != null && !this.isInCameraMovementMode())
	// 	{
	// 		this.m.LastEntityHovered = null;

	// 		if (this.m.LastTileHovered == null || !this.m.LastTileHovered.isSameTileAs(tile))
	// 		{
	// 			this.m.LastTileHovered = tile;
	// 			this.Tooltip.mouseLeaveTile();
	// 			this.Tooltip.mouseEnterTile(cursorX, cursorY);
	// 		}
	// 		else
	// 		{
	// 			this.Tooltip.mouseHoverTile(cursorX, cursorY);
	// 		}

	// 		this.Cursor.setCursor(this.Const.UI.Cursor.Boot);
	// 	}
	// }

});