// =================================================================================================
// load module files
// =================================================================================================

local ROOT = "03_00";
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