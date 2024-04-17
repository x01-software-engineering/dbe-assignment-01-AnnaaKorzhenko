# Football database
>This database stores information about players, teams, matches and standings through different seasons and leagues!

It allows you to easily get data about player-team pairs or? for example, quickly get to know who has won yesterday's match.
It gives opportunities to view statistics, top players and see counted data about total scores of each player or team.

## Installing / Getting started

First of all, you will need a server. In this project I used Docker Desktop for connecting to my database.

1. Open Docker Desktop and activate your database
2. Open Rider project (or any other IDE)
3. Go to pa1/pa1schema and copy the code into console

```shell
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

CREATE TABLE players (...);

CREATE TABLE player_team_pairs (...);

CREATE TABLE seasons (...);

CREATE TABLE leagues (...);

CREATE TABLE match_days (...);

CREATE TABLE matches (...);

CREATE TABLE goals (...);

CREATE TABLE standings (...);
```

Here we are creating the schema and the corresponding tables.

### Additional instructions

To complete creating, select the whole piece of code and press "Run" in the console.

## Structure

You can see all the completed work in project files:

```shell
pa1/
    pa1schema.sql # schema building
    pa1queries.sql # basic CRUD operations
pa2/
    pa2queries.sql # more complicated queries
pa3/
    pa3subqueries.sql # correlated and non-correlated subqueries
pa4/
    pa4procedures.sql # IN, OUT, INOUT procedures
    pa4executions.sql # calling the procedures to see result
pa5/
    pa5views.sql # view
```

Search for any part of the work you are interested in.

### Building

If your project needs some additional steps for the developer to build the
project after some code changes, state them here:

```shell
./configure
make
make install
```

Here again you should state what actually happens when the code above gets
executed.

### Usage

Once you find part of code you are interested in, copy it to the console and run it same as before.

```shell
# create
DELIMITER &&

CREATE PROCEDURE get_team_info_sproc (IN teamName VARCHAR(255))
BEGIN
    SELECT 1 FROM teams WHERE team_name = teamName;
END&&
 
DELIMITER ;

# execute
SET @teamName = 'Real Madrid';
CALL get_team_info_sproc(@teamName);
```

And again, you firstly need to create the procedure and then execute it.

## Features

Main points about the database:
* Teams and players are in many-to-many relationship
* Primary keys are always ID
* Each match has id + title, but in addition info about league, season and match day, which makes them unique. Still it is possible that the table could have few matches on the same day.


## Contributing

Thank you for paying attention! You can use this database structure for your own events to record and effectively store data about tournaments and competitions, both in football and any similarly organised events.

## Links

- Repository: https://github.com/x01-software-engineering/dbe-assignment-01-AnnaaKorzhenko
- Assignment 1: https://github.com/x01-software-engineering/dbe-assignment-01-AnnaaKorzhenko/commit/c65dba41dd63b5dd33fbd7f29f2854b96f7ff7fe
- Assignment 2: https://github.com/x01-software-engineering/dbe-assignment-01-AnnaaKorzhenko/commit/9e20871d0cd026e57c0741306fccd79f3dbc9eef
- Assignment 3: https://github.com/x01-software-engineering/dbe-assignment-01-AnnaaKorzhenko/commit/3f08fd7b4b115aeb520e753efb21dc1cc8330f97
- Assignment 4: https://github.com/x01-software-engineering/dbe-assignment-01-AnnaaKorzhenko/commit/b953b4327e9b2678c1d165fad5d169b9cb11058d
- Assignment 5: https://github.com/x01-software-engineering/dbe-assignment-01-AnnaaKorzhenko/commit/803f76449213cec2ee401c90ffb649466fa9eec1
- Research presentation: https://www.canva.com/design/DAGAg8yObMU/-IQj_pvVG_EVzlKqiu4nJw/edit?utm_content=DAGAg8yObMU&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton
