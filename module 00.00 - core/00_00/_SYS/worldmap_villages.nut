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
	}

    o.getTooltip <- function()
	{
		return [
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
	}
});