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
-- How could we update the metrics in player_season_info after insert on game_player_info?
-- if 1) Could not solve --> delete it
DELIMITER $$
CREATE TRIGGER update_player_season_info AFTER INSERT ON game_player_info
FOR EACH ROW
BEGIN
    DECLARE player_season_id INT;
    DECLARE player_season_count INT;
    DECLARE team_id DATE;
    DECLARE season YEAR;

    SET @season := (SELECT season from game where game.GAME_ID=NEW.GAME_ID);
    SET @player_season_count := SELECT COUNT(*) FROM player_season_info WHERE player_id = NEW.player_id;

    IF player_season_count > 0 THEN
            UPDATE player_season_info SET
            ....?????
        WHERE PLAYER_ID = NEW.PLAYER_ID AND TEAM_ID = NEW.TEAM_ID AND season = @season;
    ELSE
        INSERT INTO player_season_info (player_id, team_id, ......)
        VALUES(
            NEW.player_id,
            NEW.team_id,
            @season,
            ...........???
        )
    END IF;
END; $$
DELIMITER ;

-- update team_season after insertion of player_game record
-- if exist: update
-- otherwise: insert
-- How could we update the metrics in player_season_info after insert on game_player_info?
-- if 1) Could not solve --> delete it
DELIMITER $$
CREATE TRIGGER update_team_season_info AFTER INSERT ON game_player_info
FOR EACH ROW
BEGIN
    DECLARE season_id INT;
    DECLARE team_id INT;
    
    ????
END; $$
DELIMITER ;









