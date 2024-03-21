-- = with non-correlated subqueries result

-- select
-- it selects the team that has the most victories
SELECT t.team_name
FROM teams t
WHERE t.id = (SELECT team_id
              FROM standings s
              WHERE s.won = (SELECT MAX(s.won)
                             FROM standings s)
    LIMIT 1
    );

-- update
-- sets a new manager to the maximum id team
UPDATE teams t
SET t.manager = 'New Manager'
WHERE t.id = (
    SELECT MAX(t.id)
    FROM teams
);

-- delete
-- deletes the team (from the added with id more than 4) that has minimum victories
DELETE
FROM teams t
WHERE t.id = (SELECT team_id
              FROM standings s
              WHERE team_id > 4 AND s.won = (SELECT MIN(s.won)
                                             FROM standings s)
    LIMIT 1
    );

-- IN with non-correlated subqueries result
-- select
-- it selects teams that have scored more than the average
SELECT t.team_name
FROM teams t
WHERE t.id IN (
    SELECT DISTINCT s.team_id
    FROM standings s
    GROUP BY s.team_id
    HAVING SUM(s.points) > (SELECT AVG(total_points)
                            FROM (SELECT SUM(s.points) AS total_points
                                  FROM standings s
                                  GROUP BY s.team_id)
    )
);

-- update
-- sets all of the 1-st teams's players to position of Forward
UPDATE players
SET position = 'Forward'
WHERE id IN (
    SELECT ptp.player_id
    FROM player_team_pairs ptp
    WHERE ptp.team_id = 1
);

-- delete
-- deletes those teams (except first 4) that have scored less than average
DELETE
FROM teams t
WHERE t.id > 4 AND t.id IN (
    SELECT DISTINCT s.team_id
    FROM standings s
    GROUP BY s.team_id
    HAVING SUM(s.points) < (SELECT AVG(total_points)
                            FROM (SELECT SUM(s.points) AS total_points
                                  FROM standings s
                                  GROUP BY s.team_id)
    )
);


-- NOT IN with non-correlated subqueries result
-- select
-- shows teams that have not had any drawns in the season of 2023/2024
SELECT t.team_name
FROM teams t
WHERE id NOT IN (
    SELECT st.team_id
    FROM standings st
    WHERE st.drawn > 0
      AND st.match_day_id IN (
        SELECT m.id
        FROM match_days m
        WHERE season_id = (SELECT ss.id FROM seasons ss WHERE ss.name = '2023/2024')
    )
);

-- update
-- updates a stadium for those teams who have not scored at all
UPDATE teams t
SET stadium = 'Unknown'
WHERE id NOT IN (
    SELECT s.team_id
    FROM standings s
    WHERE s.points > 0
);

-- delete
-- delete would be similar as with IN


-- EXISTS with non-correlated subqueries result
-- select
-- doesn't make any sense, but otherwise it would be correlated
-- it shows all the teams if there were any records in standings having a draw
SELECT t.team_name
FROM teams t
WHERE EXISTS (
    SELECT 1
    FROM standings s
    WHERE s.drawn > 0
);

-- update
-- for players who ever scored sets position to defender
UPDATE players p
SET position = 'Defender'
WHERE EXISTS (
    SELECT 1
    FROM goals g
    WHERE g.player_id = p.id
);

-- delete
-- for EXISTS with non-correlated it would delete all or not delete at all


-- NOT EXISTS with non-correlated subqueries result
-- select
-- this select doesn't make any sense, because it shows all players or doesn't show at all.
-- it is because of the non-correlated subquery, 
-- because this condition is not connected with players at all
-- otherwise it would be a correlated subquery
SELECT p.name
FROM players p
WHERE NOT EXISTS (
    SELECT 1
    FROM goals g
);

-- update
-- set a position 'extra' to those who are not yet playing for any teams
UPDATE players p
SET position = 'Extra'
WHERE NOT EXISTS (
    SELECT 1
    FROM player_team_pairs ptp
    WHERE ptp.player_id = p.id
);

-- delete
-- same for NOT EXISTS with non-correlated it would delete all or not delete at all

-- = with correlated subqueries result
-- select
-- shows all the matches where home team and away team scored the same
SELECT m.title
FROM matches m
WHERE (
          SELECT COUNT(*)
          FROM goals g
          WHERE g.match_id = m.id AND g.team_id = m.home_team_id
      )
          =
      (
          SELECT COUNT(*)
          FROM goals g
          WHERE g.match_id = m.id AND g.team_id = m.away_team_id
      );

-- update
-- updates a manager for the team with the oldest player
UPDATE teams t
SET manager = 'New Man'
WHERE id = (
    SELECT id
    FROM players p
    WHERE p.id = t.id
    ORDER BY p.birthday ASC
    LIMIT 1
    );

