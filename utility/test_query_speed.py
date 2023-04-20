import mysql.connector
import json
from time import time
import argparse

def prepare_cursor():
    with open('server/config.json') as f:
        config = json.load(f)
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor(buffered=True)
    return cursor, cnx


def test_query(query: str, count: int = 10):
    cursor, cnx = prepare_cursor()
    total_time = 0
    for i in range(count):
        t0 = time()
        cursor.execute(query)
        cursor.fetchall()
        total_time += time() - t0
    print(f'Avg speed: {total_time/count:.4f}s for query: {query}')

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-q', '--query', type=str, required=True)
    parser.add_argument('-n', '--num', type=int, default=10)
    args = parser.parse_args()
    return args

if __name__ == '__main__':
    args = parse_args()
    test_query(args.query, args.num)