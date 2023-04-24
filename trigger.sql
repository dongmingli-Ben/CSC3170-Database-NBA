-- -- output messages from triggers
-- DROP TABLE IF EXISTS logger;
-- CREATE TABLE logger (
--     ID  BIGINT PRIMARY KEY AUTO_INCREMENT,
--     MSG VARCHAR(500)
-- );

-- check duplicate insert into table: player
DELIMITER $$
CREATE TRIGGER `check_player_duplicate` BEFORE INSERT ON `player` FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM player WHERE player_name = NEW.player_name AND draft_year = NEW.draft_year AND country = NEW.country) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate record found!';
    END IF;
END; $$
DELIMITER ;

-- check duplicate insert into table: team
DELIMITER $$
CREATE TRIGGER before_team_insert
BEFORE INSERT ON team
FOR EACH ROW
BEGIN
    IF EXISTS(SELECT * FROM team WHERE TEAM_NAME = NEW.TEAM_NAME) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot insert team record: team name already exists';
    END IF;
END; $$
DELIMITER ;

-- check duplicate insert into table: game
DELIMITER $$
CREATE TRIGGER prevent_duplicate_game_insert
BEFORE INSERT ON game
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1 FROM game
    WHERE game_date = NEW.game_date
      AND host_team_id = NEW.host_team_id
      AND visitor_team_id = NEW.visitor_team_id
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate game record';
  END IF;
END; $$
DELIMITER ;

-- update player_season after insert a player_game record
-- if exist: update
-- otherwise: insert
DELIMITER $$
CREATE TRIGGER update_player_season_info AFTER INSERT ON game_player_info
FOR EACH ROW
BEGIN
    DECLARE player_season_count INT;
    DECLARE game_count INT;
    DECLARE new_season YEAR;

    -- INSERT INTO logger(MSG) VALUES('invoking update_player_season_info');
    SET @new_season := (SELECT game.season from game where game.GAME_ID=NEW.GAME_ID limit 1);
    SET @game_count := (SELECT COUNT(*) from game where game.GAME_ID=NEW.GAME_ID);
    SET @player_season_count := (SELECT COUNT(*) FROM player_season_info WHERE SEASON = @new_season AND PLAYER_ID=NEW.PLAYER_ID AND TEAM_ID=NEW.TEAM_ID);
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_season_info: GAME_ID = ', NEW.GAME_ID));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_season_info: game_count = ', @game_count));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_season_info: season = ', COALESCE(@new_season, '')));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_season_info: player_season_count = ', @player_season_count));

    IF @player_season_count = 0 THEN
        -- INSERT INTO logger(MSG) VALUES('update_player_season_info: new record');
        INSERT INTO player_season_info(PLAYER_ID, SEASON, TEAM_ID) VALUES(NEW.PLAYER_ID, @new_season, NEW.TEAM_ID);

    END IF;
END; $$
DELIMITER ;

-- update player after insert a player_game record
-- update attributes: there must be a corresponding player in player table
DELIMITER $$
CREATE TRIGGER update_player_info AFTER INSERT ON game_player_info
FOR EACH ROW
BEGIN
    DECLARE _GP INT;
    DECLARE _PTS FLOAT;
    DECLARE _REB FLOAT;
    DECLARE _AST FLOAT;

    -- INSERT INTO logger(MSG) VALUES('invoking update_player_info');
    SET @_GP := (SELECT player.GP from player where player.PLAYER_ID=NEW.PLAYER_ID);
    SET @_PTS := (SELECT player.PTS from player where player.PLAYER_ID=NEW.PLAYER_ID);
    SET @_AST := (SELECT player.AST from player where player.PLAYER_ID=NEW.PLAYER_ID);
    SET @_REB := (SELECT player.REB from player where player.PLAYER_ID=NEW.PLAYER_ID);
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_info: GP = ', COALESCE(@_GP, '')));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_info: PTS = ', COALESCE(@_PTS, '')));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_info: AST = ', COALESCE(@_AST, '')));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_player_info: REB = ', COALESCE(@_REB, '')));

    UPDATE player SET GP=@_GP+1, PTS=(@_PTS*@_GP+NEW.PTS)/(@_GP+1), REB=(@_REB*@_GP+NEW.REB)/(@_GP+1), AST=(@_AST*@_GP+NEW.AST)/(@_GP+1) WHERE PLAYER_ID=NEW.PLAYER_ID;
