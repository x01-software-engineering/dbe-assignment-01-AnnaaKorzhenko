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
                         team_id INTEGER,
                         birthday DATE NOT NULL,
                         nationality VARCHAR(255) NOT NULL,
                         position varchar(255),
                         number INTEGER NOT NULL
);

CREATE TABLE matches (
                         id INTEGER PRIMARY KEY,
                         title VARCHAR(255),
                         date_time DATETIME NOT NULL,
                         venue TEXT NOT NULL,
                         home_team_id INTEGER,
                         away_team_id INTEGER,
                         home_score INTEGER NOT NULL,
                         away_score INTEGER NOT NULL,
                         FOREIGN KEY (home_team_id) REFERENCES teams(id),
                         FOREIGN KEY (away_team_id) REFERENCES teams(id)
);

CREATE TABLE goals (
                       match_id INTEGER PRIMARY KEY,
                       player_id INTEGER,
                       team_id INTEGER,
                       FOREIGN KEY (match_id) REFERENCES matches(id),
                       FOREIGN KEY (player_id) REFERENCES players(id),
                       FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE standings (
                           team_id INTEGER PRIMARY KEY,
                           points INTEGER,
                           won INTEGER,
                           drawn INTEGER,
                           lost INTEGER,
                           goals_for INTEGER,
                           goals_against INTEGER,
                           FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- insert some values
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
LIMIT 3;