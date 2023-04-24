import requests

if __name__ == '__main__':
    server_ip_port = '175.178.45.209:39005'
    resp = requests.get(f'http://{server_ip_port}/tables')
    print(resp.text)
    resp = requests.get(f'http://{server_ip_port}/query',
                        params={
                            'query': 'SELECT * FROM player LIMIT 10;'
                        })
    print(resp.text)