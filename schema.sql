-- create project schema
drop schema if exists NBA;
create schema if not exists NBA DEFAULT CHARACTER SET utf8 ;
use NBA; 

-- DDL: create project table
-- player info
drop table if exists player;
create table if not exists player(
    PLAYER_ID int NOT NULL auto_increment,
    PLAYER_NAME varchar(255),
    DRAFT_YEAR year,
    COUNTRY varchar(20),
    GP int, -- Games played throughout the season
    PTS float, -- Average number of points scored
    REB float, -- Average number of rebounds grabbed
    AST float, -- Average number of assists distributed
    NET_RATING float, -- Team's point differential per 100 possessions while the player is on the court
    OREB_PCT float, -- Percentage of available offensive rebounds the player grabbed while he was on the floor
    DREB_PCT float, -- Percentage of available defensive rebounds the player grabbed while he was on the floor
    USG_PCT float, -- Percentage of team plays used by the player while he was on the floor (FGA + Possession Ending FTA + TO) / POSS)
    TS_PCT float, -- Measure of the player's shooting efficiency that takes into account free throws, 2 and 3 point shots 
    AST_PCT float, -- Percentage of teammate field goals the player assisted while he was on the floor
    PRIMARY KEY(PLAYER_ID)
);

alter table `player` AUTO_INCREMENT=0;

-- team info
drop table if exists team;
create table if not exists team(
    TEAM_ID int NOT NULL auto_increment,
    TEAM_NAME varchar(255),
    TEAM_ABBR char(3),
    EW_LOCATION char(4),
    DIVISION varchar(20),
    TEAM_LOCATION varchar(255),
    PRIMARY KEY(TEAM_ID)
);

-- game info
drop table if exists game;
create table if not exists game(
    GAME_ID int NOT NULL auto_increment,
    GAME_DATE date,
    HOST_TEAM_ID int, -- ID of the home team
    VISITOR_TEAM_ID int, -- ID of the visitor team
    SEASON year, -- Season when the game occured
    PTS_HOME int, -- Number of points scored by home team
    FG_PCT_HOME float, -- Field Goal Percentage home team
    FT_PCT_HOME float, -- Free Throw Percentage of the home team
    FG3_PCT_HOME float, -- Three Point Percentageof the home team
    AST_HOME int, -- Assists of the home team
    REB_HOME int, -- Rebounds of the home team
    PTS_AWAY int, -- Number of points scored by away team
    FG_PCT_AWAY float, -- Field Goal Percentage away team
    FT_PCT_AWAY float, -- Free Throw Percentage of the away team
    FG3_PCT_AWAY float, -- Three Point Percentage of the away team
    AST_AWAY int, -- Assists of the away team
    REB_AWAY int, -- Rebounds of the away team
    HOME_TEAM_WIN tinyint, -- 0/1 If home team won the game
    PRIMARY KEY(GAME_ID),
    FOREIGN KEY(HOST_TEAM_ID) REFERENCES team(TEAM_ID),
    FOREIGN KEY(VISITOR_TEAM_ID) REFERENCES team(TEAM_ID)
);

-- player info with specific season
drop table if exists player_season_info;
create table if not exists player_season_info(
    PLAYER_ID int NOT NULL auto_increment,
    SEASON year,
    TEAM_ID int, 
    PLAYER_AGE INT,
    PRIMARY KEY(PLAYER_ID, SEASON, TEAM_ID),
    FOREIGN KEY(PLAYER_ID) REFERENCES player(PLAYER_ID),
    FOREIGN KEY(TEAM_ID) REFERENCES team(TEAM_ID)
);

-- team info with specific season
drop table if exists team_season_info;
create table if not exists team_season_info(
    TEAM_ID int NOT NULL auto_increment,
    SEASON year,
    GP int, -- game number which the team play
    W int, -- win count 
    L int, -- lose count
    PRIMARY KEY(TEAM_ID, SEASON),
    FOREIGN KEY(TEAM_ID) REFERENCES team(TEAM_ID)
);

-- game info with specific season
drop table if exists game_player_info;
create table if not exists game_player_info(
    GAME_ID int NOT NULL auto_increment,
    TEAM_ID int, 
    PLAYER_ID int,
    PLAYER_POSITION varchar(1),
    MIN time,
    FGM int, -- Field Goals Made
    FGA int, -- Field Goals Attempted
    FG_PCT float, -- Field Goal Percentage
    FG3M int, -- Three Pointers Made
    FG3A int, -- Three Pointers Attempted
    FG3_PCT float, -- Three Point Percentage
    FTM int, -- Free Throws Made
    FTA int, -- Free Throws Attempted
    FT_PCT float, -- Free Throw Percentage
    OREB int, -- Offensive Rebounds
    DREB int, -- Defensive Rebounds
    REB int, -- Rebounds
    AST int,  -- Assists
    STL int, -- Steals
    BLK int, -- Blocked shots
    TO_NUM int, -- Turnovers
    PF int, -- Personnal Foul
    PTS int, -- Number of points scored by the player
    PLUS_MINUS int, -- Plus - Minus
    PRIMARY KEY(GAME_ID, PLAYER_ID),
    FOREIGN KEY(GAME_ID) REFERENCES game(GAME_ID),
    FOREIGN KEY(PLAYER_ID) REFERENCES player(PLAYER_ID),
    FOREIGN KEY(TEAM_ID) REFERENCES team(TEAM_ID)
);

-- insert data into DB from csv file name under "/data"
-- FK constraint:
-- player: 2493
-- team: 30
-- game: 26109 -> 26080
-- player_season_info: 3159 -> 3047
-- team_season_info: 150 -> 150
-- game_player_info: 668628 -> 652440