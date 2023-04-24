import mysql.connector
import matplotlib.pyplot as plt
import requests

win_persentage = list()
season = list()

try:
    resp = requests.get('http://175.178.45.209:39005/query',
                        params={
                            'query': "select win_percentage, season from team_season_info where TEAM_ID=1610612744"
                        })
    gram = 0
    exec("gram = " + resp.text)
    for x in gram["content"]:
        win_persentage.append(float(x["win_percentage"]))
        season.append(int(x["season"]))
        
    plt.plot(season, win_persentage, marker="o")
    plt.xlabel('Season')
    plt.ylabel('Win_persentage')
    plt.xticks(range(min(season), max(season) + 1))
    plt.show()
        
except mysql.connector.Error as e:
    print("Error reading data from MySQL table", e)
