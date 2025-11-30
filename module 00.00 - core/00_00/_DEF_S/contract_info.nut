// Defines functions and variables involving contracts

// world_state.m.SquadScreen.show() -> SquadScreen.queryData()
// =========================================================================================
// Associated tmp variables and managers
// =========================================================================================

::Z.T.CONTRACT_INFO_BUFFER <- {
    Active = false,
    ID = 0,
    Name = null,
    Description = null,
    Pay = 0,
    Bro_Limit = 0,
};

::Z.S.CONTRACT_INFO_BUFFER_flush <- function () 
{
    ::Z.T.CONTRACT_INFO_BUFFER.Active = false;
    ::Z.T.CONTRACT_INFO_BUFFER.ID = 0;
    ::Z.T.CONTRACT_INFO_BUFFER.Name = null;
    ::Z.T.CONTRACT_INFO_BUFFER.Description = null;
    ::Z.T.CONTRACT_INFO_BUFFER.Pay = 0;
    ::Z.T.CONTRACT_INFO_BUFFER.Bro_Limit = 0;
}

::Z.S.CONTRACT_INFO_BUFFER_isactive <- function() 
{
    return ::Z.T.CONTRACT_INFO_BUFFER.Active;
}

// =========================================================================================
// Main
// =========================================================================================

::Z.S.store_contract_info <- function( contract ) 
{
    ::Z.T.CONTRACT_INFO_BUFFER.Active = true;
    ::Z.T.CONTRACT_INFO_BUFFER.ID = contract.m.ID;
    ::Z.T.CONTRACT_INFO_BUFFER.Name = contract.m.Name;
    ::Z.T.CONTRACT_INFO_BUFFER.Description = contract.m.Description;
    ::Z.T.CONTRACT_INFO_BUFFER.Pay = contract.m.Payment.Pool;
    ::Z.T.CONTRACT_INFO_BUFFER.Bro_Limit = contract.m.Bro_Limit;
}

// =========================================================================================
// Helper
// =========================================================================================

::Z.S.CONTRACT_INFO_BUFFER_push <- function() 
{
    return [
        ::Z.T.CONTRACT_INFO_BUFFER.ID,
        ::Z.T.CONTRACT_INFO_BUFFER.Name,
        ::Z.T.CONTRACT_INFO_BUFFER.Description,
        ::Z.T.CONTRACT_INFO_BUFFER.Pay,
        ::Z.T.CONTRACT_INFO_BUFFER.Bro_Limit,
    ]
}