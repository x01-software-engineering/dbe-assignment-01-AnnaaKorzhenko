-- create a table
CREATE SCHEMA assignment;
USE assignment;
-- create a table  
CREATE TABLE teams (
                       id INTEGER PRIMARY KEY,
                       team_name VARCHAR(255),
                       city VARCHAR(255) NOT NULL,
                       stadium VARCHAR(255) NOT NULL,
                       manager VARCHAR(255)
);

CREATE TABLE players (
                         id INTEGER PRIMARY KEY,
                         name VARCHAR(255),
                         birthday DATE NOT NULL,
                         nationality VARCHAR(255) NOT NULL,
                         position varchar(255),
                         number INTEGER NOT NULL
);

CREATE TABLE player_team_pairs (
                                   team_id INTEGER,
                                   player_id INTEGER,
                                   PRIMARY KEY (team_id, player_id),
                                   FOREIGN KEY (team_id) REFERENCES teams(id),
                                   FOREIGN KEY (player_id) REFERENCES players(id)
);

CREATE TABLE seasons (
                         id INTEGER PRIMARY KEY,
                         name VARCHAR(255)
);

CREATE TABLE leagues (
                         id INTEGER PRIMARY KEY,
                         name VARCHAR(255) NOT NULL
);

CREATE TABLE match_days (
                            id INTEGER PRIMARY KEY,
                            season_id INTEGER NOT NULL,
                            league_id INTEGER NOT NULL,
                            day_number INTEGER NOT NULL CHECK (day_number > 0),
                            CONSTRAINT season2league2day_unique UNIQUE (season_id, league_id, day_number),
                            FOREIGN KEY (season_id) REFERENCES seasons(id),
                            FOREIGN KEY (league_id) REFERENCES leagues(id)
);

CREATE TABLE matches (
                         id INTEGER PRIMARY KEY,
                         title VARCHAR(255),
                         date_time DATETIME NOT NULL,
                         venue TEXT NOT NULL,
                         home_team_id INTEGER,
                         away_team_id INTEGER,
                         match_day_id INTEGER NOT NULL,
                         home_score INTEGER NOT NULL,
                         away_score INTEGER NOT NULL,
                         FOREIGN KEY (home_team_id) REFERENCES teams(id),
                         FOREIGN KEY (away_team_id) REFERENCES teams(id),
                         FOREIGN KEY (match_day_id) REFERENCES match_days(id)
);

