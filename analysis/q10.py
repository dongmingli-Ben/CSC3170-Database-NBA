import mysql.connector
import matplotlib.pyplot as plt
import requests

season = list()
PTS = list()
AST = list()
TRB = list()
try:
    resp = requests.get('http://47.242.150.253:39005/query',
                        params={
                            'query': "select season, pts, ast, trb from player_season_info where player_id = 1495"
                        })
    gram = 0
    exec("gram = " + resp.text)
    for x in gram["content"]:
        # print("season = ", row[0])
        # print("PTS = ", row[1])
        # print("AST = ", row[2])
        # print("TRB = ", row[3])
        season.append(int(x["season"]))
        PTS.append(float(x["pts"]))
        AST.append(float(x["ast"]))
        TRB.append(float(x["trb"]))
            
    plt.plot(season, PTS, label='Points')
    plt.plot(season, AST, label='Assists')
    plt.plot(season, TRB, label='Rebounds')
    plt.xlabel('Season')
    plt.ylabel('Stats')
    plt.title('LeBron James Stats over Seasons')
    plt.xticks(range(min(season), max(season) + 1))
    plt.legend()
    plt.show()
        
except mysql.connector.Error as e:
    print("Error reading data from MySQL table", e)
