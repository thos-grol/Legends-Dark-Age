::mods_hookNewObject("factions/faction_manager", function(o)
{
 	o.get_faction <- function(name)
	{
		foreach (faction in this.m.Factions)
		{
			if (faction == null) continue;
			if (faction.m.Name == name) return faction;
		}
		return null;
	}

	o.createNobleHouses = function()
	{
		local banners = [];
		local names = [];
		local nobleHouses = [];

		local order = ["House Adelheim", "Templar Order", "House Rabenholt"];
		
		foreach (key in order)
		{
			local value = ::DEF.C.Factions.Nobles[key];
			local f = this.new("scripts/factions/noble_faction");
			local banner;
			do
			{
				banner = ::Math.rand(2, 10);
			}
			while (banners.find(banner) != null);
			banners.push(banner);

			names.push(key);
			f.setID(this.m.Factions.len());
			f.setName(key);
			f.setMotto("\"" + value.Motto + "\"");
			f.setDescription(value.Description);
			f.setBanner(banner);
			f.setDiscovered(true);

			foreach( t in value.Traits )
			{
				f.addTrait(t);
			}

			this.m.Factions.push(f);
			nobleHouses.push(f);
		}

		return nobleHouses;
	}
});