-- create indices
CREATE INDEX g_season ON game(SEASON) USING BTREE;
CREATE INDEX ps_season ON player_season_info(SEASON) USING BTREE;
CREATE INDEX ts_season ON team_season_info(SEASON) USING BTREE;
CREATE INDEX gp_position ON gmae_player_info(PLAYER_POSITION) USING HASH;

-- -- drop indices
-- DROP INDEX g_season ON game;
-- DROP INDEX ps_season ON player_season_info;
-- DROP INDEX ts_season ON team_season_info;
-- DROP INDEX gp_position ON gmae_player_info;