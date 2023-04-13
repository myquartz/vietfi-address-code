import sqlite3
import json
from email.header import UTF8

from flask import abort, jsonify, Response
from flask_restful import Resource


class CountriesResource(Resource):
    def get(self):
        try:
            conn = sqlite3.connect('db/address_db.sqlite3')
            c = conn.cursor()
            c.execute("SELECT countryid, country_name, iso3, iso2, phonecode FROM sys_country")
            countries = c.fetchall()
            conn.close()
            return jsonify(countries)
        except Exception as e:
            abort(500, str(e))

class CountryCDResource(Resource):
    def get(self, country_code):
        try:
            conn = sqlite3.connect('db/address_db.sqlite3')
            c = conn.cursor()
            c.execute("SELECT countryid, country_name, iso3, iso2, phonecode FROM sys_country \
                        WHERE iso3 = ?", (country_code,))
            country = c.fetchall()
            conn.close()

            str = jsonify(country)

            return str
        except Exception as e:
            abort(500, str(e))

class DivisionsResource(Resource):
    def get(self, countryid):
        try:
            conn = sqlite3.connect('db/address_db.sqlite3')
            c = conn.cursor()
            c.execute("SELECT  divisionid, division_cd, division_name, gso_code, los_code \
	                    FROM  sys_division \
	                    WHERE countryid = ?", (countryid,))
            divisions = c.fetchall()
            conn.close()
            response = jsonify(divisions)
            response.headers["Content-Type"] = "application/json"
            
            return response
        except Exception as e:
            abort(500, str(e))

class DivisionIDResource(Resource):
    def get(self, countryid,divisionid):
        try:
            conn = sqlite3.connect('db/address_db.sqlite3')
            c = conn.cursor()
            c.execute("SELECT  divisionid, division_cd, division_name, gso_code, los_code \
	                    FROM  sys_division \
	                    WHERE countryid = ? AND divisionid = ?", (countryid,divisionid))
            division = c.fetchall()
            conn.close()
            return jsonify(division)
        except Exception as e:
            abort(500, str(e))
class SubdivisionsResource(Resource):
    def get(self, countryid, divisionid):
        try:
            conn = sqlite3.connect('db/address_db.sqlite3')
            c = conn.cursor()
            c.execute("SELECT subdivid, subdiv_cd, l2subdiv_cd, subdiv_name, los_code_sub,b.divisionid, b.countryid \
                        from sys_division_sub a, sys_division b \
                        WHERE a.divisionid = b.divisionid \
                        AND b.countryid = ? AND a.divisionid = ? \
                        ORDER by a.subdivid", (countryid, divisionid))

            subdivisions = c.fetchall()
            conn.close()
            return jsonify(subdivisions)
        except Exception as e:
            abort(500, str(e))

