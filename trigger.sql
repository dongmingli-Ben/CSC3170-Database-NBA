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
    DECLARE season YEAR;

    SET @season := (SELECT season from game where game.GAME_ID=NEW.GAME_ID);
    SET @player_season_count := (SELECT COUNT(*) FROM player_season_info WHERE SEASON = @season AND PLAYER_ID=NEW.PLAYER_ID AND TEAM_ID=NEW.TEAM_ID);

    IF player_season_count = 0 THEN
        INSERT INTO player_season_info(PLAYER_ID, SEASON, TEAM_ID) VALUES(NEW.PLAYER_ID, @season, NEW.TEAM_ID);

    END IF;
END; $$
DELIMITER ;

-- update player after insert a player_game record
-- update attributes: there must be a corresponding player in player table
DELIMITER $$
CREATE TRIGGER update_player_info AFTER INSERT ON game_player_info
FOR EACH ROW
BEGIN
    DECLARE GP INT;
    DECLARE PTS FLOAT;
    DECLARE REB FLOAT;
    DECLARE AST FLOAT;

    SET @GP = (SELECT GP from player where player.PLAYER_ID=NEW.PLAYER_ID);
    SET @PTS = (SELECT PTS from player where player.PLAYER_ID=NEW.PLAYER_ID);
    SET @AST = (SELECT AST from player where player.PLAYER_ID=NEW.PLAYER_ID);
    SET @REB = (SELECT REB from player where player.PLAYER_ID=NEW.PLAYER_ID);

    UPDATE player SET GP=@GP+1, PTS=(@PTS*@GP+NEW.PTS)/(@GP+1), REB=(@REB*@GP+NEW.REB)/(@GP+1), AST=(@AST*@GP+NEW.AST)/(@GP+1) WHERE PLAYER_ID=NEW.PLAYER_ID;
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
    DECLARE GP INT;
    DECLARE W INT;
    DECLARE L INT;

    SET @team_season_count := (SELECT COUNT(*) FROM team_season_info WHERE SEASON = NEW.season AND (TEAM_ID=NEW.HOST_TEAM_ID OR TEAM_ID=NEW.VISITOR_TEAM_ID));
    SET @host_team_season_count := (SELECT COUNT(*) FROM team_season_info WHERE SEASON = NEW.season AND TEAM_ID=NEW.HOST_TEAM_ID);
    SET @visitor_team_season_count := (SELECT COUNT(*) FROM team_season_info WHERE SEASON = NEW.season AND TEAM_ID=NEW.VISITOR_TEAM_ID);

    IF host_team_season_count = 0 THEN
        IF NEW.HOME_TEAM_WIN = 1 THEN
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.HOST_TEAM_ID, NEW.SEASON, 1, 1, 0);
        ELSE
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.HOST_TEAM_ID, NEW.SEASON, 1, 0, 1);
        END IF;
    ELSE 
        SET @GP := (SELECT GP FROM team_season_info WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON);
        SET @W := (SELECT W FROM team_season_info WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON);
        SET @L := (SELECT L FROM team_season_info WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON);
        IF NEW.HOME_TEAM_WIN = 1 THEN
            UPDATE team_season_info SET GP=@GP+1, W=@W+1 WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON;
        ELSE
            UPDATE team_season_info SET GP=@GP+1, L=@L+1 WHERE TEAM_ID=NEW.HOST_TEAM_ID AND SEASON=NEW.SEASON;
        END IF;
    END IF;

    IF visitor_team_season_count = 0 THEN
        IF NEW.HOME_TEAM_WIN = 1 THEN
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.VISITOR_TEAM_ID, NEW.SEASON, 1, 0, 1);
        ELSE
            INSERT INTO team_season_info(TEAM_ID, SEASON, GP, W, L) VALUES(NEW.VISITOR_TEAM_ID, NEW.SEASON, 1, 0, 1);
        END IF;
    ELSE 
        SET @GP := (SELECT GP FROM team_season_info WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON);
        SET @W := (SELECT W FROM team_season_info WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON);
        SET @L := (SELECT L FROM team_season_info WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON);
        IF NEW.HOME_TEAM_WIN = 1 THEN
            UPDATE team_season_info SET GP=@GP+1, L=@L+1 WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON;
        ELSE
            UPDATE team_season_info SET GP=@GP+1, W=@W+1 WHERE TEAM_ID=NEW.VISITOR_TEAM_ID AND SEASON=NEW.SEASON;
        END IF;
    END IF;

END; $$
DELIMITER ;









