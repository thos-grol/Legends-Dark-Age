// =================================================================================================
// load module files
// =================================================================================================

local ROOT = "00_00";
local FOLDERS = [
	"_CORE",
	"_DEF",
	"_DEF_S",
	"_SYS",
	"src",
];

foreach (folder in FOLDERS) {
	local folder_path = ROOT + "/" + folder;
    foreach (file in ::IO.enumerateFiles(folder_path)) {
		::include(file);
	}
}

// =================================================================================================
// register js screens
// =================================================================================================

::Z.Screen <- {}

::hk_btn_sounds <- {
	ID = "hk_btn_sounds"
	Name = "Dark Age: Button Sounds"
	Version = ::Z.MOD_VERSION
	JSHandle = null
	function connect()
	{
		this.JSHandle = this.UI.connect(this.ID, this);
	}
	function destroy()
	{
		this.JSHandle = ::UI.disconnect(this.JSHandle);
	}
	function isConnected()
	{
		return this.JSHandle != null;
	}
	function onButtonClicked()
	{
		::Sound.play("sounds/ui/click.wav", 1.5);
	}
	function onHover()
	{
		::Sound.play("sounds/ui/hover.wav", 0.5);
	}
	function registerMenuButtons()
	{
		::hk_btn_sounds.JSHandle.asyncCall("registerMenuButtons", null)
	}
}
::MSU.UI.registerConnection(::hk_btn_sounds);
::MSU.UI.addOnConnectCallback(::hk_btn_sounds.registerMenuButtons);

::Z.Screen.Fast_Travel <- ::new("scripts/screens/fast_travel_screen");
::MSU.UI.registerConnection(::Z.Screen.Fast_Travel );

::Z.Screen.Transition <- ::new("scripts/screens/transition_screen");
::MSU.UI.registerConnection(::Z.Screen.Transition );

// ::MSU.UI.addOnConnectCallback(::MSU.System.ModSettings.finalize.bindenv(::MSU.System.ModSettings));
// 		This registers a function to be executed on after all JS code in !mods_preload is run and all screens are connected.
// 		The function will be called with a simple .call() so you will need to bindenv if you require any local variables.