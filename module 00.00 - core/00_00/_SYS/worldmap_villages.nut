::mods_hookExactClass("entity/world/settlements/legends_village", function(o) {
    // - disable village labels
    o.setOwner <- function(_o)
	{
		if (this.m.Owner != null) this.m.Owner.removeSettlement(this);
		this.m.Owner = this.WeakTableRef(_o);
		local location_banner = this.getSprite("location_banner");
		location_banner.setBrush(_o.getBannerSmall());

		location_banner.Visible = false;
        this.setShowName(false);
		this.getLabel("name").Visible = false;
	}

    o.getTooltip <- function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		foreach( i in this.m.Factions )
		{
			local f = this.World.FactionManager.getFaction(i);
			ret.push({
				id = 5,
				type = "hint",
				icon = f.getUIBanner(),
				text = "Relations: " + f.getPlayerRelationAsText()
			});
		}

		return ret;
	}
});