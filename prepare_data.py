import pandas as pd
import mysql.connector
import json

def prepare_null(src_path, tgt_path):
    df = pd.read_csv(src_path)

    for col in df.columns:
        df.loc[df[col].isnull(), col] = 'NULL'
    
    df.to_csv(tgt_path, index=False)

def process_undrafted(src_path, tgt_path):
    df = pd.read_csv(src_path)

    df['DRAFT_YEAR'] = df['DRAFT_YEAR'].map(lambda x: 'NULL' if x == 'Undrafted' else x)

    df.to_csv(tgt_path, index=False)

def process_min(src_path, tgt_path):
    df = pd.read_csv(src_path)

    def parse_time(s: str):
        t = {'m': 0, 's': 0}
        ss = s.split(':')
        t['m'] = int(ss[0])
        t['s'] = int(ss[1])
        return t

    def func_min(s):
        try:
            t = parse_time(s)
            return f'00:{t["m"]:02d}:{t["s"]:02d}'
        except:
            return '00:00:00'
    
    df.loc[~df['MIN'].isnull(), 'MIN'] = df.loc[~df['MIN'].isnull(), 'MIN'].map(func_min)
    
    df.to_csv(tgt_path, index=False)

def prepare_cursor():
    with open('server/config.json') as f:
        config = json.load(f)
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor(buffered=True)
    return cursor, cnx

def prepare_data_config(save_path: str):
    cursor, cnx = prepare_cursor()
    cursor.execute('show tables;')
    result = cursor.fetchall()
    tables = [t[0] for t in result]

    data_config = {}

    for table in tables:
        cursor.execute(f'desc {table};')
        db_cols = [t[0] for t in cursor.fetchall()]
        src_path = f'data/{table}.csv'
        df = pd.read_csv(src_path)
        csv_cols = df.columns
        assert len(db_cols) == len(csv_cols), f"db cols: {db_cols}, csv cols: {csv_cols}"
        col_map = {}
        for db_col, csv_col in zip(db_cols, csv_cols):
            col_map[db_col] = csv_col
        data_config[table] = col_map
    
    with open(save_path, 'w') as f:
        json.dump(data_config, f, indent=4)


if __name__ == '__main__':
    # process_min('data/game_player.csv', 'data/game_player.csv') # already executed, no longer need this statement
    # when using table import wizard
    # prepare_null('data/game.csv', 'data/game_null.csv')
    # prepare_null('data/game_player_min.csv', 'data/game_player_null.csv')
    # process_undrafted('data/player.csv', 'data/player_undraft_null.csv')
    # prepare_null('data/player_undraft_null.csv', 'data/player_null.csv')
    # prepare_null('data/player_season_info.csv', 'data/player_season_info_null.csv')
    # prepare_null('data/team.csv', 'data/team_null.csv')
    # prepare_null('data/team_season_info.csv', 'data/team_season_info_null.csv')
    # when using data insert script insert_data.py
    prepare_data_config('data/config.json')