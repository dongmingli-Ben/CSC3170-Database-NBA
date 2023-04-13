-- create project schema
drop schema if exists NBA;
create schema if not exists NBA DEFAULT CHARACTER SET utf8;
use NBA; 

-- DDL: create project table
-- player info
drop table if exists player;
create table if not exists player(
    PLAYER_ID int PRIMARY KEY,
    PLAYER_NAME varchar(255),
    COUNTRY varchar(20),
    DRAFT_YEAR year,
    GP int,
    PTS float,
    REB float,
    AST float,
    NET_RATING float,
    OREB_PCT float,
    DREB_PCT float,
    USG_PCT float,
    TS_PCT float,
    AST_PCT float
);

-- player info with specific season
drop table if exists player_season_info;
create table if not exists player_season_info(
    PLAYER_ID int,
    SEASON year,
    TEAM_ABBR char(3),
    PLAYER_POSITION varchar(2),
    PLAYER_AGE INT,
    G int, 
    GS int,
    MP float,
    FG float,
    FGA float,
    FG_PERCENTAGE float,
    3P float,
    3P_PERCENTAGE float,
    2P float,
    2PA float,
    2P_PERCENTAGE float,
    EFG_PERCENTAGE float,
    FT float,
    FTA float,
    FT_PERCENTAGE float,
    ORB float,
    TRB float,
    AST float,
    STL float,
    BLK float,
    TOV float,
    PF float,
    PTS float,
    PRIMARY KEY(PLAYER_ID, SEASON, TEAM_ABBR)
);

-- team info
drop table if exists team;
create table if not exists team(
    TEAM_ID int PRIMARY KEY,
    TEAM_NAME varchar(255),
    TEAM_ABBR char(3),
    EW_LOCATION char(4),
    DIVISION varchar(20),
    TEAM_LOCATION varchar(255)
);

-- team info with specific season
drop table if exists team_season_info;
create table if not exists team_season_info(
    TEAM_ID int,
    SEASON year,
    GP int,
    W int,
    L int,
    WIN_PERCENTAGE float,
    MIN float,
    FGM float,
    FGA float,
    FG_PERCENTAGE float,
    3PM float,
    3P_PERCENTAGE float,
    FTM float,
    FTA float,
    FT_PERCENTAGE float,
    OREB float,
    DREB float,
    REB float,
    AST float,
    TOV float,
    STL float,
    BLK float,
    BLKA float,
    PF float,
    PFD float,
    POSITIVE_NEGATIVE float,
    PRIMARY KEY(TEAM_ID, SEASON)
);

-- game info
drop table if exists game;
create table if not exists game(
    GAME_ID int PRIMARY KEY,
    GAME_DATE date,
    HOST_TEAM_ID int,
    VISITOR_TEAM_ID int,
    SEASON year,
    PTS_HOME int,
    FG_PCT_HOME float,
    FT_PCT_HOME float,
    FG3_PCT_HOME float,
    AST_HOME int,
    REB_HOME int,
    PTS_AWAY int,
    FG_PCT_AWAY float,
    FT_PCT_AWAY float,
    FG3_PCT_AWAY float,
    AST_AWAY int,
    REB_AWAY int,
    HOME_TEAM_WIN tinyint -- 0/1
);

-- game info with specific season
drop table if exists game_player_info;
create table if not exists game_player_info(
    GAME_ID int,
    PLAYER_ID int,
    TEAM_ID int, 
    MIN time,
    FGM int,
    FGA int,
    FG_PCT float,
    FG3M int,
    FG3A int,
    FG3_PCT float,
    FTM int,
    FTA int,
    FT_PCT float,
    OREB int,
    DREB int,
    REB int,
    AST int, 
    STL int,
    BLK int,
    TO_NUM int,
    PF int,
    PTS int,
    PLUS_MINUS int,
    PRIMARY KEY(GAME_ID, PLAYER_ID)
);

-- insert data into DB from csv file name under "data" path
-- perform import by MYSQL workbench table data import wizard


