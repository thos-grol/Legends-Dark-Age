// Note: creating a new module, you can copy the folder structure of previous module,
// but you need to modify the register/load files

// =================================================================================================
// CONST
// =================================================================================================
local MOD_BEFORE = ">" + ::Z.PRE + ::Z.INFO[::Z.IDX]["id"];
::Z.IDX++;
::Z.INFO[::Z.IDX] <- {
	"id" : "02_02",
	"name" : "Dark Age: Items" 
};
// =================================================================================================
// REGISTER
// =================================================================================================

local mod = ::Hooks.register(
	::Z.PRE + ::Z.INFO[::Z.IDX]["id"], 
	::Z.MOD_VERSION, 
	::Z.INFO[::Z.IDX]["name"]
);
mod.queue(MOD_BEFORE, function(){
	// old hooks load jss/css after main menu screen is initialized on the sq side 
	// (basically when screen is visible to user). Thus, hooks for fns such as registerDatasourceListener
	// would be executed immediately upon instantiation and never run

	// modern hooks executes these much earlier (after all vanilla files are read and Screens are 
	// defined, but before any of them (except for Root Screen due to engine limitations) are instantiated

	// ::Hooks.registerJS(::Z.DIR_JS + "menu_event.js");
	// ::mods_registerJS("mod_display_stats.js");

	# load module
	::include("02_02/load.nut");
});