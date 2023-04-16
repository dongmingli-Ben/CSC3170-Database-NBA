# NBA 数据

## 任务与分工

- 数据清理：

- 提出数据分析问题，写数据库和分析的代码：余加阳，黄颖仪，李东明

- 写 ppt：

下一次 meet 时间：4.15 10 am

## ER Diagram

![image](assets/er-diagram-0411.jpg)

## 数据导入

需要处理原始数据中的空值：

```bash
python prepare_data.py
```

需要先安装 `pandas` (`pip install pandas`).

然后使用 workbench 导入数据(`xxx_null.csv`)，导入时间比较长。

Note: `PLAYER_POSITION`在 player_season_info 中删除，加入到 game_player_info 中，对应的 player_season_info.csv 要自行去除相应的字段。

## Potential Analytical Questions

- Find the top 10 players in terms of points per game (PPG) for the 2021 season

- Calculate the average field goal percentage (FG%) for each team for the 2021 season

- Find the player with the highest usage percentage (USG%) for each team in the 2021 season

- Calculate the average points per game (PPG) and rebounds per game (RPG) for each player position for the 2021 season

- Find the top 10 players in terms of net rating (NET_RATING) for the 2021 season

- Calculate the number of wins and losses for each team in the 2021 season

- Find the player with the highest field goal percentage (FG%) for each position in the 2021 season

- Are teams more likely to win when they are the host? If so, by how much?

- For a specific team, how does its performance change over seasons? You may use graphs to illustrate.

- For a specific player, how does his performance change over seasons? You may use graphs to illustrate.

## Requirements

1. Analyze the requirements of the organization
2. Identify the relevant entities, attributes, and relationships together with any constraints and properties
3. Produce an E-R diagram for the database
4. Convert the E-R diagrams to relational schemas (clearly indicating the primary keys, foreign keys, functional and/or multivalued dependencies, as well as justifying that your designs are in good, normalized form)
5. Populate the schemas with a reasonable amount of realistic data
6. Produce sample SQL queries on these relations that are used for practical daily operations and activities
7. Produce sample SQL queries on these relations which are of an analytic or data mining nature (this part is optional and carries extra bonus points of up to 8% of the total project mark)
8. Suggest which data fields of the relational schemas should be indexed or hashed, and explain your decision
9. Implement 4 to 6 (and possibly 7) of the above.

## Deadlines

- Apr 14: submit group info to lead TA
- Apr 21: check presentation schedule
- Apr 23: COMPELETE code, slides, presentation!!!
- Apr 24/26: presentation
- May 9: submit report

## Next meeting

Apr 19, 8pm
