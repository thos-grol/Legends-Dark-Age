if (!("Z" in this.getroottable())) ::Z <- {};
if (!("DEF" in this.getroottable())) ::DEF <- {};

::Z.Version <- "3.0.0";
::Z.ModID <- "da_00_core";
::Z.Name <- "Dark Age: Core";

# #0000 Hook Js Button Sounds - sq fn defs
::Button_Sounds <- {
	ID = "mod_button_sounds"
	Name = "Dark Age: Button Sounds"
	Version = "1.0.0"
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
		::Button_Sounds.JSHandle.asyncCall("registerMenuButtons", null)
	}
}


::mods_registerMod(::Z.ModID, ::Z.Version, ::Z.Name);
::mods_queue(::Z.ModID, "mod_legends(>=19.1.35), mod_msu(>=1.2.6), mod_swifter", function()
{

	::Z.Mod <- ::MSU.Class.Mod(::Z.ModID, ::Z.Version, ::Z.Name);
	
	# #0000 Hook Js Button Sounds - connect ui, register js hooks
	::mods_registerJS("00_main_menu.js");
	::mods_registerJS("00_sounds_button.js");

	::mods_registerJS("01_time_elements.js");

	::mods_registerJS("SYS_Travel.js");
	::mods_registerCSS("SYS_Travel.css");
	
	::mods_registerJS("SYS_log.js");
	::mods_registerCSS("SYS_log.css");

	::mods_registerJS("FIX_dialog_readability.js");
	::mods_registerCSS("FIX_dialog_readability.css");

	::MSU.UI.registerConnection(::Button_Sounds);
	::MSU.UI.addOnConnectCallback(::Button_Sounds.registerMenuButtons);

	# load core module
	::include("load00.nut");

	::MSU.MH.queue(function() {
		foreach (func in ::Z.QueueBucket.VeryLate)
		{
			func();
		}
		::Z.QueueBucket.VeryLate.clear();
	}, ::Hooks.QueueBucket.VeryLate);
});