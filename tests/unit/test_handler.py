import json
import os
# os.environ["DB_DIR"] = "./s3-bucket"

import pytest
import sqlite3

#os.chdir(path=os.path.dirname('../address_code_func'))

#from address_code_func import app

@pytest.fixture()
def apigw_event():
    """ Generates API GW Event"""
    
    return {
        "body": '',
        "resource": "/countries/{iso_code}",
        "requestContext": {
            "resourceId": "123456",
            "apiId": "1234567890",
            "resourcePath": "/countries",
            "httpMethod": "GET",
            "requestId": "c6af9ac6-7b61-11e6-9a41-93e8deadbeef",
            "accountId": "123456789012",
            "identity": {
                "apiKey": "",
                "userArn": "",
                "cognitoAuthenticationType": "",
                "caller": "",
                "userAgent": "Custom User Agent String",
                "user": "",
                "cognitoIdentityPoolId": "",
                "cognitoIdentityId": "",
                "cognitoAuthenticationProvider": "",
                "sourceIp": "127.0.0.1",
                "accountId": "",
            },
            "stage": "prod",
        },
        "queryStringParameters": {"unit": "test"},
        "headers": {
            "Via": "1.1 08f323deadbeefa7af34d5feb414ce27.cloudfront.net (CloudFront)",
            "Accept-Language": "en-US,en;q=0.8",
            "CloudFront-Is-Desktop-Viewer": "true",
            "CloudFront-Is-SmartTV-Viewer": "false",
            "CloudFront-Is-Mobile-Viewer": "false",
            "X-Forwarded-For": "127.0.0.1, 127.0.0.2",
            "CloudFront-Viewer-Country": "US",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            "Upgrade-Insecure-Requests": "1",
            "X-Forwarded-Port": "443",
            "Host": "1234567890.execute-api.us-east-1.amazonaws.com",
            "X-Forwarded-Proto": "https",
            "X-Amz-Cf-Id": "aaaaaaaaaae3VYQb9jd-nvCd-de396Uhbp027Y2JvkCPNLmGJHqlaA==",
            "CloudFront-Is-Tablet-Viewer": "false",
            "Cache-Control": "max-age=0",
            "User-Agent": "Custom User Agent String",
            "CloudFront-Forwarded-Proto": "https",
            "Accept-Encoding": "gzip, deflate, sdch",
        },
        "pathParameters": {"iso_code": "VNM"},
        "httpMethod": "GET",
        "stageVariables": {},
        "path": "/countries/VNM",
    }


def test_lambda_handler(apigw_event):
    #print("DB_DIR: ", app.DB_DIR)
    # app.dbcon = sqlite3.connect("s3-bucket/country_div_sub.sqlite3")
    dbfile = os.getenv('DB_DIR', '/tmp') + '/' + 'address_db.sqlite3'
    #app.dbcon = sqlite3.connect(dbfile)
    #ret = app.lambda_handler(apigw_event, "")
    #data = json.loads(ret["body"])
    #print(ret)
    #assert ret["statusCode"] == 200
    #assert "VNM" in ret["body"]
