import os
import io
import json
import logging
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
   `aws s3 cp country-div-sub.db s3://vietfi-api-data/address_db.db`

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
objectName = os.getenv('DB_FILE_KEY', 'address_db.sqlite3')

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
# dbconn = sqlite3.connect(DB_DIR + "/" + objectName)
# dbcur = dbconn.cursor()
# Connect to database
try:
    dbconn = sqlite3.connect(DB_DIR + "/" + objectName)
    cur = dbconn.cursor()

    if dbconn and cur:
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


# define API request handlers
def get_countries(event,context):
    global headers
    sqlstatement = "SELECT iso3 AS code, nicename AS name FROM sys_country ORDER BY iso3"
    row_cnt = cur.execute(sqlstatement)
    data = json.dumps(list(map(lambda row: {
        "code": row[0],
        "name": row[1]
    }, cur.fetchall())))
    return {
        "statusCode": 200,
        "headers": headers,
        "body": data,
    }

def get_country_by_code(event,context):
    global headers
    iso_code = event['pathParameters']['iso_code']
    params = (iso_code,)
    sqlstatement = "SELECT iso3, nicename FROM sys_country WHERE iso3 = ?"
    row_cnt = cur.execute(sqlstatement, params)
    row = cur.fetchone()
    if row:
        data = {
            "code": row[0],
            "name": row[1]
        }
        status_code = 200
    else:
        status_code = 404

    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({ "error": {
            "message": "There are no such country with iso_code=" + iso_code,
        }}) if not data else json.dumps(data, ensure_ascii=False),
    }

def get_divisions(event,context):
    global headers
    resource = event['resource']
    isEndWithSubdiv = resource.endswith('/divisions')
    iso_code = event['pathParameters']['iso_code']
    if 'division_code' in event['pathParameters']:
        division_code = event['pathParameters']['division_code']
    params = (iso_code,)
    sqlstatement = "SELECT a.division_cd, a.division_name, a.country_iso3, local_id \
            , a.divisionid FROM sys_division a \
            WHERE a.country_iso3 = ?"
    if isEndWithSubdiv:
        sqlstatement += "order by a.divisionid"
    else:
        sqlstatement += " and a.division_cd = ?"
        params = (iso_code, division_code)

    row_cnt = cur.execute(sqlstatement, params)
    data = None
    status_code = 200
    if isEndWithSubdiv:
        data = [{ 
            "division_code": row[0], 
            "name": row[1],
            "country_iso3": row[2],
            "local_id": row[3]
            } for row in cur.fetchall()]
    else:
        row = cur.fetchone()
        if not row:
            status_code = 404
        else:
            data = {
                "division_code": row[0], 
                "name": row[1],
                "country_iso3": row[2],
                "local_id": row[3]
            }
    
    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({ "error": {
            "message": "There are no division under country with iso_code=" + iso_code,
        }}) if not data else json.dumps(data, ensure_ascii=False),
    }

def get_subdivisions(event,context):
    global headers
    resource = event['resource']
    isEndWithSubdiv = resource.endswith('/subdivisions')
    iso_code = event['pathParameters']['iso_code']
    division_code = event['pathParameters']['division_code']
    if 'subdiv_code' in event['pathParameters']:
        subdiv_code = event['pathParameters']['subdiv_code']
    params = (iso_code,division_code)
    sqlstatement = "select a.subdiv_cd, a.l2subdiv_cd, a.subdiv_name, b.division_code, b.country_iso3 \
        ,a.subdivid from sys_division_sub a, sys_division b \
        where a.divisionid = b.divisionid \
          and a.l2subdiv_cd = '00000' \
          and b.country_iso3 = ? and b.division_cd = ?"
    if isEndWithSubdiv:
        sqlstatement += "order by a.subdivid"
    else:
        sqlstatement += " and a.subdiv_cd = ?"
        params = (iso_code,division_code,subdiv_code)

    row_cnt = cur.execute(sqlstatement, params)
    data = None
    status_code = 200
    if isEndWithSubdiv:
        data = [{
            "local_id": row[0],
            "name": row[2],
            "division_code": row[3],
            "country_code": row[4]
        } for row in cur.fetchall()]
    else:
        row = cur.fetchone()
        if not row:
            status_code = 404
        else:
            data = {
                "local_id": row[0],
                "name": row[2],
                "division_code": row[3],
                "country_code": row[4]
            }


    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({ "error": {
            "message": "Object not found for country=" + iso_code + " and div_code="+division_code,
        } }) if not data else json.dumps(data, ensure_ascii=False),
    }

