----------- IN -----------------------
-- it takes a team name as an IN parameter and selects all the information about that exact team
-- creating a procedure
DELIMITER &&

CREATE PROCEDURE get_team_info_sproc (IN teamName VARCHAR(255))
BEGIN
    SELECT 1 FROM teams WHERE team_name = teamName;
END&&
 
DELIMITER ;


----------- OUT ------------------------
-- it gives total count of existing players as an output
DELIMITER &&

CREATE PROCEDURE get_player_count_sproc (OUT total_players INT)
BEGIN
SELECT COUNT(1) INTO total_players FROM players;
END&&
DELIMITER ;
   


---------- INOUT ------------------------
-- it takes player id as an IN parameter and then returns number of goals scored bt this player as an OUT parameter, but using INOUT
DELIMITER &&

CREATE PROCEDURE calculate_player_goals_sproc (
    INOUT playerID INT
)
BEGIN
    DECLARE total_goals INT;
SELECT COUNT(1) INTO total_goals FROM goals WHERE player_id = playerID;
SET playerID = total_goals;
END&&

DELIMITER ;
   

------------- TRANSACTION -------------------------
-- if the input data about match's goals is accurate (not negative), it updates the info in "matches" table and commits
-- else, it still updates, but after the "if" condition, it does rollback
CREATE PROCEDURE update_match_result_sproc(
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