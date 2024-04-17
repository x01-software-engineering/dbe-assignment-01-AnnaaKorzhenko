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
    
    
                                                                                                      
-- ===================================================================================================================================================================================
-- shows info about each match in a readable way (not only id, but also names of the teams)                                                                                                                                
SELECT m.title, m.date_time, m.venue, th.team_name AS home_team, ta.team_name AS away_team
FROM matches m
INNER JOIN teams th ON m.home_team_id = th.id
INNER JOIN teams ta ON m.away_team_id = ta.id;

-- shows info about top 3 players of Liverpool, who have the most scores
SELECT p.name, t.team_name, m.title, COUNT(g.player_id) AS goals_scored
FROM players p
JOIN goals g ON p.id = g.player_id
JOIN player_team_pairs ptp ON p.id = ptp.player_id
JOIN teams t ON ptp.team_id = t.id
JOIN matches m ON g.match_id = m.id
WHERE t.id = (SELECT id FROM teams WHERE team_name = 'Liverpool FC')
GROUP BY p.id, p.name, t.id, m.id
ORDER BY goals_scored DESC
LIMIT 3;

-- shows all the info about players who play for Manchester
SELECT p.name, p.birthday, p.nationality, p.position, p.number
FROM players p
         JOIN player_team_pairs pt ON p.id = pt.player_id
         JOIN teams t ON pt.team_id = t.id
WHERE t.team_name = 'Manchester United';

-- shows info about matches where Messi has scored
SELECT p.name, m.title, m.date_time, t.team_name AS opponent, g.goal_time, g.additional_time
FROM matches m
JOIN goals g ON m.id = g.match_id
JOIN players p ON g.player_id = p.id
JOIN teams t ON g.team_id = t.id
WHERE p.name = 'Lionel Messi';

-- shows info about matches where the goals were scored during additional time
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