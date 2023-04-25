use NBA; 

-- To get the total number of games played by each team in the 2021 season
SELECT t.TEAM_NAME, tse.GP
FROM team t
JOIN team_season_info tse ON t.TEAM_ID = tse.TEAM_ID
WHERE tse.SEASON = '2021'
ORDER BY tse.GP DESC;


-- To get the average points, rebounds, and assists for players from USA
SELECT COUNTRY, AVG(PTS) AS AVG_POINTS, AVG(REB) AS AVG_REBOUNDS, AVG(AST) AS AVG_ASSISTS
FROM player
WHERE COUNTRY = 'USA'
GROUP BY COUNTRY;


-- To get the number of games won by each team in a specific season, along with the total points scored
SELECT t.TEAM_NAME, tgh.W, tgh.PTS_HOME + tgv.PTS_AWAY AS TOTAL_POINTS
FROM team t
JOIN (
    SELECT tse.TEAM_ID, SUM(gh.PTS_HOME) AS PTS_HOME, tse.W
    FROM team_season_info tse
    JOIN game gh ON tse.TEAM_ID = gh.HOST_TEAM_ID
    WHERE gh.SEASON = 2021 AND tse.SEASON = 2021
    GROUP BY tse.TEAM_ID
) tgh ON t.TEAM_ID = tgh.TEAM_ID
JOIN (
    SELECT tse.TEAM_ID, SUM(gv.PTS_AWAY) AS PTS_AWAY, tse.W
    FROM team_season_info tse
    JOIN game gv ON tse.TEAM_ID = gv.VISITOR_TEAM_ID
    WHERE gv.SEASON = 2021 AND tse.SEASON = 2021
    GROUP BY tse.TEAM_ID
) tgv ON t.TEAM_ID = tgv.TEAM_ID
ORDER BY TOTAL_POINTS DESC;


-- To get the top 5 players with the highest points per game in a specific season
SELECT p.PLAYER_NAME, p.PTS AS PPG
FROM player p
JOIN player_season_info psi ON p.PLAYER_ID = psi.PLAYER_ID
JOIN team_season_info tse ON psi.TEAM_ID = tse.TEAM_ID AND psi.SEASON = tse.SEASON
WHERE psi.SEASON = '2021'
ORDER BY PPG DESC
LIMIT 5;


-- To get the total number of games played by each team in a specific season, along with their win-loss record
SELECT t.TEAM_NAME, tse.GP, tse.W, tse.L
FROM team t
JOIN team_season_info tse ON t.TEAM_ID = tse.TEAM_ID
WHERE tse.SEASON = '2021'
ORDER BY tse.GP DESC;


-- To get the average points, rebounds, and assists for players from each country
SELECT COUNTRY, AVG(PTS) AS AVG_POINTS, AVG(REB) AS AVG_REBOUNDS, AVG(AST) AS AVG_ASSISTS
FROM player
GROUP BY COUNTRY;


-- To get the number of games won and lost by a specific team in a specific season
SELECT t.TEAM_NAME, tse.W, tse.L
FROM team t
JOIN team_season_info tse ON t.TEAM_ID = tse.TEAM_ID
WHERE t.TEAM_NAME = 'Los Angeles Lakers' AND tse.SEASON = '2021';
