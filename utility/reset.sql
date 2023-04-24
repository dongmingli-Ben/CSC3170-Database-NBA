source utility/drop_triggers.sql;
DELETE FROM team_season_info WHERE SEASON >= 2023;
DELETE FROM game WHERE SEASON >= 2023;
DELETE FROM player_season_info WHERE SEASON >= 2023;
source trigger.sql;