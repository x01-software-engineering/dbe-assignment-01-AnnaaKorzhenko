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