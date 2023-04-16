import json
import logging
import os
import sys

from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from flask_swagger_ui import get_swaggerui_blueprint

from address_functions import CountriesResource, CountryCDResource, \
                              DivisionsResource, DivisionIDResource, SubdivisionsResource

app = Flask(__name__)
CORS(app)

# Set up logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Set up API routes
api = Api(app)
api.add_resource(CountriesResource, '/countries')
api.add_resource(CountryCDResource, '/countries/<string:country_code>')
api.add_resource(DivisionsResource, '/countries/<string:countryid>/divisions')
api.add_resource(DivisionIDResource, '/countries/<string:countryid>/divisions/<string:divisionid>')
api.add_resource(SubdivisionsResource, '/countries/<string:countryid>/divisions/<string:divisionid>/subdivisions')

# Set up Swagger UI
SWAGGER_URL = '/docs'
API_URL = 'api/country-subdivision.yaml'
swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL,
    API_URL,
    config={
        'app_name': 'Address API Specification'
    }
)
app.register_blueprint(swaggerui_blueprint, url_prefix=SWAGGER_URL)

def lambda_handler(event, context):
    logging.info('event: {}'.format(event))
    logging.info('context: {}'.format(context))
    proxy_path = event['requestContext']['path']
    if proxy_path == '/':
        proxy_path = '/index.html'
    elif not proxy_path.startswith('/'):
        proxy_path = '/' + proxy_path
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'text/html'
        },
        'body': app.send_static_file('static' + proxy_path)
    }
