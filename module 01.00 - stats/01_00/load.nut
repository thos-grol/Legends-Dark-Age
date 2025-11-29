
// load config folder
// foreach (file in ::IO.enumerateFiles("01.00/!!!!config")) {
// 	::include(file);
// }
// foreach (file in ::IO.enumerateFiles("01.00/!!config")) {
// 	::include(file);
// }
// foreach (file in ::IO.enumerateFiles("01.00/!config")) {
// 	::include(file);
// }

foreach (file in ::IO.enumerateFiles("01_00/src"))
{
	::include(file);
}