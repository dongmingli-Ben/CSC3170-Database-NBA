use NBA; 

-- Find the top 10 players in terms of points per game (PPG) for the 2021 season
SELECT PLAYER_NAME, SUM(ps.PTS*ps.G)/SUM(ps.G) AS PPG
FROM player_season_info as ps, player
WHERE SEASON = 2021 and ps.PLAYER_ID = player.PLAYER_ID
GROUP BY ps.PLAYER_ID
ORDER BY PPG DESC
LIMIT 10;

-- Calculate the average field goal percentage (FG%) for each team for the 2021 season
SELECT `TEAM_NAME`, AVG(FG_PERCENTAGE) AS AVG_FG_PERCENTAGE
FROM team_season_info as ts, team
WHERE SEASON = 2021 and ts.`TEAM_ID` = team.`TEAM_ID`
GROUP BY ts.TEAM_ID
ORDER BY AVG_FG_PERCENTAGE DESC;

-- Find the player with the highest usage percentage (USG%) for each team in the 2021 season
SELECT t.TEAM_ABBR, p.`PLAYER_NAME`, MAX(p.USG_PCT) AS MAX_USG_PCT
FROM player_season_info ps
JOIN player p ON ps.PLAYER_ID = p.PLAYER_ID
JOIN team t ON ps.TEAM_ID = t.TEAM_ID
WHERE ps.SEASON = 2021
GROUP BY ps.TEAM_ID;

-- Calculate the average points per game (PPG) and rebounds per game (RPG) for each player position for the 2021 season
SELECT gpi.PLAYER_POSITION,
       AVG(psi.PTS) AS AVG_PPG,
       AVG(psi.ORB + psi.DRB) AS AVG_RPG
FROM player_season_info psi
JOIN game_player_info gpi ON psi.PLAYER_ID = gpi.PLAYER_ID
WHERE psi.SEASON = 2021 AND gpi.PLAYER_POSITION IS NOT NULL
GROUP BY gpi.PLAYER_POSITION;

-- Find the top 10 players in terms of net rating (NET_RATING)
SELECT p.PLAYER_NAME, p.NET_RATING
FROM player p
ORDER BY p.NET_RATING DESC
LIMIT 10;

-- Calculate the number of wins and losses for each team in the 2021 season
SELECT TEAM_NAME, W, L
FROM team_season_info tsi
JOIN team t ON tsi.TEAM_ID = t.TEAM_ID
WHERE tsi.SEASON = 2021;

-- Find the player with the highest field goal percentage (FG%) for each position in the 2021 season
SELECT gpi.PLAYER_POSITION, p.PLAYER_NAME, MAX(psi.FG_PERCENTAGE) AS MAX_FG_PERCENTAGE
FROM game_player_info gpi
INNER JOIN player p ON gpi.PLAYER_ID = p.PLAYER_ID
INNER JOIN player_season_info psi ON psi.PLAYER_ID = gpi.PLAYER_ID
WHERE psi.SEASON = 2021 AND gpi.PLAYER_POSITION IS NOT NULL
GROUP BY gpi.PLAYER_POSITION;
