from flask import Flask, request
from flask_cors import CORS
import mysql.connector
import json

def prepare_cursor():
    with open('config.json') as f:
        config = json.load(f)
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor(buffered=True)
    return cursor, cnx

app = Flask(__name__)
CORS(app)

cursor, cnx = prepare_cursor()

@app.route("/tables", methods=['GET'])
def get_tables():
    cursor.execute('SHOW tables;')
    result = cursor.fetchall()
    tables = [t[0] for t in result]
    return {'content': tables}

@app.route("/query", methods=['GET'])
def get_query():
    query = request.args.get('query', '')
    if query == '':
        return {'content': ''}
    try:
        cursor.execute(query)
    except Exception as e:
        return {'error_message': str(e)}
    col_names = cursor.column_names
    data = cursor.fetchall()
    result = []
    for item in data:
        result.append(dict(zip(col_names, item)))
    return json.dumps({"content": result}, default=str)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=34152)