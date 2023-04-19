import pandas as pd
import matplotlib.pyplot as plt

# 读取数据
data = pd.read_csv('data/team_season_info_null.csv')

#1610612744 GSW
#1610612760 Thunder
team_a = 1610612744
team_b = 1610612760

# 筛选该球队的比赛数据
team_data = data[(data['TEAM_ID'] == team_a)]
# 计算每个赛季的胜率
season_win_rate = team_data['WIN%']
print(season_win_rate)


# 绘制折线图
plt.plot(team_data['SEASON'], season_win_rate.values[::-1], marker="o")
plt.xlabel('Season')
plt.ylabel('Win Rate')
plt.title('GSW Win Rate over Seasons')
plt.xticks(team_data['SEASON'], [2021, 2020, 2019, 2018, 2017])
plt.show()

team_data = data[(data['TEAM_ID'] == team_b)]
# 计算每个赛季的胜率
season_win_rate = team_data['WIN%']
print(season_win_rate)


# 绘制折线图
plt.plot(team_data['SEASON'], season_win_rate.values[::-1], marker="o")
plt.xlabel('Season')
plt.ylabel('Win Rate')
plt.title('Thunder Win Rate over Seasons')
plt.xticks(team_data['SEASON'], [2021, 2020, 2019, 2018, 2017])
plt.show()