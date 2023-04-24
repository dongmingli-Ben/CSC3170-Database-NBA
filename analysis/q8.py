import mysql.connector
import matplotlib.pyplot as plt
import requests

team_map = {
    1610612737:"ATL",
    1610612751:"BKN",
    1610612738:"BOS",
    1610612766:"CHA",
    1610612741:"CHI",
    1610612739:"CLE",
    1610612742:"DAL",
    1610612743:"DEN",
    1610612765:"DET",
    1610612744:"GSW",
    1610612745:"HOU",
    1610612754:"IND",
    1610612746:"LAC",
    1610612747:"LAL",
    1610612763:"MEM",
    1610612748:"MIA",
    1610612749:"MIL",
    1610612750:"MIN",
    1610612740:"NOP",
    1610612752:"NYK",
    1610612760:"OKC",
    1610612753:"ORL",
    1610612755:"PHI",
    1610612756:"PHX",
    1610612757:"POR",
    1610612758:"SAC",
    1610612759:"SAS",
    1610612761:"TOR",
    1610612762:"UTA",
    1610612764:"WAS",
}
home_win = dict()
game_win = dict()
rate = dict()

try:
    # connect to the target db: update ip. user, and pwd
    resp = requests.get('http://175.178.45.209:39005/query',
                        params={
                            'query': "select HOST_TEAM_ID, VISITOR_TEAM_ID, HOME_TEAM_WIN from game"
                        })
    gram = 0
    exec("gram = " + resp.text)
    for x in gram["content"]:
        host_team_id = team_map[int(x["HOST_TEAM_ID"])]
        visitor_team_id = team_map[int(x["VISITOR_TEAM_ID"])]
        home_team_win = int(x["HOME_TEAM_WIN"])
        
        if host_team_id not in home_win.keys():
            home_win[host_team_id] = 0
        if visitor_team_id not in home_win.keys():
            home_win[visitor_team_id] = 0
        if host_team_id not in game_win.keys():
            game_win[host_team_id] = 0
        if visitor_team_id not in game_win.keys():
            home_win[visitor_team_id] = 0
        
        if home_team_win == 1:
            if host_team_id not in home_win.keys():
                home_win[host_team_id] = 1
            else:
                home_win[host_team_id] += 1
            if host_team_id not in game_win.keys():
                game_win[host_team_id] = 1
            else:
                game_win[host_team_id] += 1
        else:
            if visitor_team_id not in game_win.keys():
                game_win[visitor_team_id] = 1
            else:
                game_win[visitor_team_id] += 1
                
    for key in game_win.keys():
        if game_win[key] != 0:
            rate[key] = home_win[key]/game_win[key]
        else :
            rate[key] = 0
    print(rate)

    plt.plot(rate.keys(), rate.values(), marker="o")
    plt.xlabel('Team')
    plt.ylabel('Win Rate at Home')
    plt.xticks(rotation=90)
    plt.show()
        
except mysql.connector.Error as e:
    print("Error reading data from MySQL table", e)
