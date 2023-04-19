import mysql.connector
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# teams to analyze:
# 1610612744 GSW
# 1610612760 Thunder

try:
    # connect to the target db: update ip. user, and pwd
    connection = mysql.connector.connect(host='localhost',
                                         database='NBA',
                                         user='pynative',
                                         password='pynative@#29')

    # make a target query
    sql_select_Query = "select HOST_TEAM_ID, VISITOR_TEAM_ID, HOME_TEAM_WIN from game where HOST_TEAM_ID=1610612744 or VISITOR_TEAM_ID=1610612744"
    cursor = connection.cursor()
    cursor.execute(sql_select_Query)

    # get the query record
    records = cursor.fetchall()
    print("Total number of rows in table: ", cursor.rowcount)
    for row in records:
        print("HOST_TEAM_ID = ", row[0], )
        print("VISITOR_TEAM_ID = ", row[1])
        print("HOME_TEAM_WIN  = ", row[2])

except mysql.connector.Error as e:
    print("Error reading data from MySQL table", e)
finally:
    if connection.is_connected():
        connection.close()
        cursor.close()
        print("MySQL connection is closed")
