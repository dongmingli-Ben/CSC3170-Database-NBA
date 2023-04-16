import requests

if __name__ == '__main__':
    resp = requests.get('http://localhost:34152/tables')
    print(resp.text)
    resp = requests.get('http://localhost:34152/query',
                        params={
                            'query': 'SELECT * FROM player LIMIT 10;'
                        })
    print(resp.text)