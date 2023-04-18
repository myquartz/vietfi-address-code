import os
import json
# import requests
import sqlite3

# print(os.environ)

'''
Manual setup: 

1. Create sqlite3 data file at local, create tables, index, data..
2. Copy data file to AWS S3 
   by command (assume "vietfi-api-data" is Bucket Name): 
   `aws s3 cp country-div-sub.db s3://vietfi-api-data/country-div-sub.db`


How this code works:

1. Load Datafile file from S3 (Object Storage service)
2. The BucketName from env BUCKET_NAME
3. Key default to "country-div-sub.db", can be override by DB_FILE_KEY
4. Credential to authentication with S3 is automatically assigned by Role attach to Function (see template.yaml).
5. To run sam local invoke or sam local start-api, the credential provided by --profile <name:default> 

Refer to https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html
Refer to https://brianpfeil.com/post/aws-sam-local-invoke-with-lambda-role/

'''

DB_DIR = '/tmp'

bucketName = os.getenv('BUCKET_NAME')
objectName = os.getenv('DB_FILE_KEY', 'country_div_sub.sqlite3')

client = boto3.client('s3')
if client is not None and bucketName is not None and not os.path.exists(DB_DIR + "/" + objectName):
    print("Loading from s3://" + bucketName + "/" + objectName)
    s3resp = client.get_object(
        Bucket=bucketName,
        Key=objectName
    )
    body = s3resp['Body']
    with io.FileIO(DB_DIR + "/" + objectName, 'w') as file:
        while file.write(body.read(amt=4096)):
            pass

# CORS config
corsAllow = os.getenv('CORS_ALLOW_ORIGIN', '')

# Global DB Connection
dbcon = sqlite3.connect(DB_DIR + "/" + objectName)

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
    if dbcur is not None:
        dbcur.close()
    # print(dbcur)


def toCountryObj(arr):
    return {
        "code": arr[0],
        "name": arr[1]
    }

