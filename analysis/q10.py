import pandas as pd
import matplotlib.pyplot as plt

# 读取数据
data = pd.read_csv('data/player_season_info_null.csv')

# 选择一个球员
#LeBron James，Stephen Curry，Kevin Durant
player_a = 1495
player_b = 2178
player_c = 1397

# 计算每个赛季的得分、助攻和篮板数
player_data = data[(data['PLAYER_ID'] == player_a)]
player_PTS = player_data['PTS']
player_AST = player_data['AST']
player_TRB = player_data['TRB']
plt.plot(player_data['SEASON'], player_PTS, label='Points')
plt.plot(player_data['SEASON'], player_AST, label='Assists')
plt.plot(player_data['SEASON'], player_TRB, label='Rebounds')
plt.xlabel('Season')
plt.ylabel('Stats')
plt.title('LeBron James Stats over Seasons')
plt.xticks(player_data['SEASON'], [2021, 2020, 2019, 2018, 2017])
plt.legend()
plt.show()

player_data = data[(data['PLAYER_ID'] == player_b)]
player_PTS = player_data['PTS']
player_AST = player_data['AST']
player_TRB = player_data['TRB']
plt.plot(player_data['SEASON'], player_PTS, label='Points')
plt.plot(player_data['SEASON'], player_AST, label='Assists')
plt.plot(player_data['SEASON'], player_TRB, label='Rebounds')
plt.xlabel('Season')
plt.ylabel('Stats')
plt.title('Stephen Curry Stats over Seasons')
plt.xticks(player_data['SEASON'], [2021, 2020, 2019, 2018, 2017])
plt.legend()
plt.show()

player_data = data[(data['PLAYER_ID'] == player_c)]
player_PTS = player_data['PTS']
player_AST = player_data['AST']
player_TRB = player_data['TRB']
plt.plot(player_data['SEASON'], player_PTS, label='Points')
plt.plot(player_data['SEASON'], player_AST, label='Assists')
plt.plot(player_data['SEASON'], player_TRB, label='Rebounds')
plt.xlabel('Season')
plt.ylabel('Stats')
plt.title('Kevin Durant Stats over Seasons')
plt.xticks(player_data['SEASON'], [2021, 2020, 2018, 2017])
plt.legend()
plt.show()