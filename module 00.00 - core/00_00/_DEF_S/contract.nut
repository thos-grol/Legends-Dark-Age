// Defines functions and variables involving contracts

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

::Z.T.Contract <- {};
::Z.T.Contract.Stack <- [];
::Z.T.Contract.Victory <- null;
::Z.T.Contract.Defeat <- null;

// we hook the loading screen, so when it's hidden we can resume the contract ui
// and use the outcome strings to determine flow
// refer to ::Z.T.Contract.build_stack_combat and ::Z.S.show_contract_screen_post_combat
::Z.T.Contract.set_outcomes_combat <- function (_success, _failure) 
{
	::Z.T.Contract.Victory <- _success;
	::Z.T.Contract.Defeat <- _failure;
}

::Z.T.Contract.build_stack_combat <- function (_is_victory) 
{
	if (_is_victory)
	{
		::Z.T.Contract.Stack.push(::Z.T.Contract.Victory);
	}
	else
	{
		::Z.T.Contract.Stack.push(::Z.T.Contract.Defeat);
	}
	::Z.T.Contract.Victory <- null;
	::Z.T.Contract.Defeat <- null;
}

// =========================================================================================
// Main
// =========================================================================================

::Z.S.show_contract_screen_post_combat <- function ( _tagonull )
{
	local activeContract = ::World.Contracts.getActiveContract();
	local screen_id = ::Z.T.Contract.Stack.pop();
	activeContract.setScreen(screen_id);
	::World.Contracts.showActiveContract();
}


::Z.S.end_day_contract <- function ()
{
	::Z.T.Event.build_stack_day();
	::Z.S.transition(::Z.T.Event.iterate_stack);
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.show_enemy_list <- function ( _entities, _list )
{
	//used in contract screens to show the list of enemies
	local champions = [];
	local entityTypes = [];
	entityTypes.resize(::Const.EntityType.len(), 0);

	foreach( t in _entities )
	{
		if (t.Script.len() == "") continue;
		if (t.Variant != 0 && ::Const.DLC.Wildmen)
		{
			champions.push(t);
		}
		else
		{
			++entityTypes[t.ID];
		}
	}

	foreach( c in champions )
	{
		_list.push({
			id = 10,
			icon = "ui/orientation/" +  ::Const.EntityIcon[c.ID] + ".png",
			text = c.Name
		});
	}

	for( local i = 0; i < entityTypes.len(); i = ++i )
	{
		if (entityTypes[i] <= 0) continue;
		if (entityTypes[i] == 1)
		{
			_list.push({
				id = 10,
				icon = "ui/orientation/" +  ::Const.EntityIcon[i] + ".png",
				text = entityTypes[i] + " - " + ::Const.Strings.EntityName[i],
			});
		}
		else
		{
			_list.push({
				id = 10,
				icon = "ui/orientation/" +  ::Const.EntityIcon[i] + ".png",
				text = entityTypes[i] + " - " + ::Const.Strings.EntityNamePlural[i],
			});
		}
	}
}