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

# default to Unicode
#if sys.version_info.major < 3:
#    reload(sys)
#sys.setdefaultencoding('utf8')
#sys.stdout.reconfigure(encoding="utf-8")

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
#api.add_resource(SubDivisionsResource, '/countries/<string:countryid>/divisions/<string:subdivision_code>/subdivisions')

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
# TODO: fix error message api/country-subdivision.yaml not found

if __name__ == '__main__':
    app.run(debug=True)
    app.config['JSON_AS_ASCII'] = False
