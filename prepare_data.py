import pandas as pd

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


if __name__ == '__main__':
    prepare_null('data/game.csv', 'data/game_null.csv')
    process_min('data/game_player.csv', 'data/game_player_min.csv')
    prepare_null('data/game_player_min.csv', 'data/game_player_null.csv')
    process_undrafted('data/player.csv', 'data/player_undraft_null.csv')
    prepare_null('data/player_undraft_null.csv', 'data/player_null.csv')
    prepare_null('data/player_season_info.csv', 'data/player_season_info_null.csv')
    prepare_null('data/team.csv', 'data/team_null.csv')
    prepare_null('data/team_season_info.csv', 'data/team_season_info_null.csv')