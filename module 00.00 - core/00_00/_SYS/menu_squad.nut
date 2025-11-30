::mods_hookExactClass("states/world_state", function(o)
{
	// squad logic
	o.m.squad_state <- [ // 
		SQUAD_STATE.FREE, // 1
		SQUAD_STATE.FREE, // 2
		SQUAD_STATE.FREE, // 3
		SQUAD_STATE.FREE, // 4
		SQUAD_STATE.FREE, // 5
		SQUAD_STATE.FREE, // 6
		SQUAD_STATE.FREE, // 7
		SQUAD_STATE.FREE, // 8
		SQUAD_STATE.FREE, // 9
		SQUAD_STATE.FREE, // 10
	];

	o.get_squad_states <- function() 
	{ 
		return this.m.squad_state; 
	}
	o.set_squad_state <- function( squad_index, state ) 
	{ 
		this.m.squad_state[squad_index] = state; 
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize(_out);
		for(local i = 0; i < this.m.squad_state.len(); i++ )
		{
			_out.writeU8(this.m.squad_state[i]);
		}
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		for(local i = 0; i < this.m.squad_state.len(); i++ )
		{
			this.m.squad_state[i] = _in.readU8();
		}
	}
	
	// setup logic

	o.m.SquadScreen <- null;
	local onInitUI = o.onInitUI;
	o.onInitUI = function()
	{
		onInitUI();

		this.m.SquadScreen = ::Z.squad_screen;
		this.m.SquadScreen.setOnCloseButtonClickedListener(this.character_screen_onClosePressed.bindenv(this));
		this.m.SquadScreen.setStashMode();
		// ::MSU.Mod.Keybinds.addSQKeybind("open_squad_screen", "k", ::MSU.Key.State.World, this.showCharacterScreen);
	}

	local onDestroyUI = o.onDestroyUI;
	o.onDestroyUI = function()
	{
		onDestroyUI();
		this.m.SquadScreen = null;
	}

	o.isInCharacterScreen <- function()
	{
		if (this.m.CharacterScreen != null && 
			(this.m.CharacterScreen.isVisible() || this.m.CharacterScreen.isAnimating())) return true;
		if (this.m.SquadScreen != null && 
			(this.m.SquadScreen.isVisible() || this.m.SquadScreen.isAnimating())) return true;
		return false;
	}

	o.showCharacterScreen <- function()
	{
		if (!this.m.SquadScreen.isVisible() && !this.m.SquadScreen.isAnimating())
		{
			this.m.CustomZoom = this.World.getCamera().Zoom;
			this.World.getCamera().zoomTo(1.0, 4.0);
			this.World.Assets.updateFormation();
			this.setAutoPause(true);
			this.m.SquadScreen.show();
			this.m.WorldScreen.hide();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.MenuStack.push(function ()
			{
				this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
				this.m.SquadScreen.hide();
				this.m.WorldScreen.show();
				this.World.Assets.refillAmmo();
				this.updateTopbarAssets();
				this.setAutoPause(false);
			}, function ()
			{
				return !this.m.SquadScreen.isAnimating();
			});
		}
	}

	o.showCharacterScreenFromTown = function()
	{
		this.World.Assets.updateFormation();
		this.m.WorldTownScreen.hideAllDialogs();
		this.m.SquadScreen.show();
		this.m.MenuStack.push(function ()
		{
			this.m.SquadScreen.hide();
			this.m.WorldTownScreen.showLastActiveDialog();
		}, function ()
		{
			return !this.m.SquadScreen.isAnimating();
		});
	}

	o.toggleCharacterScreen = function()
	{
		if (this.m.SquadScreen.isVisible())
		{
			this.character_screen_onClosePressed();
		}
		else if (this.m.WorldTownScreen.isVisible())
		{
			this.showCharacterScreenFromTown();
		}
		else
		{
			this.showCharacterScreen();
		}
	}

	o.helper_handleCharacterScreenKeyInput = function( _key )
	{
		switch(_key.getKey())
		{
		case 11:
		case 48:
			this.m.SquadScreen.switchToPreviousBrother();
			break;

		case 38:
		case 14:
		case 50:
			this.m.SquadScreen.switchToNextBrother();
			break;

		case 19:
		case 13:
		case 41:
			this.toggleCharacterScreen();
			break;
		}
	}

	o.helper_handleContextualKeyInput = function ( _key )
	{
		if (this.isInLoadingScreen())
		{
			return true;
		}

		if (this.m.IsDeveloperModeEnabled && this.helper_handleDeveloperKeyInput(_key))
		{
			return true;
		}

		if (this.isInCharacterScreen() && _key.getState() == 0)
		{
			this.helper_handleCharacterScreenKeyInput(_key);
			return true;
		}

		if (this.m.CampfireScreen != null && this.m.CampfireScreen.isVisible() && _key.getState() == 0)
		{
			this.helper_handleCampfireScreenKeyInput(_key);
		}
		else if (_key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
				if (this.m.WorldMenuScreen.isAnimating())
				{
					return false;
				}

				if (this.toggleMenuScreen())
				{
					return true;
				}

				break;

			case 13:
			case 19:
				if (!this.m.MenuStack.hasBacksteps() || this.m.SquadScreen.isVisible() || this.m.WorldTownScreen.isVisible() && !this.m.EventScreen.isVisible())
				{
					if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
					{
						this.toggleCharacterScreen();
					}

					return true;
				}

				break;

			case 28:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onRelationsButtonClicked();
				}
				else if (this.m.RelationsScreen.isVisible())
				{
					this.m.RelationsScreen.onClose();
				}

				break;

			case 25:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onObituaryButtonClicked();
				}
				else if (this.m.ObituaryScreen.isVisible())
				{
					this.m.ObituaryScreen.onClose();
				}

				break;

			case 30:
				if (!this.m.MenuStack.hasBacksteps())
				{
					if (this.isCampingAllowed())
					{
						this.onCamp();
					}
				}

				break;

			case 26:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onPerksButtonClicked();
				}

				break;

			case 42:
			case 40:
			case 10:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setPause(!this.isPaused());
					return true;
				}

				break;

			case 1:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setNormalTime();
					break;
				}

				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.EventScreen.isJustShown())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(0);
				return true;

			case 2:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setFastTime();
					break;
				}

				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.EventScreen.isJustShown())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(1);
				return true;

			case 3:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.EventScreen.isJustShown())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(2);
				return true;

			case 4:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.EventScreen.isJustShown())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(3);
				return true;

			case 5:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.EventScreen.isJustShown())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(4);
				return true;

			case 6:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.EventScreen.isJustShown())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(5);
				return true;

			case 16:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onTrackingButtonPressed();
					return true;
				}

				break;

			case 34:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
				}

				break;

			case 75:
				if (!this.m.MenuStack.hasBacksteps() && !this.World.Assets.isIronman())
				{
					this.saveCampaign("quicksave");
				}

				break;

			case 79:
				if (!this.m.MenuStack.hasBacksteps() && !this.World.Assets.isIronman() && this.World.canLoad("quicksave"))
				{
					this.loadCampaign("quicksave");
				}

				break;

			case 14:
				if ((_key.getModifier() & 2) != 0 && this.m.IsAllowingDeveloperMode)
				{
					this.m.IsDeveloperModeEnabled = !this.m.IsDeveloperModeEnabled;

					if (this.m.IsDeveloperModeEnabled)
					{
						this.logDebug("*** DEVELOPER MODE ENABLED ***");
					}
					else
					{
						this.logDebug("*** DEVELOPER MODE DISABLED ***");
					}
				}

				break;

			case 95:
				this.m.IsForcingAttack = false;
				return true;
			}
		}

		if (_key.getState() == 1 && !this.m.MenuStack.hasBacksteps())
		{
			switch(_key.getKey())
			{
			case 11:
			case 27:
			case 48:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(-1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 14:
			case 50:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 33:
			case 36:
			case 49:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(0, 1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 29:
			case 51:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(0, -1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 67:
			case 46:
				this.World.getCamera().zoomBy(-this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 68:
			case 47:
				this.World.getCamera().zoomBy(this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 96:
			case 39:
				this.World.getCamera().Zoom = 1.0;
				this.World.getCamera().setPos(this.World.State.getPlayer().getPos());
				break;

			case 95:
				if (this.m.MenuStack.hasBacksteps())
				{
				}
				else
				{
					this.m.IsForcingAttack = true;
					return true;
				}
			}
		}
	}
	
});