def lambda_handler(event, context):
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
        API Gateway Lambda Proxy Input Format

        Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
        #api-gateway-simple-proxy-for-lambda-input-format

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    API Gateway Lambda Proxy Output Format: dict

        Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
    """

    # print(event)
    # print(type(event['requestContext']['requestId']))
    # try:
    #     ip = requests.get("http://checkip.amazonaws.com/")
    # except requests.RequestException as e:
    #     # Send some context about this error to Lambda Logs
    #     print(e)

    #     raise e
    total = 0
    try:
        requestId = ''
        if type(event['requestContext']) is dict:
            requestId = event['requestContext']['requestId']
            print("requestId = " + requestId)
            params = (requestId, json.dumps(event['requestContext']), event['body'])
            cur.execute(
                "INSERT INTO access_log (REQ_ID, REQ_TIME, REQ_HEADER, REQ_BODY) VALUES (?,CURRENT_TIMESTAMP,?,?)",
                params)
        else:
            print("No requestId")

        cur.execute("SELECT COUNT(*) FROM access_log")
        row = cur.fetchone()
        total = row[0]

        # Routing by resource and method
        # See Event document above
        resource_str = event['resource']
        method = event['httpMethod']

        print("Requesting " + method + " " + resource_str)

        if corsAllow is not None and corsAllow != '':
            headers = {
                "X-Count": str(total),
                "access-control-allow-origin": corsAllow.strip("'\" "),
                "access-control-allow-headers": 'Accept,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                "access-control-allow-methods": 'GET, POST, PUT, DELETE',
                "access-control-max-age": '3600'
            }
        else:
            headers = {
                "X-Count": str(total)
            }

        if resource_str == '/countries' and method == 'GET':
            cur.execute("SELECT iso3 AS code, nicename AS name FROM sys_country ORDER BY iso3")
            return {
                "statusCode": 200,
                "headers": headers,
                "body": json.dumps(list(map(toCountryObj, cur.fetchall()))),
            }

        elif resource_str == '/countries/{iso_code}' and method == 'GET':
            iso_code = event['pathParameters']['iso_code']
            params = (iso_code,)
            cur.execute("SELECT iso3, nicename FROM sys_country WHERE iso3 = ?", params)
            row = cur.fetchone()
            if row is None:
                return {
                    "statusCode": 404,
                    "headers": headers,
                    "body": json.dumps({
                        "message": "object not found, iso_code=" + iso_code,
                    }),
                }

            return {
                "statusCode": 200,
                "headers": headers,
                "body": json.dumps(toCountryObj(row)),

            }
        # API entry /countries/{country-iso3}/divisions
        elif resource_str == '/countries/{iso_code}/divisions' and method == 'GET':
            iso_code = event['pathParameters']['iso_code']
            params = (iso_code,)
            cur.execute("SELECT a.division_cd, a.division_name \
                FROM sys_division a, sys_country b \
                WHERE a.countryid = b.countryid \
                AND b.iso3 = ?", params)

            row = cur.fetchone()
            if row is None:
                return {
                    "statusCode": 404,
                    "headers": headers,
                    "body": json.dumps({
                        "message": "object not found, iso_code=" + iso_code,
                    }),
                }

            return {
                "statusCode": 200,
                "headers": headers,
                "body": json.dumps(list(map(toCountryObj, cur.fetchall())), ensure_ascii=False),
            }

        # API entry
        # summary: Get all subdivisions of a division
        # operationId: get_subdivisions
        # /countries/{country_code}/divisions/{division_code}/subdivisions
        elif resource_str == '/countries/{iso_code}/divisions/{division_code}/subdivisions' \
                and method == 'GET':
            iso_code = event['pathParameters']['iso_code']
            division_code = event['pathParameters']['division_code']
            params = (iso_code, division_code,)
            sqlstatement = "select a.subdiv_cd, a.subdiv_name \
                from sys_division_sub a, sys_division b, sys_country c \
                where a.divisionid = b.divisionid \
                  and b.countryid = c.countryid \
                  and a.subdiv_cd != '000' and a.l2subdiv_cd is null \
                  and c.iso3 = ? and b.division_cd = ? \
                  order by a.subdiv_name"
            cur.execute(sqlstatement, params)
            row = cur.fetchone()
            if row is None:
                return {
                    "statusCode": 404,
                    "headers": headers,
                    "body": json.dumps({
                        "message": "object not found for iso_code=" + iso_code + " and division_code " + division_code,
                    }),
                }

            return {
                "statusCode": 200,
                "headers": headers,
                "body": json.dumps(list(map(toCountryObj, cur.fetchall())), ensure_ascii=False),
            }

    # API entry
        # summary: Get all l2subdivisions of a subdivision
        # operationId: get_l2subdivisions
        # /countries/{country_code}/divisions/{division_code}/subdivisions/{subdiv_code}/l2subdivisions
        elif resource_str == '/countries/{iso_code}/divisions/{division_code}/subdivisions/{subdiv_code}/l2subdivisions' \
                and method == 'GET':
            iso_code = event['pathParameters']['iso_code']
            division_code = event['pathParameters']['division_code']
            subdiv_code = event['pathParameters']['subdiv_code']
            params = (iso_code, division_code,subdiv_code,)
            sqlstatement = "select a.l2subdiv_cd, a.subdiv_name \
                from sys_division_sub a, sys_division_sub b,sys_division c, sys_country d \
                where a.subdiv_cd = b.subdiv_cd \
                  and b.divisionid = c.divisionid \
                  and c.countryid = d.countryid \
                  and b.subdiv_cd != '000' \
                  and b.l2subdiv_cd is null \
                  and a.l2subdiv_cd is not null \
                  and a.subdiv_cd = b.subdiv_cd \
                  and d.iso3 = ? and c.division_cd = ? and b.subdiv_cd = ? \
                  order by a.subdiv_name"

            cur.execute(sqlstatement, params)
            row = cur.fetchone()
            if row is None:
                return {
                    "statusCode": 404,
                    "headers": headers,
                    "body": json.dumps({
                        "message": "object not found for iso_code=" + iso_code + ",division_code=" + division_code + "and subdiv_code=" +subdiv_code,
                    }),
                }

            return {
                "statusCode": 200,
                "headers": headers,
                "body": json.dumps(list(map(toCountryObj, cur.fetchall())), ensure_ascii=False),
            }

    except Exception as err:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": "SQL error: " + str(err)
            }),
        }

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "access_log count=" + str(total),
            # "location": ip.text.replace("\n", "")
        }),
    }
