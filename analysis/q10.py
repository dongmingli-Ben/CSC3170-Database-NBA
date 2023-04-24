import mysql.connector
import matplotlib.pyplot as plt
import requests

season = dict()
PTS = dict()
AST = dict()
REB = dict()
PTS_rate = dict()
AST_rate = dict()
REB_rate = dict()
try:
    resp = requests.get('http://175.178.45.209:39005/query',
                        params={
                            'query': "select GAME_id, PTS, AST, REB from game_player_info where player_id = 2178"
                        })
    gram = 0
    exec("gram = " + resp.text.replace("null", "-1"))
    for x in gram["content"]:
        game_id = int(x["GAME_id"])
        resp_ = requests.get('http://175.178.45.209:39005/query',
                        params={
                            'query': "select season from game where game_ID = " + str(game_id)
                        })
        season_text = 0
        exec("season_text = " + resp_.text)
        season_num = season_text["content"][0]["season"]
        
        if season_num not in season.keys():
            season[season_num] = 1
        else:
            season[season_num] += 1
            
        if season_num not in PTS.keys():
            PTS[season_num] = 0
        if season_num not in AST.keys():
            AST[season_num] = 0
        if season_num not in REB.keys():
            REB[season_num] = 0
        
        if int(x["PTS"]) != -1:
            PTS[season_num] += int(x["PTS"])
            AST[season_num] += int(x["AST"])
            REB[season_num] += int(x["REB"])
        
        if int(x["PTS"]) == -1:
            season[season_num] -= 1
            
    for x in season.keys():
        PTS_rate[x] = PTS[x] /season[x]
        AST_rate[x] = AST[x] /season[x]
        REB_rate[x] = REB[x] /season[x]
    
    plt.plot(PTS_rate.keys(), PTS_rate.values(), label='Points')
    plt.plot(AST_rate.keys(), AST_rate.values(), label='Assists')
    plt.plot(REB_rate.keys(), REB_rate.values(), label='Rebounds')
    plt.xlabel('Season')
    plt.ylabel('Stats')
    plt.title('Stephen Curry Stats over Seasons')
    plt.xticks(range(min(season.keys()), max(season.keys()) + 1))
    plt.legend()
    plt.show()
        
except mysql.connector.Error as e:
    print("Error reading data from MySQL table", e)
