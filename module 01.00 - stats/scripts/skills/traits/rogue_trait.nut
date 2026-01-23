this.rogue_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.rogue";
		this.m.Name = "Rogue";
		this.m.Icon = "ui/traits/trait_icon_58.png";
		this.m.Description = ".";
		this.m.Titles = [];
		this.m.Excluded = [];
		this.m.IsHidden = true;
	}

	function getTooltip()
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

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Footwork))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Footwork);
		}
	}
 
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Footwork);
	}

});

