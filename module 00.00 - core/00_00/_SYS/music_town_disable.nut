// hk purpose
// - fixes music restarting when open/closing town screen
::mods_hookExactClass("states/world_state", function(o) {
	o.showTownScreen = function()
	{
		if (this.m.MenuStack.hasBacksteps()) return;
		if (this.m.LastEnteredTown == null) return;
		

		this.m.CustomZoom = ::World.getCamera().Zoom;
		::World.getCamera().zoomTo(1.0, 4.0);
		::World.getCamera().moveTo(this.m.LastEnteredTown);

		// hk
		// - fixes music restarting when open/closing town screen
		// this.Music.setTrackList(this.m.LastEnteredTown.getMusic(), ::Const.Music.CrossFadeTime); // we commented this out

		// hk end
		
		this.setAutoPause(true);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.WorldTownScreen.setTown(this.m.LastEnteredTown);
		this.m.WorldTownScreen.show();
		this.Cursor.setCursor(::Const.UI.Cursor.Hand);
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), ::Const.Sound.Volume.Ambience * ::Const.Sound.Volume.AmbienceTerrainInSettlement, ::World.getTime().IsDaytime ? ::Const.Sound.AmbienceMinDelay : ::Const.Sound.AmbienceMinDelayAtNight);
		this.Sound.setAmbience(1, this.m.LastEnteredTown.getSounds(), ::Const.Sound.Volume.Ambience * ::Const.Sound.Volume.AmbienceInSettlement, ::World.getTime().IsDaytime ? ::Const.Sound.AmbienceMinDelay : ::Const.Sound.AmbienceMinDelayAtNight);

		if (::World.Assets.isIronman()) ::World.presave();
		this.m.MenuStack.push(function ()
		{
			if (this.m.LastEnteredTown != null)
			{
				this.m.LastEnteredTown.onLeave();
				this.m.LastEnteredTown = null;
			}

			if (this.m.CombatStartTime == 0)
			{
				this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), ::Const.Sound.Volume.Ambience * ::Const.Sound.Volume.AmbienceTerrain, ::World.getTime().IsDaytime ? ::Const.Sound.AmbienceMinDelay : ::Const.Sound.AmbienceMinDelayAtNight);
				this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), ::Const.Sound.Volume.Ambience * ::Const.Sound.Volume.AmbienceOutsideSettlement, ::Const.Sound.AmbienceOutsideDelay);
			}

			::World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			::World.Assets.consumeItems();
			::World.Assets.refillAmmo();
			::World.Assets.updateAchievements();
			::World.Assets.checkAmbitionItems();
			::World.Ambitions.updateUI();
			::World.Ambitions.resetTime(false, 3.0);
			this.updateTopbarAssets();
			::World.State.getPlayer().updateStrength();
			this.m.WorldTownScreen.clear();
			this.m.WorldTownScreen.hide();
			this.m.WorldScreen.show();

			if (::World.Assets.isIronman() && this.m.CombatStartTime == 0) this.autosave();

			this.Cursor.setCursor(::Const.UI.Cursor.Hand);
			this.m.IsForcingAttack = false;
			this.setAutoPause(true);
			this.m.AutoUnpauseFrame = this.Time.getFrame() + 1;
		}, function ()
		{
			return !this.m.WorldTownScreen.isAnimating();
		});
	}

});
