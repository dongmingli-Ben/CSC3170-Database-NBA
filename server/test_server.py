import requests

if __name__ == '__main__':
    server_ip_port = '47.242.150.253:39005'
    resp = requests.get(f'http://{server_ip_port}/tables')
    print(resp.text)
    resp = requests.get(f'http://{server_ip_port}/query',
                        params={
                            'query': 'SELECT * FROM player LIMIT 10;'
                        })
    print(resp.text)