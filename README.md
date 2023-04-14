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

## Potential Analytical Questions

- Find the top 10 players in terms of points per game (PPG) for the 2022 season

- Calculate the average field goal percentage (FG%) for each team for the 2022 season

- Find the player with the highest usage percentage (USG%) for each team in the 2022 season

- Calculate the average points per game (PPG) and rebounds per game (RPG) for each player position for the 2022 season

- Find the top 10 players in terms of net rating (NET_RATING) for the 2022 season

- Calculate the number of wins and losses for each team in the 2022 season

- Find the player with the highest field goal percentage (FG%) for each position in the 2022 season

- Are teams more likely to win when they are the host? If so, by how much?

- For a specific team, how does its performance change over seasons? You may use graphs to illustrate.

- For a specific player, how does his performance change over seasons? You may use graphs to illustrate.
