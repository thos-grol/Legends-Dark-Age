// Defines functions and variables involving formations/squads
::Z.S.Formation <- {}
::Z.T.Formation <- {};

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================
::Z.T.Formation.CHUNK_SIZE <- 27;
::Z.T.Formation.STORAGE_SIZE <- 200;

::Z.T.Formation.CHUNK_INDEX <- 0;

::Z.T.Formation.Reset <- function()
{
	::Z.T.Travel.ID <- null;
	::Z.T.Travel.Days <- 0;
    ::Z.T.Formation.CHUNK_INDEX <- 0;
}

// =========================================================================================
// Main
// =========================================================================================

::Z.S.Formation.Init <- function(_chunk)
{
	// b.setPlaceInFormation(3); // sets to stored position 3 which is chunk 0
    // b.getPlaceInFormation();  // gets stored position
    ::Z.T.Formation.CHUNK_INDEX <- _chunk;
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.Formation.get_squad <- function()
{
    local sub_roster = [];
    local bounds = ::Z.S.Formation.get_chunk_bounds();
    local roster = ::World.getPlayerRoster().getAll();
    
    foreach( b in roster )
    {
        local i = b.getPlaceInFormation();
        if (i >= bounds[0] && i < bounds[1])
        {
            sub_roster.append(b);
            ::logInfo("Adding to combat: " + b.getName())
        }
    }
    return sub_roster;
}

::Z.S.Formation.get_translated_index <- function(_index)
{
    if (_index >= ::Z.T.Formation.CHUNK_SIZE) return _index;
    return ::Z.T.Formation.CHUNK_SIZE * ::Z.T.Formation.CHUNK_INDEX + _index;
}

::Z.S.Formation.get_compressed_index <- function(_index)
{
    return _index % ::Z.T.Formation.CHUNK_SIZE;
}

::Z.S.Formation.get_chunk_bounds <- function()
{
    return [
        ::Z.T.Formation.CHUNK_INDEX * ::Z.T.Formation.CHUNK_SIZE, 
        (::Z.T.Formation.CHUNK_INDEX + 1) * ::Z.T.Formation.CHUNK_SIZE - 1
    ];
}

::Z.S.Formation.get_storage_bounds <- function()
{
    return [
        ::Z.T.Formation.CHUNK_SIZE * 10, 
        ::Z.T.Formation.CHUNK_SIZE * 10 + ::Z.T.Formation.STORAGE_SIZE - 1
    ];
}

::Z.S.Formation.get_logical_storage_bounds <- function()
{
    return [
        ::Z.T.Formation.CHUNK_SIZE * 10, 
        ::Z.T.Formation.CHUNK_SIZE * 10 + ::Z.T.Formation.STORAGE_SIZE - 1
    ];
}