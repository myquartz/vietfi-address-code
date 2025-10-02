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
   `aws s3 cp s3-bucket/address_db.sqlite3 s3://vietfi-api-data/prefix/address_db.sqlite3`

How this code works:

1. Load Datafile file from S3 (Object Storage service)
2. The BucketName from env BUCKET_NAME
3. Key default to "address_db.sqlite3", can be override by DB_FILE_KEY
4. Credential to authentication with S3 is automatically assigned by Role attach to Function (see template.yaml).
5. To run sam local invoke or sam local start-api, the credential provided by --profile <name:default> 

Refer to https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html
Refer to https://brianpfeil.com/post/aws-sam-local-invoke-with-lambda-role/

'''

DB_DIR = os.getenv('DB_DIR','/tmp')

bucketName = os.getenv('BUCKET_NAME')
objectName = os.getenv('DB_FILE_KEY', 'address_db.sqlite3')

client = boto3.client('s3')
temp_file_name = DB_DIR + "/" + objectName.split('/')[-1]
if client is not None and bucketName is not None and not os.path.exists(temp_file_name):
    print("Loading from s3://" + bucketName + "/" + objectName)
    s3resp = client.get_object(
        Bucket=bucketName,
        Key=objectName
    )
    body = s3resp['Body']
    with io.FileIO(temp_file_name, 'w') as file:
        while file.write(body.read(amt=4096)):
            pass

# CORS config
corsAllow = os.getenv('CORS_ALLOW_ORIGIN', '*')

# Global DB Connection
# dbconn = sqlite3.connect(DB_DIR + "/" + objectName)
# dbcur = dbconn.cursor()
# Connect to database
try:
    dbconn = sqlite3.connect(temp_file_name, check_same_thread=False)
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

total = 0

# define API request handlers
def get_countries(event, context):
    global headers
    sqlstatement = "SELECT iso3 AS code, nicename AS name, namespaces FROM sys_country ORDER BY iso3"
    row_cnt = cur.execute(sqlstatement)
    data = json.dumps(list(map(lambda row: {
        "code": row[0],
        "name": row[1],
        "namespaces": row[2].split(',') if row[2] else []
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
    sqlstatement = "SELECT iso3, nicename, namespaces FROM sys_country WHERE iso3 = ?"
    row_cnt = cur.execute(sqlstatement, params)
    row = cur.fetchone()
    if row:
        data = {
            "code": row[0],
            "name": row[1],
            "namespaces": row[2].split(',') if row[2] else []
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

def db_query_country_namespaces(iso_code):
    params = (iso_code,)
    sqlstatement = "SELECT namespaces FROM sys_country WHERE iso3 = ?"
    row_cnt = cur.execute(sqlstatement, params)
    ctry = cur.fetchone()
    if not ctry:
        return None
    if ctry[0]:
        namespaces = ctry[0].split(',')
        return namespaces
    return []

def db_query_country_namespace(iso_code,selected_namespace):
    params = (iso_code,)
    sqlstatement = "SELECT iso3, nicename, namespaces FROM sys_country WHERE iso3 = ?"
    row_cnt = cur.execute(sqlstatement, params)
    ctry = cur.fetchone()
    if not ctry:
        return -1
    if ctry[2] and selected_namespace:
        # find index of selected_namespace
        namespaces = ctry[2].split(',')
        if selected_namespace not in namespaces:
            return -1

        return 1 + namespaces.index(selected_namespace)    
    return 0

def get_divisions(event,context):
    global headers
    resource = event['resource']
    isEndWithSubdiv = resource.endswith('/divisions')
    iso_code = event['pathParameters']['iso_code']
    if 'division_code' in event['pathParameters']:
        division_code = event['pathParameters']['division_code']
    else:
        division_code = '00'
    
    selected_namespace = event['queryStringParameters']['namespace'] if event['queryStringParameters'] and 'namespace' in event['queryStringParameters'] else None
    selected_ns_pos = db_query_country_namespace(iso_code, selected_namespace)
    if selected_ns_pos < 0:
        return {
            "statusCode": 404,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "There are no such country with iso_code=" + iso_code+", namespace=" + (selected_namespace if selected_namespace else "default"),
            }})
        }
    if selected_ns_pos == 0 and selected_namespace:
        return {
            "statusCode": 400,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "The country with iso_code=" + iso_code + " does not support namespace=" + selected_namespace,
            }})
        }
    # print("selected_ns_pos=", selected_ns_pos)
    selected_ns_bit = (1 << (selected_ns_pos-1) if selected_ns_pos > 0 else 0)
    sqlstatement = "SELECT a.division_cd, a.division_name, a.country_iso3, local_id \
            , a.divisionid FROM sys_division a \
            WHERE a.country_iso3 = ? AND (a.namespaceset & ? > 0 or a.namespaceset = 0) "
    if isEndWithSubdiv:
        sqlstatement += "order by a.divisionid"
        params = (iso_code, selected_ns_bit)
    else:
        sqlstatement += " AND a.division_cd = ?"
        params = (iso_code, selected_ns_bit, division_code)

    row_cnt = cur.execute(sqlstatement, params)
    print("iso_code=", iso_code, "selected_ns_bit=", selected_ns_bit, "division_code=", division_code, " returns row_cnt=", row_cnt)
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
            "message": "There are no division under country with iso_code=" + iso_code+" and namespace=" + (selected_namespace if selected_namespace else "default") + ("" if isEndWithSubdiv else " and division_code=" + division_code),
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
    else:
        subdiv_code = '000'
    selected_namespace = event['queryStringParameters']['namespace'] if event['queryStringParameters'] and 'namespace' in event['queryStringParameters'] else None
    selected_ns_pos = db_query_country_namespace(iso_code, selected_namespace)
    if selected_ns_pos < 0:
        return {
            "statusCode": 404,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "There are no such country with iso_code=" + iso_code+", namespace=" + (selected_namespace if selected_namespace else "default"),
            }})
        }
    if selected_ns_pos == 0 and selected_namespace:
        return {
            "statusCode": 400,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "The country with iso_code=" + iso_code + " does not support namespace=" + selected_namespace,
            }})
        }
    # print("selected_ns_pos=", selected_ns_pos)
    selected_ns_bit = (1 << (selected_ns_pos-1) if selected_ns_pos > 0 else 0)
    sqlstatement = "select a.subdiv_cd, a.l2subdiv_cd, a.subdiv_name, b.division_cd, b.country_iso3 \
        ,a.subdivid from sys_division_sub a, sys_division b \
        where a.divisionid = b.divisionid \
          and a.l2subdiv_cd = '00000' \
          and b.country_iso3 = ? and b.division_cd = ?  and (a.namespaceset & ? > 0 or a.namespaceset = 0) and (b.namespaceset & ? > 0 or b.namespaceset = 0) "
    if isEndWithSubdiv:
        sqlstatement += "order by a.subdivid"
        params = (iso_code,division_code, selected_ns_bit, selected_ns_bit)
    else:
        sqlstatement += " and a.subdiv_cd = ?"
        params = (iso_code, division_code, selected_ns_bit, selected_ns_bit, subdiv_code)

    row_cnt = cur.execute(sqlstatement, params)
    print("iso_code=", iso_code, "selected_ns_bit=", selected_ns_bit, "division_code=", division_code, "subdiv_code=", subdiv_code, " returns row_cnt=", row_cnt)
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
            "message": "Object not found for country=" + iso_code + ", namespace=" + (selected_namespace if selected_namespace else "default") + 
                " and div_code="+division_code + ("" if isEndWithSubdiv else " and subdiv_code=" + subdiv_code),
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
    else:
        l2subdiv_code = '00000'
    
    selected_namespace = event['queryStringParameters']['namespace'] if event['queryStringParameters'] and 'namespace' in event['queryStringParameters'] else None
    selected_ns_pos = db_query_country_namespace(iso_code, selected_namespace)
    if selected_ns_pos < 0:
        return {
            "statusCode": 404,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "There are no such country with iso_code=" + iso_code +", namespace=" + (selected_namespace if selected_namespace else "default"),
            }})
        }
    if selected_ns_pos == 0 and selected_namespace:
        return {
            "statusCode": 400,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "The country with iso_code=" + iso_code + " does not support namespace=" + selected_namespace,
            }})
        }

    selected_ns_bit = (1 << (selected_ns_pos-1) if selected_ns_pos > 0 else 0)
    sqlstatement = "select a.subdiv_cd, a.l2subdiv_cd, a.subdiv_name, b.division_cd, b.country_iso3 \
        from sys_division_sub a, sys_division b \
        where a.divisionid = b.divisionid \
          and b.country_iso3 = ? and b.division_cd = ? and a.subdiv_cd = ?  and (a.namespaceset & ? > 0 or a.namespaceset = 0) and (b.namespaceset & ? > 0 or b.namespaceset = 0) "
    if isEndWithSubdiv:
        sqlstatement += "order by a.subdiv_name"
        params = (iso_code, division_code, subdiv_code, selected_ns_bit, selected_ns_bit)
    else:
        sqlstatement += " and a.l2subdiv_cd = ?"
        params = (iso_code, division_code, subdiv_code, selected_ns_bit, selected_ns_bit, l2subdiv_code)
        
    row_cnt = cur.execute(sqlstatement, params)
    print("iso_code=", iso_code, "selected_ns_bit=", selected_ns_bit, "division_code=", division_code, "subdiv_code=", subdiv_code,
            "l2subdiv_code=", l2subdiv_code, " returns row_cnt=", row_cnt)
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
            "message": "Object not found for country_code=" + iso_code + " and div_code="+division_code + 
                ("" if isEndWithSubdiv else " and subdiv_code=" + subdiv_code) + ("" if isEndWithSubdiv else " and l2subdiv_code=" + l2subdiv_code),
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
    
    # Listing namespaces
    namespaces = db_query_country_namespaces('VNM')
    if namespaces is None:
        return {
            "statusCode": 404,
            "headers": headers,
            "body": json.dumps({ "error": {
                "message": "There are no such country with iso_code={" + 'VNM' + "}"
            }})
        }
    namespaces_bit = [i+1 for i in range(len(namespaces))]
    if len(namespaces) == 0:
        namespaces_bit = [0]
    # Build the response payload
    data = ap.detect_address(namespaces_bit, address_text)
    result = []
    
    for ns in namespaces_bit:
        r = data[ns]
        n = namespaces[ns-1] if ns > 0 else 'default'
        r['namespace'] = n
        result.append(r)
    # Return the response
    return {
        "statusCode": 200,
        "headers": headers,
        "body": json.dumps({
            "country_code": "VNM",
            "has_default_ns": True if 0 in namespaces_bit else False,
            "namespaces": namespaces,
            "input": address_text,
            "result": result
        })
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
    '/address-guess': {
          'POST': post_address_parser,
    },
    '/address': {
          'POST': post_address_parser,
    }

}

def lambda_handler(event, context):
    global corsAllow
    global dbcon
    global total

    cur = dbconn.cursor()
    total += 1
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
                "access-control-allow-methods": 'GET, POST',
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
                    "headers": headers,
                    "body": json.dumps({
                        "message": f"Method {method} not allowed"
                    })
                }
        else:
            return {
                "statusCode": 404,
                "headers": headers,
                "body": json.dumps({
                    "message": "Resource not found"
                })
            }
    except Exception as err:
        logging.exception(str(err)+ ", event: " + str(event))
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({
                "message": "Error: " + str(err)
            }),
        }
    finally:
        if cur is not None:
            cur.close()
