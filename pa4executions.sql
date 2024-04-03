-- IN
-- it takes a team name as an IN parameter and selects all the information about that exact team
SET @teamName = 'Real Madrid';
CALL GetTeamInfo(@teamName);

-- OUT
-- it gives total count of existing players as an output
SET @totalPLayers = NULL;
CALL GetPlayerCount(@totalPlayers);
SELECT @totalPlayers;

-- INOUT
-- it takes player id as an IN parameter and then returns number of goals scored bt this player as an OUT parameter, but using INOUT
SET @param = 3;
CALL CalculatePlayerGoals(@param);
SELECT @param;

-- TRANSACTION
CALL update_match_transaction(1, 2, 3);
CALL update_match_transaction(2, -1, -5);
