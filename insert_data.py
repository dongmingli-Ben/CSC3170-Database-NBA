import mysql.connector
import numpy as np
import pandas as pd
import json
from time import time
from typing import List, Dict

def prepare_cursor():
    with open('server/config.json') as f:
        config = json.load(f)
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor(buffered=True)
    return cursor, cnx

def insert_csv_to_db(path: str, table_name: str, column_map: Dict[str, str]):
    t0 = time()
    df = pd.read_csv(path)
    # import pdb; pdb.set_trace()
    db_columns, csv_columns = list(zip(*column_map.items()))
    df = df[list(csv_columns)]

    statement = f"""
        insert ignore into {table_name} ({', '.join(db_columns)})
        values ({', '.join(['%s']*len(column_map))})
    """

    df = df.replace({np.nan: None})
    records = df.to_records(index=False).tolist()
    
    cursor, cnx = prepare_cursor()

    cursor.executemany(statement, records)
    cnx.commit()

    print(f'{cursor.rowcount} was inserted to {table_name} in {time()-t0:.2f}s')

def load_data_config(path: str):
    with open(path, 'r') as f:
        config = json.load(f)
    return config


if __name__ == "__main__":
    data_config = load_data_config('data/config.json')
    for table, col_map in data_config.items():
        print(f'inserting data for {table}')
        insert_csv_to_db(f'data/{table}.csv', table, col_map)