END; $$
DELIMITER ;

-- update team_season after insertion of player_game record
-- if exist: update
-- otherwise: insert
-- How could we update the metrics in player_season_info after insert on game_player_info?
-- if 1) Could not solve --> delete it
DELIMITER $$
CREATE TRIGGER update_team_season_info AFTER INSERT ON game
FOR EACH ROW
BEGIN
    DECLARE team_season_count INT;
    DECLARE host_team_season_count INT;
    DECLARE visitor_team_season_count INT;
    DECLARE _GP INT;
    DECLARE _W INT;
    DECLARE _L INT;

    -- INSERT INTO logger(MSG) VALUES('invoking update_team_season_info');
    SET @team_season_count := (SELECT COUNT(*) FROM team_season_info WHERE SEASON = NEW.season AND (TEAM_ID=NEW.HOST_TEAM_ID OR TEAM_ID=NEW.VISITOR_TEAM_ID));
    SET @host_team_season_count := (SELECT COUNT(*) FROM team_season_info WHERE SEASON = NEW.season AND TEAM_ID=NEW.HOST_TEAM_ID);
    SET @visitor_team_season_count := (SELECT COUNT(*) FROM team_season_info WHERE SEASON = NEW.season AND TEAM_ID=NEW.VISITOR_TEAM_ID);
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_team_season_info: team_season_count = ', @team_season_count));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_team_season_info: host_team_season_count = ', @host_team_season_count));
    -- INSERT INTO logger(MSG) VALUES(CONCAT('update_team_season_info: visitor_team_season_count = ', @visitor_team_season_count));

    IF @host_team_season_count = 0 THEN
        IF NEW.HOME_TEAM_WIN = 1 THEN
            -- INSERT INTO logger(MSG) VALUES(CONCAT('update_team_season_info: HOME_TEAM_WIN ', NEW.HOST_TEAM_ID, ' ', NEW.SEASON));
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.HOST_TEAM_ID, NEW.SEASON, 1, 1, 0);
        ELSE
            -- INSERT INTO logger(MSG) VALUES(CONCAT('update_team_season_info: HOME_TEAM_LOSS ', NEW.HOST_TEAM_ID, ' ', NEW.SEASON));
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.HOST_TEAM_ID, NEW.SEASON, 1, 0, 1);
        END IF;
    ELSE 
        SET @_GP := (SELECT GP FROM team_season_info WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON);
        SET @_W := (SELECT W FROM team_season_info WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON);
        SET @_L := (SELECT L FROM team_season_info WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON);
        IF NEW.HOME_TEAM_WIN = 1 THEN
            UPDATE team_season_info SET GP=@_GP+1, W=@_W+1 WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON;
        ELSE
            UPDATE team_season_info SET GP=@_GP+1, L=@_L+1 WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON;
        END IF;
    END IF;

    IF @visitor_team_season_count = 0 THEN
        IF NEW.HOME_TEAM_WIN = 1 THEN
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.VISITOR_TEAM_ID, NEW.SEASON, 1, 0, 1);
        ELSE
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.VISITOR_TEAM_ID, NEW.SEASON, 1, 0, 1);
        END IF;
    ELSE 
        SET @_GP := (SELECT GP FROM team_season_info WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON);
        SET @_W := (SELECT W FROM team_season_info WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON);
        SET @_L := (SELECT L FROM team_season_info WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON);
        IF NEW.HOME_TEAM_WIN = 1 THEN
            UPDATE team_season_info SET GP=@_GP+1, L=@_L+1 WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON;
        ELSE
            UPDATE team_season_info SET GP=@_GP+1, W=@_W+1 WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON;
        END IF;
    END IF;

END; $$
DELIMITER ;
