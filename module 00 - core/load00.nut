// load config folder
foreach (file in ::IO.enumerateFiles("src/!!!config")) {
	::include(file);
}
foreach (file in ::IO.enumerateFiles("src/!!config")) {
	::include(file);
}
foreach (file in ::IO.enumerateFiles("src/!config")) {
	::include(file);
}
// foreach (file in ::IO.enumerateFiles("src/config")) {
// 	::include(file);
// }

foreach (file in ::IO.enumerateFiles("src/src"))
{
	::include(file);
}



::Z.Screen <- {}
::Z.Screen.Fast_Travel <- ::new("scripts/screens/fast_travel_screen");
::MSU.UI.registerConnection(::Z.Screen.Fast_Travel );

::Z.Screen.Transition <- ::new("scripts/screens/transition_screen");
::MSU.UI.registerConnection(::Z.Screen.Transition );

// ::MSU.UI.addOnConnectCallback(::MSU.System.ModSettings.finalize.bindenv(::MSU.System.ModSettings));
// 		This registers a function to be executed on after all JS code in !mods_preload is run and all screens are connected.
// 		The function will be called with a simple .call() so you will need to bindenv if you require any local variables.