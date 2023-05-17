import os
import io
import json
# import requests
import sqlite3
import boto3
from address_parser.AddressParser import AP
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

DB_DIR = os.getenv('DB_DIR','/tmp')

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
corsAllow = os.getenv('CORS_ALLOW_ORIGIN', '*')

# Global DB Connection
# dbcon = sqlite3.connect(DB_DIR + "/" + objectName)
# dbcur = dbcon.cursor()
# Connect to database
try:
    dbcon = sqlite3.connect(DB_DIR + "/" + objectName)
    cur = dbcon.cursor()

    if dbcon and cur:
        print("Database connection successful")
    else:
        print("Failed to connect to database")

except sqlite3.Error as e:
    print("Database connection error: ", e)

# global header to allow CORS
headers = {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json"
}


def toCodeNameObj(arr):
    return {
        "code": arr[0],
        "name": arr[1]
    }

# define API request handlers
def get_countries(event,context):
    sqlstatement = "SELECT iso3 AS code, nicename AS name FROM sys_country ORDER BY iso3"
    row_cnt = cur.execute(sqlstatement)
    data = json.dumps(list(map(toCodeNameObj, cur.fetchall())))
    return {
        "statusCode": 200,
        "headers": headers,
        "body": data,
    }

def get_country_by_code(event,context):
    iso_code = event['pathParameters']['iso_code']
    params = (iso_code,)
    sqlstatement = "SELECT iso3, nicename FROM sys_country WHERE iso3 = ?"
    row_cnt = cur.execute(sqlstatement, params)
    data = [toCodeNameObj(row) for row in cur.fetchall()]
    status_code = 200 if data else 404

    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({
            "message": "There are no such country with iso_code=" + iso_code,
        }) if not data else json.dumps(data, ensure_ascii=False),
    }

def get_divisions_by_country_code(event,context):
    iso_code = event['pathParameters']['iso_code']
    params = (iso_code,)
    sqlstatement = "SELECT a.division_cd, a.division_name \
            FROM sys_division a, sys_country b \
            WHERE a.countryid = b.countryid \
            AND b.iso3 = ?"
    row_cnt = cur.execute(sqlstatement, params)
    data = [toCodeNameObj(row) for row in cur.fetchall()]
    status_code = 200 if data else 404
    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({
            "message": "There are no divivisons under country with iso_code=" + iso_code,
        }) if not data else json.dumps(data, ensure_ascii=False),
    }

def get_subdivisions(event,context):
    iso_code = event['pathParameters']['iso_code']
    division_code = event['pathParameters']['division_code']
    params = (iso_code,division_code)
    sqlstatement = "select a.subdiv_cd, a.subdiv_name \
        from sys_division_sub a, sys_division b, sys_country c \
        where a.divisionid = b.divisionid \
          and b.countryid = c.countryid \
          and a.subdiv_cd != '000' and a.l2subdiv_cd is null \
          and c.iso3 = ? and b.division_cd = ? \
          order by a.subdiv_name"
    row_cnt = cur.execute(sqlstatement, params)
    data = [toCodeNameObj(row) for row in cur.fetchall()]
    status_code = 200 if data else 404
    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({
            "message": "Object not found for iso_code=" + iso_code + " and div_code="+division_code,
        }) if not data else json.dumps(data, ensure_ascii=False),
    }

def get_l2subdivisions(event,context):
    iso_code = event['pathParameters']['iso_code']
    division_code = event['pathParameters']['division_code']
    subdiv_code = event['pathParameters']['subdiv_code']
    params = (iso_code, division_code, subdiv_code,)
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
    row_cnt = cur.execute(sqlstatement, params)
    data = [toCodeNameObj(row) for row in cur.fetchall()]
    status_code = 200 if data else 404
    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({
            "message": "Object not found for iso_code=" + iso_code + " and div_code="+division_code + "and subdiv_code=" + subdiv_code,
        }) if not data else json.dumps(data, ensure_ascii=False),
    }

def post_address_parser(event, context):
    # Extract the address text from the request body
    address_text = event['body']['address_text']

    # Perform address parsing logic here
    # Calling function from class AddressParser
    # ...
    ap = AP()
    # Build the response payload
    response_payload = ap.detect_address(address_text)

    # sample response_payload
    response_payload = {
        'country_code': 'VNM',
        'division_name': 'Thành phố Hà nội',
        'division_code': 'VN-HN',
        'subdivision_name': 'Quận Long Biên',
        'subdivision_code': '004',
        'l2subdivision_name': 'Phường Gia Thuỵ',
        'l2suvdiv_code': '00130',
        'address_line': 'Số 18/25 Nguyễn Văn Cừ'
    }

    # Return the response
    return {
        "statusCode": 200,
        "body": json.dumps(response_payload)
    }

# define API routes
api_routes = {
    '/countries': {
        'GET': get_countries,
    },
    '/countries/{iso_code}': {
        'GET': get_country_by_code,
    },
    '/countries/{iso_code}/divisions': {
        'GET': get_divisions_by_country_code,
    },
    '/countries/{iso_code}/divisions/{division_code}/subdivisions': {
         'GET': get_subdivisions,
    },
    '/countries/{iso_code}/divisions/{division_code}/subdivisions/{subdiv_code}/l2subdivisions': {
          'GET': get_l2subdivisions,
    },
    '/address/': {
          'POST': post_address_parser,
    }

}

def lambda_handler(event, context):
    global corsAllow
    global dbcon
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
    context: object, required
    Returns
    ------
    API Gateway Lambda Proxy Output Format: dict
   """

    total = 0
    cur = dbcon.cursor()
    try:
        # Routing by resource and method
        # See Event document above
        resource = event['resource']
        method = event['httpMethod']

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

        if resource in api_routes:
            route = api_routes[resource]
            if method in route:
                return route[method](event, context)
            else:
                return {
                    "statusCode": 405,
                    "body": json.dumps({
                        "message": f"Method {method} not allowed"
                    })
                }
        else:
            return {
                "statusCode": 404,
                "body": json.dumps({
                    "message": "Resource not found"
                })
            }
    except Exception as err:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": "SQL error: " + str(err)
            }),
        }
    finally:
        if cur is not None:
            cur.close()