def get_l2subdivisions(event,context):
    global headers
    resource = event['resource']
    isEndWithSubdiv = resource.endswith('/l2subdivisions')
    iso_code = event['pathParameters']['iso_code']
    division_code = event['pathParameters']['division_code']
    subdiv_code = event['pathParameters']['subdiv_code']
    if 'l2subdiv_code' in event['pathParameters']:
        l2subdiv_code = event['pathParameters']['l2subdiv_code']
    params = (iso_code, division_code, subdiv_code,)
    sqlstatement = "select a.subdiv_cd, a.l2subdiv_cd, a.subdiv_name, b.division_code, b.country_iso3 \
        from sys_division_sub a, sys_division b \
        where a.divisionid = b.divisionid \
          and b.country_iso3 = ? and b.division_cd = ? and a.subdiv_cd = ?"
    if isEndWithSubdiv:
        sqlstatement += "order by a.subdiv_name"
    else:
        sqlstatement += " and a.l2subdiv_cd = ?"
        params = (iso_code, division_code, subdiv_code, l2subdiv_code)
        
    row_cnt = cur.execute(sqlstatement, params)
    data = None
    status_code = 200
    if isEndWithSubdiv:
        data = [{
            "local_id": row[1],
            "subdiv_local_id": row[0],
            "name": row[2],
            "division_code": row[3],
            "country_code": row[4]
        } for row in cur.fetchall()]
    else:
        row = cur.fetchone()
        if not row:
            status_code = 404
        data = {
            "local_id": row[1],
            "subdiv_local_id": row[0],
            "name": row[2],
            "division_code": row[3],
            "country_code": row[4]
        }    
    
    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps({ "error": {
            "message": "Object not found for country_code=" + iso_code + " and div_code="+division_code + "and subdiv_code=" + subdiv_code,
        } }) if not data else json.dumps(data, ensure_ascii=False),
    }

def post_address_parser(event, context):
    global headers
    # Extract the address text from the request body
    # It is JSON
    obj = json.loads(event['body'])
    address_text = obj['address_text']

    if address_text is None:
        return {
            "statusCode": 400,
            "body": json.dumps({
                "message": "address_text is required in JSON object"
            })
        }

    # Perform address parsing logic here
    # Calling function from class AddressParser
    # ...
    ap = AP(init_conn=dbconn)
    # Build the response payload
    response_payload = ap.detect_address(address_text)

    # # sample response_payload
    # response_payload = {
    #     'country_code': 'VNM',
    #     'division_name': 'Thành phố Hà nội',
    #     'division_code': 'VN-HN',
    #     'subdivision_name': 'Quận Long Biên',
    #     'subdivision_code': '004',
    #     'l2subdivision_name': 'Phường Gia Thuỵ',
    #     'l2suvdiv_code': '00130',
    #     'address_line': 'Số 18/25 Nguyễn Văn Cừ'
    # }

    # Return the response
    return {
        "statusCode": 200,
        "headers": headers,
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
        'GET': get_divisions,
    },
    '/countries/{iso_code}/divisions/{division_code}': {
         'GET': get_divisions,
    },
    '/countries/{iso_code}/divisions/{division_code}/subdivisions': {
         'GET': get_subdivisions,
    },
    '/countries/{iso_code}/divisions/{division_code}/subdivisions/{subdiv_code}': {
          'GET': get_subdivisions,
    },
    '/countries/{iso_code}/divisions/{division_code}/subdivisions/{subdiv_code}/l2subdivisions': {
          'GET': get_l2subdivisions,
    },
    '/countries/{iso_code}/divisions/{division_code}/subdivisions/{subdiv_code}/l2subdivisions/{l2subdiv_code}': {
          'GET': get_l2subdivisions,
    },
    '/address': {
          'POST': post_address_parser,
    }

}

def lambda_handler(event, context):
    global corsAllow
    global dbcon

    total = 0
    cur = dbconn.cursor()
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
        logging.exception(str(err)+ ", event: " + str(event))
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": "Error: " + str(err)
            }),
        }
    finally:
        if cur is not None:
            cur.close()