CREATE TABLE goals (
                       id INTEGER PRIMARY KEY,
                       match_id INTEGER,
                       player_id INTEGER,
                       team_id INTEGER,
                       goal_time INTEGER CHECK (goal_time >= 0 AND goal_time <= 90),
                       additional_time INTEGER CHECK (additional_time>= 0 AND additional_time<= 30),
                       FOREIGN KEY (match_id) REFERENCES matches(id),
                       FOREIGN KEY (player_id) REFERENCES players(id),
                       FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE standings (
                           match_day_id INTEGER NOT NULL,
                           team_id INTEGER,
                           points INTEGER NOT NULL,
                           won INTEGER NOT NULL,
                           drawn INTEGER NOT NULL,
                           lost INTEGER NOT NULL,
                           goals_for INTEGER NOT NULL,
                           goals_against INTEGER NOT NULL,
                           PRIMARY KEY (match_day_id, team_id),
                           FOREIGN KEY (team_id) REFERENCES teams(id),
                           FOREIGN KEY (match_day_id) REFERENCES match_days(id)
);

/*-- insert some values
INSERT INTO teams VALUES (1, 'Dynamo Kyiv', 'Kyiv', 'Valeriy Lobanovskyi Dynamo Stadium', 'Oleksandr Shovkovskyi');
INSERT INTO teams VALUES (2, 'Manchester City', 'Manchester', 'Etihad', 'Erik ten Hag');
INSERT INTO teams VALUES (3, 'Real Madrid', 'Madrid', 'Santiago Bernabeu Stadium', 'Carlo Ancelotti');
INSERT INTO teams VALUES (4, 'Liverpool FC', 'Liverpool', 'Anfield', 'Jurgen Klopp');

INSERT INTO players VALUES (1, 'John', 2, '2010-01-01', 'Ukrainian', 'defend', '3');
INSERT INTO players VALUES (2, 'Ben', 4, '2013-12-01', 'British', 'attack', '56');
INSERT INTO players VALUES (3, 'Mike', 2, '2000-01-29', 'Spanish', 'defend', '12');
INSERT INTO players VALUES (4, 'Brian', 1, '1998-10-01', 'American', 'attack', '9');
-- fetch some values
SELECT * FROM teams WHERE city = 'Kyiv'

SELECT COUNT teams FROM goals GROUP
join
top 3 from exact team

SELECT p.id, p.name, p.team_id, COUNT(g.player_id) AS goals_scored
FROM players p
LEFT JOIN goals g ON p.id = g.player_id
WHERE p.team_id = (SELECT id FROM teams WHERE team_name = 'YourTeamName')
GROUP BY p.id, p.name, p.team_id
ORDER BY goals_scored DESC
LIMIT 3;*/

-- Inserting data into the 'teams' table
INSERT INTO teams
(id, team_name, city, stadium, manager) VALUES
                                            (1, 'Manchester United', 'Manchester', 'Old Trafford', 'Ole Gunnar Solskjaer'),
                                            (2, 'Liverpool FC', 'Liverpool', 'Anfield', 'Jurgen Klopp'),
                                            (3, 'FC Barcelona', 'Barcelona', 'Camp Nou', 'Ronald Koeman'),
                                            (4, 'Real Madrid', 'Madrid', 'Santiago Bernabeu', 'Carlo Ancelotti');

-- Inserting data into the 'players' table
INSERT INTO players (id, name, birthday, nationality, position, number) VALUES
                                                                            (1, 'Cristiano Ronaldo', '1985-02-05', 'Portuguese', 'Forward', 7),
                                                                            (2, 'Lionel Messi', '1987-06-24', 'Argentine', 'Forward', 10),
                                                                            (3, 'Virgil van Dijk', '1991-07-08', 'Dutch', 'Defender', 4),
                                                                            (4, 'Mo Salah', '1992-06-15', 'Egyptian', 'Forward', 11),
                                                                            (5, 'Sergio Ramos', '1986-03-30', 'Spanish', 'Defender', 4),
                                                                            (6, 'Kevin De Bruyne', '1991-06-28', 'Belgian', 'Midfielder', 17),
                                                                            (7, 'Antoine Griezmann', '1991-03-21', 'French', 'Forward', 7),
                                                                            (8, 'Sadio Mane', '1992-04-10', 'Senegalese', 'Forward', 10);

-- Inserting data into the 'player_team_pairs' table
INSERT INTO player_team_pairs (team_id, player_id) VALUES
                                                       (1, 1),
                                                       (1, 3),
                                                       (1, 6),
                                                       (1, 8),
                                                       (2, 2),
                                                       (2, 4),
                                                       (2, 5),
                                                       (2, 7),
                                                       (3, 1),
                                                       (3, 2),
                                                       (3, 3),
                                                       (3, 4),
                                                       (4, 5),
                                                       (4, 6),
                                                       (4, 7),
                                                       (4, 8);

-- Inserting data into the 'seasons' table
INSERT INTO seasons (id, name) VALUES
                                   (1, '2023/2024'),
                                   (2, '2024/2025');

-- Inserting data into the 'leagues' table
INSERT INTO leagues (id, name) VALUES
                                   (1, 'Premier League'),
                                   (2, 'La Liga');

-- Inserting data into the 'match_days' table for Season 1 and League 1
INSERT INTO match_days (id, season_id, league_id, day_number) VALUES
                                                                  (1, 1, 1, 1),
                                                                  (2, 1, 1, 2),
                                                                  (3, 1, 1, 3),
                                                                  (4, 1, 1, 4),
                                                                  (5, 1, 1, 5);

-- Inserting data into the 'match_days' table for Season 2 and League 2
INSERT INTO match_days (id, season_id, league_id, day_number) VALUES
                                                                  (6, 2, 2, 1),
                                                                  (7, 2, 2, 2),
                                                                  (8, 2, 2, 3),
                                                                  (9, 2, 2, 4),
                                                                  (10, 2, 2, 5);

-- Inserting data into the 'matches' table for Season 1 and League 1
INSERT INTO matches
(id, title, date_time, venue, home_team_id, away_team_id, match_day_id, home_score, away_score) VALUES
                                                                                                    (1, 'Manchester United vs Liverpool', '2023-09-20 15:00:00', 'Old Trafford', 1, 2, 1, 2, 1),
                                                                                                    (2, 'FC Barcelona vs Real Madrid', '2023-09-21 16:00:00', 'Camp Nou', 3, 4, 1, 1, 1),
                                                                                                    (3, 'Liverpool FC vs FC Barcelona', '2023-10-01 14:30:00', 'Anfield', 2, 3, 2, 0, 2),
                                                                                                    (4, 'Real Madrid vs Manchester United', '2023-10-02 18:00:00', 'Santiago Bernabeu', 4, 1, 2, 1, 1),
                                                                                                    (5, 'Liverpool FC vs Real Madrid', '2023-10-12 17:30:00', 'Anfield', 2, 4, 3, 2, 0);

-- Inserting data into the 'matches' table for Season 2 and League 2
INSERT INTO matches
(id, title, date_time, venue, home_team_id, away_team_id, match_day_id, home_score, away_score) VALUES
                                                                                                    (6, 'Manchester United vs FC Barcelona', '2024-09-18 15:00:00', 'Old Trafford', 1, 3, 6, 0, 1),
                                                                                                    (7, 'Real Madrid vs Liverpool FC', '2024-09-19 16:00:00', 'Santiago Bernabeu', 4, 2, 6, 2, 0),
                                                                                                    (8, 'FC Barcelona vs Manchester United', '2024-10-01 14:30:00', 'Camp Nou', 3, 1, 7, 1, 1),
                                                                                                    (9, 'Liverpool FC vs Real Madrid', '2024-10-02 18:00:00', 'Anfield', 2, 4, 7, 1, 0),
                                                                                                    (10, 'Real Madrid vs FC Barcelona', '2024-10-12 17:30:00', 'Santiago Bernabeu', 4, 3, 8, 0, 1);

-- Inserting data into the 'goals' table
INSERT INTO goals (id, match_id, player_id, team_id, goal_time, additional_time) VALUES
                                                                                     (1, 1, 1, 1, 30, 5),
                                                                                     (2, 1, 2, 2, 40, 0),
                                                                                     (3, 2, 3, 3, 60, 0),
                                                                                     (4, 3, 3, 3, 75, 0),
                                                                                     (5, 4, 5, 4, 15, 5),
                                                                                     (6, 5, 4, 2, 20, 0),
                                                                                     (7, 6, 3, 3, 60, 0),
                                                                                     (8, 7, 8, 2, 5, 5),
                                                                                     (9, 8, 6, 3, 35, 0),
                                                                                     (10, 9, 7, 4, 60, 0),
                                                                                     (11, 10, 3, 3, 10, 0);

-- Inserting data into the 'standings' table
INSERT INTO standings (match_day_id, team_id, points, won, drawn, lost, goals_for, goals_against) VALUES
                                                                                                      (1, 1, 3, 1, 0, 0, 2, 1),
                                                                                                      (1, 2, 0, 0, 0, 1, 1, 2),
                                                                                                      (1, 3, 1, 0, 1, 0, 1, 1),
                                                                                                      (1, 4, 3, 1, 0, 0, 1, 0),
                                                                                                      (2, 1, 0, 0, 0, 1, 0, 2),
                                                                                                      (2, 2, 3, 1, 0, 0, 2, 0),
                                                                                                      (2, 3, 3, 1, 0, 0, 2, 0),
                                                                                                      (2, 4, 0, 0, 0, 1, 0, 1),
                                                                                                      (3, 1, 0, 0, 0, 1, 0, 2),
                                                                                                      (3, 2, 3, 1, 0, 0, 2, 0),
                                                                                                      (3, 3, 0, 0, 0, 1, 0, 1),
                                                                                                      (3, 4, 3, 1, 0, 0, 1, 0),
                                                                                                      (4, 1, 3, 1, 0, 0, 2, 1),
                                                                                                      (4, 2, 1, 0, 1, 0, 2, 2),
                                                                                                      (4, 3, 0, 0, 0, 1, 1, 2),
                                                                                                      (4, 4, 3, 1, 0, 0, 1, 0),
                                                                                                      (5, 1, 3, 1, 0, 0, 2, 1),
                                                                                                      (5, 2, 0, 0, 0, 1, 1, 2),
                                                                                                      (5, 3, 1, 0, 1, 0, 1, 1),
                                                                                                      (5, 4, 3, 1, 0, 0, 2, 0),
                                                                                                      (6, 1, 1, 0, 1, 0, 1, 1),
                                                                                                      (6, 2, 3, 1, 0, 0, 2, 0),
                                                                                                      (6, 3, 0, 0, 0, 1, 0, 1),
                                                                                                      (6, 4, 3, 1, 0, 0, 1, 0),
                                                                                                      (7, 1, 3, 1, 0, 0, 2, 0),
                                                                                                      (7, 2, 0, 0, 0, 1, 0, 1),
                                                                                                      (7, 3, 3, 1, 0, 0, 2, 0),
                                                                                                      (7, 4, 0, 0, 0, 1, 0, 2),
                                                                                                      (8, 1, 0, 0, 0, 1, 1, 2),
                                                                                                      (8, 2, 3, 1, 0, 0, 2, 0),
                                                                                                      (8, 3, 3, 1, 0, 0, 2, 0),
                                                                                                      (8, 4, 0, 0, 0, 1, 0, 1),
                                                                                                      (9, 1, 0, 0, 1, 0, 1, 1),
                                                                                                      (9, 2, 3, 1, 0, 0, 2, 0),
                                                                                                      (9, 3, 0, 0, 0, 1, 0, 1),
                                                                                                      (9, 4, 3, 1, 0, 0, 1, 0),
                                                                                                      (10, 1, 1, 0, 1, 0, 1, 1),
                                                                                                      (10, 2, 0, 0, 0, 1, 1, 2),
                                                                                                      (10, 3, 3, 1, 0, 0, 2, 0),
                                                                                                      (10, 4, 0, 0, 1, 0, 1, 1);


-- adding insert to use for delete
-- Inserting additional data into the 'teams' table
INSERT INTO teams (id, team_name, city, stadium, manager) VALUES
                                                              (DEFAULT, 'Bayern Munich', 'Munich', 'Allianz Arena', 'Julian Nagelsmann'),
                                                              (DEFAULT, 'Juventus', 'Turin', 'Allianz Stadium', 'Massimiliano Allegri');

-- Inserting additional data into the 'players' table
INSERT INTO players (id, name, birthday, nationality, position, number) VALUES
                                                                            (DEFAULT, 'Robert Lewandowski', '1988-08-21', 'Polish', 'Forward', 9),
                                                                            (DEFAULT, 'Kylian Mbappe', '1998-12-20', 'French', 'Forward', 7),
                                                                            (DEFAULT, 'Neymar Jr', '1992-02-05', 'Brazilian', 'Forward', 10),
                                                                            (DEFAULT, 'Eden Hazard', '1991-01-07', 'Belgian', 'Forward', 7);
-- Inserting data into the 'player_team_pairs' table for new teams
INSERT INTO player_team_pairs (team_id, player_id) VALUES
                                                       (5, 9), -- Bayern Munich: Robert Lewandowski
                                                       (5, 10), -- Bayern Munich: Kylian Mbappe
                                                       (5, 11), -- Bayern Munich: Neymar Jr
                                                       (5, 12), -- Bayern Munich: Eden Hazard
                                                       (6, 13), -- Juventus: Robert Lewandowski
                                                       (6, 14), -- Juventus: Kylian Mbappe
                                                       (6, 15), -- Juventus: Neymar Jr
                                                       (6, 16); -- Juventus: Eden Hazard

-- Inserting data into the 'standings' table for new teams
-- You may need to adjust match_day_id, points, won, drawn, lost, goals_for, and goals_against according to your dataset
INSERT INTO standings (match_day_id, team_id, points, won, drawn, lost, goals_for, goals_against) VALUES
                                                                                                      (1, 5, 0, 0, 0, 0, 0, 0), -- Bayern Munich
                                                                                                      (1, 6, 0, 0, 0, 0, 0, 0); -- Juventus

SELECT m.title, m.date_time, m.venue, th.team_name AS home_team, ta.team_name AS away_team
FROM matches m
         INNER JOIN teams th ON m.home_team_id = th.id
         INNER JOIN teams ta ON m.away_team_id = ta.id;

SELECT p.name, t.team_name, m.title, COUNT(g.player_id) AS goals_scored
FROM players p
         JOIN goals g ON p.id = g.player_id
         JOIN player_team_pairs pt ON p.id = pt.player_id
         JOIN teams t ON pt.team_id = t.id
         JOIN matches m ON g.match_id = m.id
WHERE t.id = (SELECT id FROM teams WHERE team_name = 'Liverpool FC')
GROUP BY p.id, p.name, t.id, m.id
ORDER BY goals_scored DESC
LIMIT 3;


SELECT p.name, p.birthday, p.nationality, p.position, p.number
FROM players p
         JOIN player_team_pairs pt ON p.id = pt.player_id
         JOIN teams t ON pt.team_id = t.id
WHERE t.team_name = 'Manchester United';


SELECT p.name, m.title, m.date_time, t.team_name AS opponent, g.goal_time, g.additional_time
FROM matches m
         JOIN goals g ON m.id = g.match_id
         JOIN players p ON g.player_id = p.id
         JOIN teams t ON g.team_id = t.id
WHERE p.name = 'Lionel Messi';

/*SELECT
    m.title AS match_title,
    t.team_name AS scoring_team,
    t_opponent.team_name AS opposing_team,
    g.additional_time
FROM goals g
         JOIN teams t ON g.team_id = t.id
         JOIN matches m ON g.match_id = m.id
         JOIN teams t_opponent ON
    (m.home_team_id = t_opponent.id AND g.team_id != m.home_team_id) OR
    (m.away_team_id = t_opponent.id AND g.team_id != m.away_team_id)
WHERE g.additional_time > 0;*/

-- prev one rewritten with a subquery
SELECT m.title AS match_title,
       t.team_name AS scoring_team,
       (SELECT team_name FROM teams WHERE
           (m.home_team_id = teams.id AND g.team_id != m.home_team_id) OR
           (m.away_team_id = teams.id AND g.team_id != m.away_team_id)) AS opposing_team,
       g.additional_time
FROM goals g
         JOIN teams t ON g.team_id = t.id
         JOIN matches m ON g.match_id = m.id
WHERE g.additional_time > 0;

-- статистика по гравцям які забивають у себе вдома

SELECT *
FROM teams
WHERE city = (SELECT city FROM players WHERE name = 'Lionel Messi');


-- = with non-correlated subqueries result
-- it selects the team that has the most victories
SELECT
    t.team_name
FROM
    teams t
WHERE
    t.id = (
        SELECT team_id
        FROM standings s
        WHERE s.won = (
            SELECT MAX(s.won)
            FROM standings s
        )
    LIMIT 1
    );


-- IN with non-correlated subqueries result
-- it selects teams that have scored more than the average
SELECT
    t.team_name
FROM
    teams t
WHERE
    id IN (SELECT DISTINCT s.team_id
           FROM standings s
           GROUP BY s.team_id
           HAVING SUM(s.points) > (SELECT AVG(total_points)
                                   FROM (SELECT SUM(s.points) AS total_points
                                         FROM standings s
                                         GROUP BY s.team_id) AS avg_points
           )
    );