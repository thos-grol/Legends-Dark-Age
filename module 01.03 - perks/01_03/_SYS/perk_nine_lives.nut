::mods_hookExactClass("skills/perks/perk_nine_lives", function(o) {
	o.m.MinHP <- 11;
	o.m.MaxHP <- 15;

	o.m.timer_on <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IconMini = "perk_07_mini";
		this.m.Overlay = "perk_07";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.VeryLast + 10000;
	}

	o.setSpent <- function ( _f )
	{
		if (_f && !this.m.IsSpent)
		{
			this.m.IsHidden = true;
			if (this.m.MinHP != 11 || this.m.MaxHP != 15)
			{
				this.getContainer().getActor().m.Hitpoints = ::Math.rand(this.m.MinHP, this.m.MaxHP);
				this.getContainer().getActor().setDirty(true);
			}

		}

		// this.m.IsSpent = _f;
		this.m.timer_on = true;
		this.m.LastFrameUsed = this.Time.getFrame();
	}

	o.onTurnStart <- function()
	{
		if (this.m.timer_on) this.m.IsSpent = true;
	}

	o.onCombatStarted <- function()
	{
		this.m.IsSpent = false;
		this.m.timer_on = false;
		this.m.LastFrameUsed = 0;
	}

	o.onCombatFinished <- function()
	{
		this.m.IsSpent = false;
		this.m.timer_on = false;
		this.m.LastFrameUsed = 0;
		this.skill.onCombatFinished();
	}

	o.onProc <- function ()
	{
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate( _properties );
		_properties.SurviveWithInjuryChanceMult *= 1.11;
	}
});
