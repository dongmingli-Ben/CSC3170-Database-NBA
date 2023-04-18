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

def insert_csv_to_db(path: str, table_name: str, column_map: Dict[str, str], batch_size=10000):
    _t0 = time()
    df = pd.read_csv(path)
    # import pdb; pdb.set_trace()
    db_columns, csv_columns = list(zip(*column_map.items()))
    df = df[list(csv_columns)]

    statement = f"""
        insert ignore into {table_name} ({', '.join(db_columns)})
        values
    """

    df = df.replace({np.nan: None})
    records = df.to_records(index=False).tolist()
    
    cursor, cnx = prepare_cursor()
    cursor.execute('SET autocommit=0;')

    n_batches = (len(records) + batch_size-1) // batch_size
    record_cnt = 0
    for i in range(n_batches):
        t0 = time()
        items = records[i*batch_size:(i+1)*batch_size]
        items_str = [f"({', '.join(map(lambda x: repr(x) if x is not None else 'NULL', item))})" \
                for item in items]
        insert_stmt = statement + f"{', '.join(items_str)};"
        cursor.execute(insert_stmt)
        record_cnt += cursor.rowcount
        print(f'inserted [{(i+1)*batch_size:6d}:{len(records):6d}], {cursor.rowcount} new rows, avg {batch_size/(time()-t0):.2f} records/s')

    cnx.commit()

    print(f'{record_cnt} was inserted to {table_name} in {time()-_t0:.2f}s')

def load_data_config(path: str):
    with open(path, 'r') as f:
        config = json.load(f)
    return config


if __name__ == "__main__":
    data_config = load_data_config('data/config.json')
    for table, col_map in data_config.items():
        print(f'inserting data for {table}')
        insert_csv_to_db(f'data/{table}.csv', table, col_map)
