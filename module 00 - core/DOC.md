# Core

This module adds ui modifications as well as the foundation modules that other modules are built on top of

#0000
Implement Button Sound Hooks
    - Add button start sound
    - Add button click and hover sounds

#0001
Set up Main menu screen
    
#0003
Set up basic World UI
    Done
    - rebind pause key to open closest town
    - remove paused div

    In Progress
    - create new day variable as flag
    - create interface to get days in js

    - remove day circle + speed controls,
    - remove time of day message, just keep day,

    - fast travel
        ui - create new screen and register it, show screen with dialog box
        prototype


#0004 - travel
    - create event stack. Build the event stack before fast travel.
    - hook event manager to use event id stack
        write function to evaluate event stack start & continuation

    function getEvent( _id )
	{
		foreach( event in this.m.Events )
		{
			if (event.getID() == _id)
			{
				return event;
			}
		}

		return null;
	}    

#0005 - Proof of concept system of modular contract
	(return item contract to modular contract)
    - set up basic flow including battle resolution
	- now add template screen for day resolution for contracts
    - display enemy composition in screen


#0006 UI - Log Override functionality and libraries
	- Integrate Log override again, so we don't wait long to implement log hooks





















#000? Contract Overhaul
- Profile: Greedy, Moderate, Desperate
    - determines prices given
    - determines base negotiation chances




showEncounterScreenFromTown


Factions
    Set static name and flags
        - Noble 1 - Wolf Tamers/Ice Magic
            Heroes
        - Noble 2 - Witchers, genetic evolution
            Heroes
        - Noble 3 - Inspired by nilfgard. Court mages and organized troops.
            Heroes
        - City State 1 - Serpents, Assasins, Poisons
            Heroes
        - City State 2 - Focuses on gladiators, arena here
            Heroes
        - City State 3 - Home of the best fire magic
            Heroes
    Each non-southern faction has it's own variant of bandits:
        north - Barbarians
        noble2 - ?
        noble3 - ?
    necromancer faction
    cultist faction
    goblin faction
    orc faction

    villages sometimes have monster problems
    idea: some lone orcs wandering into human territory
    idea: some goblins wandering into human territory

    faction is disabled from calculation if it has no settlements

    World.spawnLocation

 Not Done
    - 2 top buttons (tracking + camp)
        - painter + barber shop
        - rebind those hotkeys
        - ui for those buttons