local ROOT = "00_00";
local FOLDERS = [
	"_CORE",
	"_DEFS",
	// "_SYS",
	"src",
];

foreach (folder in FOLDERS) {
	local folder_path = ROOT + "/" + folder;
	::logInfo(folder_path);
    foreach (file in ::IO.enumerateFiles(folder_path)) {
		::include(file);
	}
}


::Z.Screen <- {}
::Z.Screen.Fast_Travel <- ::new("scripts/screens/fast_travel_screen");
::MSU.UI.registerConnection(::Z.Screen.Fast_Travel );

::Z.Screen.Transition <- ::new("scripts/screens/transition_screen");
::MSU.UI.registerConnection(::Z.Screen.Transition );

// ::MSU.UI.addOnConnectCallback(::MSU.System.ModSettings.finalize.bindenv(::MSU.System.ModSettings));
// 		This registers a function to be executed on after all JS code in !mods_preload is run and all screens are connected.
// 		The function will be called with a simple .call() so you will need to bindenv if you require any local variables.