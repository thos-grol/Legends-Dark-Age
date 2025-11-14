local id = "01_00"
local mod_id = "da_" + id;
local mod_name = "Dark Age: Stats";

::mods_registerMod(mod_id, ::Z.Version, mod_name);
::mods_queue(mod_id, "da_" + "00_00", function()
{

	::Z.Mod_01 <- ::MSU.Class.Mod(mod_id, ::Z.Version, mod_name);

	// ::mods_registerJS("mod_display_stats.js");
	
	# load core module
	::include(id + "/load.nut");
});