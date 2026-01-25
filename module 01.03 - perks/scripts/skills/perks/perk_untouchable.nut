
this.perk_untouchable <- this.inherit("scripts/skills/skill", {
	m = {
		stacks = 0,
		stacks_max = 2
	},
	function create()
	{
		this.m.ID = "perk.untouchable";
		this.m.Name = ::Const.Strings.PerkName.Untouchable;
		this.m.Description = ::Const.Strings.PerkDescription.Untouchable;
		this.m.Icon = "ui/perks/untouchable.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.Overlay = "untouchable";
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_targetEntity)) return;

		this.m.stacks = this.m.stacks_max;

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, actor.getPos());
			}

			this.spawnIcon(this.m.Overlay, actor.getTile());
			::Tactical.EventLog.logIn(::color_name(actor) + " [Untouchable]");

		}
	}
});