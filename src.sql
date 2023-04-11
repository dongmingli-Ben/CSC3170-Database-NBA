-- create project schema
create schema if not exists NBA;
use NBA; 

-- create project table
create table if not exists player(
    PLAYER_ID int PRIMARY KEY,
    PLAYER_NAME varchar(255),
    PLAYER_AGE INT,
    PLAYER_HEIGHT float,
    PLAYER_WEIGHT float,
    COUNTRY varchar(20),
    DRAFT_YEAR year,
    DRAFT_ROUND int,
    DRAFT_NUMBER INT, 
    GP int,
    PTS float,
    REB float,
    AST float,
    NET_RATING float,
    OREB_PCT float,
    DREB_PCT float,
    USG_PCT float,
    TS_PCT float,
    AST_PCT float,
    SEASON year -- modify import data
);

create table if not exists player_season_info(
    PLAYER_ID int PRIMARY KEY,
    SEASON year PRIMARY KEY, -- modify import data
    TEAM_ABBR char(3) PRIMARY KEY, -- TO IMPROVE?
    PLAYER_POSITION varchar(2),
    PLAYER_AGE INT, -- redundant
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
    AST float, -- redundant
    STL float,
    BLK float,
    TOV float,
    PF float,
    PTS float -- redundant
);

create table if not exists team(
    TEAM_ID int PRIMARY KEY, -- ??
    TEAM_NAME varchar(255),
    TEAM_ABBR char(3),
    EW_LOCATION char(4),
    DIVISION varchar(20),
    TEAM_LOCATION varchar(255)
);

create table if not exists team_season_info(
    TEAM_ID int PRIMARY KEY,
    SEASON year PRIMARY KEY, -- modify import data
    GP int,
    W int,
    L int,
    WIN_PERCENTAGE float,
    MIN float,
    FGM float,
    FGA float, -- redundant?
    FG_PERCENTAGE float, -- redundant
    3PM float,
    3P_PERCENTAGE float, -- redundant
    FTM float,
    FTA float, -- redundant
    FT_PERCENTAGE float, -- redundant
    OREB float, -- redundant
    DREB float, -- redundant
    REB float, -- redundant
    AST float, -- redundant
    TOV float, -- redundant
    STL float, -- redundant
    BLK float, -- redundant
    BLKA float, -- redundant
    PF float, -- redundant
    PFD float, -- redundant
    POSITIVE_NEGATIVE float -- leave or not?
);


create table if not exists game(
    GAME_ID int PRIMARY KEY, -- ???
    GAME_DATE date,
    -- GAME_STATUS char(5), -- complete or not
    HOST_TEAM_ID int,
    VISITOR_TEAM_ID int,
    SEASON year, -- modify import data
    -- TEAM_ID_HOME int, --modify import data, delete one column
    PTS_HOME int,
    FG_PCT_HOME float,
    FT_PCT_HOME float,
    FG3_PCT_HOME float,
    AST_HOME int,
    REB_HOME int,
    -- TEAM_ID_AWAY int, --modify import data, delete one column?
    PTS_AWAY int,
    FG_PCT_AWAY float,
    FT_PCT_AWAY float,
    FG3_PCT_AWAY float,
    AST_AWAY int,
    REB_AWAY int,
    HOME_TEAM_WIN tinyint -- 0/1
);


create table if not exists game_player_info(
    GAME_ID int PRIMARY KEY, -- ???
    PLAYER_ID int PRIMARY KEY,
    TEAM_ID int, 
    -- TEAM_ABBREVIATION char(3),
    -- TEAM_CITY varchar(35),
    -- NICKNAME varchar(255),
    -- START_POSITION char(1),
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
    PLUS_MINUS int
);


