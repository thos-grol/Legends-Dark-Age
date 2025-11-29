// Handles the new stash system
// We have a logical global stash that's shared everywhere.
::Legends.Stash.getStartingSize <- @() 50; // Let's start with 50 slots

::Legends.Stash.resize <-
	@() ::World.Assets.getStash().resize(::Legends.Stash.getSize());

::Legends.Stash.getSize <- function() {
	local size = ::Legends.Stash.getStartingSize();
	// Let's remove any finicky stuff where stash size gets deleted please...
    // foreach (bro in ::World.getPlayerRoster().getAll()) {
	// 	size += bro.getStashModifier();
	// }
	size += ::World.Retinue.hasFollower("follower.quartermaster") ? 25 : 0;
	// size += ::World.Flags.getAsInt(::Legends.Stash.Flags.CaravanHandEvent);
	size += ::World.Flags.getAsInt(::Legends.Stash.Flags.CartUpgrades) * 25;
	return size;
}