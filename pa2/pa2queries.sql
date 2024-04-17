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