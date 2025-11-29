// Defines functions and variables involving the wartable, global faction logic

// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

// =========================================================================================
// Main
// =========================================================================================

::Z.S.generate_weekly_actions <- function()
{
    local faction;
    local settlements;

    
    faction = ::World.FactionManager.get_faction("House Adelheim");
    settlements = faction.getSettlements();
    ::logInfo("Adding contracts for House Adelheim (" + settlements.len() + " settlements)");

    foreach( settlement in settlements )
    {
        if (settlement.m.Capital) continue;
        ::logInfo("Adding contracts for " + settlement.m.Name);

        local contract = this.new("scripts/contracts/contracts/return_item_contract");
        contract.setFaction(faction.getID());
        contract.setHome(settlement);
        contract.setEmployerID(faction.getRandomCharacter().getID());
        ::World.Contracts.addContract(contract);
    }
}

::Z.S.resolve_weekly_actions <- function()
{
    
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.spawn_contract_entity <- function(location, contract, _additionalDistance = 2)
{
    local tries = 0;
    local myTile = location.getTile();

    while (tries++ < 1000)
    {
        local x = ::Math.rand(myTile.SquareCoords.X - 2 - _additionalDistance, myTile.SquareCoords.X + 2 + _additionalDistance);
        local y = ::Math.rand(myTile.SquareCoords.Y - 2 - _additionalDistance, myTile.SquareCoords.Y + 2 + _additionalDistance);

        if (!::World.isValidTileSquare(x, y)) continue;
        
        local tile = ::World.getTileSquare(x, y);
        if (tile.IsOccupied) continue;
        
        if (tile.getDistanceTo(myTile) == 1 && _additionalDistance >= 0 || tile.getDistanceTo(myTile) < _additionalDistance) continue;

        // contract entity setup
        local contract_entity = ::World.spawnLocation("scripts/entity/world/locations/legendary/contract_entity", tile.Coords);
        contract_entity.set_details(contract.get_details());
        contract.set_coordinates(x, y);
        break;
    }

    
}