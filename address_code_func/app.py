import os
import json
# import requests
import sqlite3

# print(os.environ)

DB_DIR = '/tmp'
# Global DB Connection
dbcon = sqlite3.connect(DB_DIR+"/sqlite3-test.db")

dbcur = dbcon.cursor()
try:
    dbres = dbcur.execute("SELECT name FROM sqlite_master WHERE name='access_log'")
    if dbres.fetchone() is None:
        dbcreate = dbcur.execute("""
        CREATE TABLE IF NOT EXISTS access_log (
            REQ_ID VARCHAR(64) PRIMARY KEY,
            REQ_TIME TIMESTAMP,
            REQ_HEADER TEXT,
            REQ_BODY TEXT
        )
        """)
        dbres.close()
        dbcreate.close()
finally:
    dbcur.close()
    #print(dbcur)

def lambda_handler(event, context):
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
        API Gateway Lambda Proxy Input Format

        Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    API Gateway Lambda Proxy Output Format: dict

        Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
    """

    #print(event['requestContext'])
    #print(type(event['requestContext']['requestId']))
    # try:
    #     ip = requests.get("http://checkip.amazonaws.com/")
    # except requests.RequestException as e:
    #     # Send some context about this error to Lambda Logs
    #     print(e)

    #     raise e
    total = 0
    try:
        requestId = '';
        if type(event['requestContext']) is dict:
            requestId = event['requestContext']['requestId'];
        else:
            print("No requestId")

        with dbcon.cursor() as cur:
            cur.execute("INSERT INTO access_log (REQ_ID, REQ_TIME, REQ_HEADER, REQ_BODY) VALUES (?,CURRENT_TIMESTAMP,?,?)",
                (requestId, json.dumps(event['requestContext']), event['body']))
            cur.execute("SELECT COUNT(*) FROM access_log")
            row = cur.fetchone()
            total = row[0]
    except Exception as err:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": "SQL error: "+str(err)
            }),    
        }

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "hello, count="+str(total),
            # "location": ip.text.replace("\n", "")
        }),
    }
