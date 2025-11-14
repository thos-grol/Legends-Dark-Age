// Note: creating a new module, you can copy the folder structure of previous module,
// but you need to modify the register/load files

// =================================================================================================
// CONST
// =================================================================================================

if (!("Z" in this.getroottable())) ::Z <- {};
if (!("DEF" in this.getroottable())) ::DEF <- {};

::Z.MOD_VERSION <- "4.0.0";
::Z.IDX <- 0;

::Z.INFO <- {};
::Z.PRE <- "mod_da_";

::Z.INFO[::Z.IDX] <- {
	"id" : "00_00",
	"name" : "Dark Age: Core" 
};

::Z.DIR_JS <- "ui/mods/";



// =================================================================================================
// REGISTER
// =================================================================================================
::m <- ::Hooks.register(
	::Z.PRE + ::Z.INFO[::Z.IDX]["id"], 
	::Z.MOD_VERSION, 
	::Z.INFO[::Z.IDX]["name"]
);
::m.require("mod_legends >= 19.1.35", "mod_msu >= 1.2.6", "mod_swifter");
::m.queue(">mod_legends", ">mod_msu", ">mod_swifter", function(){
	// old hooks load jss/css after main menu screen is initialized on the sq side 
	// (basically when screen is visible to user). Thus, hooks for fns such as registerDatasourceListener
	// would be executed immediately upon instantiation and never run

	// modern hooks executes these much earlier (after all vanilla files are read and Screens are 
	// defined, but before any of them (except for Root Screen due to engine limitations) are instantiated

	::Hooks.registerJS(::Z.DIR_JS + "menu_bg.js");
	
	::Hooks.registerJS(::Z.DIR_JS + "menu_sounds.js");
	::Hooks.registerJS(::Z.DIR_JS + "menu_campaign_defaults.js");

	::Hooks.registerJS(::Z.DIR_JS + "ui_time.js");
	
	::Hooks.registerCSS(::Z.DIR_JS + "menu_fast_travel.css");
	::Hooks.registerJS(::Z.DIR_JS + "menu_fast_travel.js");
	
	::Hooks.registerCSS(::Z.DIR_JS + "tactical_log.css");
	::Hooks.registerJS(::Z.DIR_JS + "tactical_log.js");

	::Hooks.registerCSS(::Z.DIR_JS + "menu_event.css");
	::Hooks.registerJS(::Z.DIR_JS + "menu_event.js");

	# load module
	::include("00_00/load.nut");
});