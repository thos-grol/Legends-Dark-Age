// "injury.brain_damage"
// "Brain Damage"
// "A hard hit to the head shook some things up and didn\'t exactly benefit this character\'s cognitive skills. On the bright side, he may now be just too stupid to realize when it\'s time to run."
// "ui/injury/injury_permanent_icon_12.png"
::mods_hookExactClass("skills/injury_permanent/brain_damage_injury", function (o)
{
	o.getNameP <- function() { return "Strange Wisdom" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.isContent <- function() { return false; }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-25%") + " Experience Gain"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-25%") + " Reflex"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+15%[/color] Will"
		});
		if (has)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Increases potency of Eyes on the Inside's drain."
			});
		}
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.XPGainMult *= has ? 0.9 : 0.75;
		_properties.RangedDefenseMult *= has ? 0.8 : 0.75;
		_properties.BraveryMult *= 1.15;
	}

	o.onApplyAppearance = function()
	{
		try {
			local sprite = this.getContainer().getActor().getSprite("permanent_injury_1");
			sprite.setBrush("permanent_injury_01");
			sprite.Visible = true;
		} catch(exception) {}
	}

});