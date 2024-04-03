----------- IN -----------------------
-- it takes a team name as an IN parameter and selects all the information about that exact team
-- creating a procedure
DELIMITER &&

CREATE PROCEDURE GetTeamInfo (IN teamName VARCHAR(255))
BEGIN
    SELECT * FROM teams WHERE team_name = teamName;
END&&
 
DELIMITER ;


----------- OUT ------------------------
-- it gives total count of existing players as an output
DELIMITER &&

CREATE PROCEDURE GetPlayerCount (OUT totalPlayers INT)
BEGIN
SELECT COUNT(*) INTO totalPlayers FROM players;
END&&
DELIMITER ;
   
SET @totalPLayers = NULL;
CALL GetPlayerCount(@totalPlayers);
SELECT @totalPlayers;
   


---------- INOUT ------------------------
-- it takes player id as an IN parameter and then returns number of goals scored bt this player as an OUT parameter, but using INOUT
DELIMITER &&

CREATE PROCEDURE CalculatePlayerGoals (
    INOUT playerID INT
)
BEGIN
    DECLARE totalGoals INT;
SELECT COUNT(*) INTO totalGoals FROM goals WHERE player_id = playerID;
SET playerID = totalGoals;
END&&

DELIMITER ;
   
SET @param = 5;
CALL CalculatePlayerGoals(@param);
SELECT @param;
   

------------- TRANSACTION -------------------------
-- if the input data about match's goals is accurate (not negative), it updates the info in "matches" table and commits
-- else, it still updates, but after the "if" condition, it does rollback
CREATE PROCEDURE update_match_result(
    IN match_id INT,
    IN home_team_score INT,
    IN away_team_score INT
)
BEGIN
    DECLARE valid_result BOOLEAN;
    SET valid_result = (home_team_score >= 0 AND away_team_score >= 0);

START TRANSACTION;

UPDATE matches
SET home_score = home_team_score, away_score = away_team_score
WHERE match_id = id;

IF valid_result THEN
        COMMIT;
ELSE
        ROLLBACK;
END IF;
END &&

DELIMITER ;