-- IN
-- it takes a team name as an IN parameter and selects all the information about that exact team
SET @teamName = 'Real Madrid';
CALL get_team_info_sproc(@teamName);

-- OUT
-- it gives total count of existing players as an output
SET @total_pLayers = NULL;
CALL get_number_of_players_sproc(@total_players);
SELECT @total_players;

-- INOUT
-- it takes player id as an IN parameter and then returns number of goals scored bt this player as an OUT parameter, but using INOUT
SET @param = 3;
CALL calculate_players_goals_sproc(@param);
SELECT @param;

-- TRANSACTION
CALL update_match_result_sproc(1, 2, 3);
CALL update_match_result_sproc(2, -1, -5);