import pandas as pd
import csv
 
data = pd.read_csv("./data/player_season_info.csv")

data_new=data.drop(["PLAYER_POSITION"], axis=1) # delete a col
 
data_new.to_csv("./data/player_season_info.csv",index=0)