-- delete
-- deletes all players from team 5
DELETE FROM players p
WHERE p.id IN (SELECT ptp.player_id FROM player_team_pairs ptp WHERE ptp.team_id = 5);

-- IN with correlated subqueries result
-- shows matches where home team and away team have scored both
SELECT m.title
FROM matches m
WHERE m.home_team_id IN (
    SELECT DISTINCT team_id
    FROM goals g
    WHERE m.id = g.match_id
)
  AND m.away_team_id IN (
    SELECT DISTINCT team_id
    FROM goals g
    WHERE m.id = g.match_id
);

-- update
-- sets a new manager for teams who have spanish players
UPDATE teams
SET manager = 'Spanish Leader'
WHERE id IN (
    SELECT id
    FROM players p
    WHERE p.nationality = 'Spanish'
);



-- delete
-- deletes all players from teams with id more than 4
DELETE FROM players p
WHERE p.id IN (SELECT ptp.player_id FROM player_team_pairs ptp WHERE ptp.team_id > 4);


-- NOT IN with correlated subqueries result
-- shows all matches where there were no spanish players
SELECT m.title
FROM matches m
WHERE m.home_team_id NOT IN (
    SELECT DISTINCT team_id
    FROM player_team_pairs ptp
    WHERE ptp.player_id IN (
        SELECT id
        FROM players
        WHERE nationality = 'Spanish'
    )
)
  AND m.away_team_id NOT IN (
    SELECT DISTINCT team_id
    FROM player_team_pairs ptp
    WHERE ptp.player_id IN (
        SELECT id
        FROM players
        WHERE nationality = 'Spanish'
    )
);

-- update
-- sets a new manager to all the team who have no dutch players
UPDATE teams t
SET t.manager = 'Nono-dutch Manager'
WHERE id NOT IN (
    SELECT p.id
    FROM players p
             JOIN player_team_pairs ptp ON ptp.player_id = p.id
    WHERE p.nationality = 'Dutch'
);

-- EXISTS with correlated subqueries result
-- select
-- shows all players who have scored any goals
SELECT p.name
FROM players p
WHERE EXISTS (
    SELECT 1
    FROM goals g
    WHERE g.player_id = p.id
);

-- update
-- sets a new stadium for all teams that have matches in the recent season
UPDATE teams t
SET t.stadium = 'Main Stadium'
WHERE EXISTS (
    SELECT 1
    FROM matches m
             JOIN match_days md ON m.match_day_id = md.id
    WHERE md.season_id = (SELECT MAX(id) FROM seasons)
      AND (m.home_team_id = t.id OR m.away_team_id = t.id)
);

-- NOT EXISTS with correlated subqueries result
-- select
-- shows all matches were the home team has not scored any goals
SELECT m.title
FROM matches m
WHERE NOT EXISTS (
    SELECT 1
    FROM goals g
    WHERE g.match_id = m.id
      AND g.team_id = m.home_team_id
);

-- update
-- sets 'no manager' to every team that has no matches in the recent season
UPDATE teams
SET manager = 'No Manager'
WHERE NOT EXISTS (
    SELECT 1
    FROM matches m
             INNER JOIN match_days md ON m.match_day_id = md.id
    WHERE md.season_id = (SELECT MAX(id) FROM seasons)
      AND (m.home_team_id = teams.id OR m.away_team_id = teams.id)
);

-- delete
-- deletes matches where home team's id is above 4 and they have not scored any goals
DELETE
FROM matches m
WHERE NOT EXISTS (
    SELECT 1
    FROM goals g
    WHERE m.home_team_id > 4
      AND g.match_id = m.id
      AND g.team_id = m.home_team_id
);

-- UNION
-- selects all teams and all players available
SELECT team_name AS name, 'Team' AS type
FROM teams
UNION
SELECT name, 'Player' AS type
FROM players;

-- UNON ALL
-- selects all players and teams and shows how many players are there
SELECT team_name AS name, 'Team' AS type
FROM teams
UNION ALL
SELECT team_name, player_count
FROM (
         SELECT t.team_name, COUNT(ptp.player_id) AS player_count
         FROM teams t
                  LEFT JOIN player_team_pairs ptp ON t.id = ptp.team_id
         GROUP BY t.team_name
     ) AS subquery;

-- INTERSECT
-- shows players who are also managers
/*SELECT name, 'Player' AS type
FROM players
         INTERSECT
SELECT manager, 'Manager' AS type
FROM teams;*/

-- EXCEPT
-- players who have not scored any goals
SELECT name, 'Player' AS type
FROM players WHERE 1=1
EXCEPT
SELECT p.name, 'Scoring Player' AS type
FROM players p
         JOIN goals g ON p.id = g.player_id;