# Address Helper Classes
"""
  2023-05-18 ADH is now __init__ specifically by country_code
"""
import logging
import os.path
import sys
# import pathlib
import sqlite3
import json
# ko con su dung import yaml
#import yaml
import re
from typing import Dict
import unicodedata

from unidecode import unidecode

global APP_PATH
global LOG_DIR
global DB_DIR


APP_PATH = os.getcwd()


class CustomLogger(logging.Logger):
    """
    Custom Logger supporting UTF8 and indented JSON format
    """

    def __init__(self, name=None, level=logging.DEBUG):
        super().__init__(name, level)

        if name is not None:
            # Create a handler that will write to a log file
            # file_name = logging.getLogger()
            file_handler = logging.FileHandler(name)  #
            file_handler.setLevel(level)

            # Create a formatter that will format the log messages
            formatter = logging.Formatter(
                '{"asctime": "%(asctime)s", "name": "%(name)s", "level": "%(levelname)s", "message": %(message)s},')
            file_handler.setFormatter(formatter)

            # Add the handler to the logger
            self.addHandler(file_handler)
        else:
            formatter = logging.Formatter('%(name)s %(levelname)s: %(message)s')
            # Create a stream handler for console output (stdout)
            stream_handler = logging.StreamHandler(sys.stdout)
            stream_handler.setFormatter(formatter)
            self.addHandler(stream_handler)

    def makeRecord(self, name, level, fn, lno, msg, args, exc_info, func=None, extra=None, sinfo=None, **kwargs):
        if extra is None:
            extra = {}
        elif not isinstance(extra, dict):
            raise TypeError("extra should be a dictionary")

        # Add your custom logic to handle extra fields
        # For example, add the extra fields to the log message
        if isinstance(msg, dict):
            msg.update(extra)
            msg = json.dumps(msg, ensure_ascii=False, indent=4)
        else:
            # msg = {'message': msg, **extra}
            msg = json.dumps(msg, ensure_ascii=False, indent=4)
        return super().makeRecord(name, level, fn, lno, msg, args, exc_info, func=func, extra=extra, sinfo=sinfo,
                                  **kwargs)


class ADH:
    """
    Helper Class for address text parsing
    1. Address prefix constants and normalization
    2. Preloaded special addresses from sqlite3 db
    3. Parameters and Db connections
    """
    # country specifics
    country_code = None
    # # setup address prefix normalized constants
    # NORM_TP = "TP. ".lower()
    # NORM_TINH = "Tỉnh ".lower()
    # NORM_QUAN = "Quận ".lower()
    # NORM_HUYEN = "Huyện ".lower()
    # NORM_TX = "Thị xã ".lower()
    # NORM_THANHPHO = "Thành phố ".lower()
    # NORM_PHUONG = "Phường ".lower()
    # NORM_XA = "Xã ".lower()
    # NORM_TT = "Thị trấn ".lower()
    #
    # prefix_mapping = {
    #     "tp.": NORM_TP,
    #     "tp ": NORM_TP,
    #     "tx.": NORM_TX,
    #     "tt.": NORM_TT,
    #     "tt ": NORM_TT,
    #     "q.": NORM_QUAN,
    #     "q ": NORM_QUAN,
    #     "h.": NORM_HUYEN,
    #     "p.": NORM_PHUONG,
    #     "x.": NORM_XA
    # }
    # global prefix_mapping
    subdiv_mapping = {
        'q': 'quận',
        'quận': 'quận',
        'p': 'phường',
        'phường': 'phường'
        # Add more division mappings as needed
    }

    subdiv_mapping_un_accented = {
        'q': 'quan',
        'quan': 'quan',
        'p': 'phuong',
        'phuong': 'phuong'
        # Add more division mappings as needed
    }

    pre_dic = {}        # prefix dictionary for normalization
    pre_map = {}
    # address data structure
    data = {
        "country_code": "VNM",
        "division_name": "",
        "division_code": ""
    }

    # params as configuration parameters
    params = None
    # Connect to the address database in sqlite3
    plogger = None

    special_division: Dict[str, int] = {}
    special_division_sub_div: Dict[str, int] = {}
    special_loaded = False

    def __init__(self, init_conn=None, init_country="VNM"):
        if init_conn is None:
            # Load the parameters from the YAML file
            # change to absolute path
            # current_path = os.path.abspath(__file__)
            # script_directory = os.path.dirname(current_path)
            # config_file_path = os.path.join(script_directory, "..", "parameters.yaml")
            #
            # with open(config_file_path, "r") as f:
            #     self.params = yaml.safe_load(f)
            #
            # logfile = self.params["logs"]["path"]
            logdir = os.getenv('LOG_DIR', '/tmp')
            if not os.path.exists(logdir):
                os.makedirs(logdir)
            logfile = logdir + '/' + 'addressparser.log'
            self.plogger = CustomLogger(logfile)
            if self.plogger is None:
                print("Something wrong!")
                exit(98)
            self.conn = self.connect_database()
        else:
            self.plogger = CustomLogger()
            self.conn = init_conn
            self.conn.create_function("CASEFOLD", 1, case_fold)
            self.conn.create_function("UNIDECODE", 1, uni_decode)

        self.plogger.info("Starting new address parsing session")
        
        if init_country is not None:
            self.country_code = init_country
        else:
            self.country_code = "VNM"

        # creating dictionary of constants
        self.pre_map = self.create_prefix_mapping()
        self.pre_dic = self.create_prefix_dictionary()

        self.load_special_mapping()

    # def __del__(self):
    #     self.conn.close()

    # create custom functions for Sqlite3 connection
    global case_fold
    def case_fold(s: str):
        return s.casefold()

    global uni_decode
    def uni_decode(s: str):
        return unidecode(s)

    def connect_database(self):
        # Connect to the address database in sqlite3

        # dbfile = params["database"]["path"]
        dbfile = os.getenv('DB_DIR', '/tmp') + '/' + 'address_db.sqlite3'

        if os.path.isfile(dbfile):
            try:
                conn = sqlite3.connect(dbfile)
                if conn:
                    # print
                    conn.create_function("CASEFOLD", 1, case_fold)
                    conn.create_function("UNIDECODE", 1, uni_decode)
                    return conn
                else:
                    #print("Failed to connect to database")
                    self.plogger.error("Failed to connect to database")
                    sys.exit()

            except sqlite3.Error as e:
                # print("Database connection error: ", e)
                # self.plogger.logger.error("Failed to connect to database")
                self.plogger.error("Database connection error: \n" + str(e))

                sys.exit()
        else:
            self.plogger.error(dbfile + " does not exist!")
            sys.exit()
        return conn

    def create_prefix_mapping(self):
        _pre_map = {}
        cur = self.conn.cursor()
        sql = "select lower(prefix), lower(name), unit_level \
               from sys_prefix \
               where country_code = ?"
        # print(self.country_code)
        params = (self.country_code,)
        cur.execute(sql, params)
        rows = cur.fetchall()
        # print(rows)
        for row in rows:
            _pre_map[row[0], row[2]] = row[1]

        cur.close()
        return _pre_map



    def create_prefix_dictionary(self):
        # Connect to the SQLite database
        cur = self.conn.cursor()
        sql = "select lower(prefix), lower(name), unit_level \
                       from sys_prefix \
                       where country_code = ?"

        params = (self.country_code,)
        cur.execute(sql, params)

        # Initialize the pre_map dictionary
        pre_map = {}

        # Iterate over the query results
        for row in cur.fetchall():
            unit_level = row[2]
            prefix = row[0]
            fullname = row[1]

            # Create the nested dictionaries if needed
            if unit_level not in pre_map:
                pre_map[unit_level] = {}

            # Add the prefix and fullname to the pre_map dictionary
            pre_map[unit_level][prefix] = fullname

        # Close the database cursor
        cur.close()

        return pre_map

    def extend_prefix2fullname(self, word_check: str):
        """ Extend address with prefix to full name """
        word = word_check.lower().strip()
        ext = [value + ' ' + word[len(key[0]):].strip() for key, value in self.pre_map.items() if
               word.startswith(key[0])]
        fullname = ext[0] if ext else ""
        return fullname

    def extend_prefix_to_fullname(self, word_check):
        """extend prefix abbreviation into full prefix"""

        if re.match(r"^[qQ]\d+.*", word_check):
            return self.NORM_QUAN + word_check[1:].strip()
        elif re.match(r"^[pP]\d+.*", word_check):
            return self.NORM_PHUONG + word_check[1:].strip()

        for prefix, normalized_prefix in self.pre_map.items():
            if word_check.lower().startswith(prefix[0]):
                return normalized_prefix + word_check[len(prefix[0]):].strip()

        return None

    def normalize_subdiv_name(self, input_text):
        # Remove non-alphanumeric characters and convert to lowercase
        #BUG: normalized_text = re.sub(r'[^a-zA-Z0-9]+', ' ', input_text.lower())
        normalized_text = input_text.lower()
        #print(normalized_text)

        # Extract the division prefix and number
        match = re.match(r'([a-z]+)\s*(\d+)', normalized_text)
        if match:
            div_prefix = match.group(1)
            div_number = int(match.group(2))

            # Normalize the division prefix
            div_name = self.subdiv_mapping.get(div_prefix, div_prefix)
            if div_name == 'phường':
                normalized_text = f"{div_name} {div_number:02d}"
            else:
                normalized_text = f"{div_name} {div_number:d}"

        return normalized_text

    def normalize_subdiv_name_un_accented(self, input_text):
        # Remove non-alphanumeric characters and convert to lowercase
        #BUG: normalized_text = re.sub(r'[^a-zA-Z0-9]+', ' ', input_text.lower())
        normalized_text = input_text.lower()
        #print(normalized_text)

        # Extract the division prefix and number
        match = re.match(r'([a-z]+)\s*(\d+)', normalized_text)
        if match:
            div_prefix = match.group(1)
            div_number = int(match.group(2))

            # Normalize the division prefix
            div_name = self.subdiv_mapping_un_accented.get(div_prefix, div_prefix)
            if div_name == 'phuong':
                normalized_text = f"{div_name} {div_number:02d}"
            else:
                normalized_text = f"{div_name} {div_number:d}"

        return normalized_text
    def load_special_mapping(self):
        special_division: Dict[str, int] = {}
        special_division_sub_div: Dict[str, int] = {}
        if self.special_loaded:
            return
        try:
            sql = "Select divisionid, division_name \
                From sys_division \
                WHERE division_name LIKE '%-%' \
                UNION ALL \
                Select divisionid, division_name \
                From special_division"
            cur = self.conn.cursor()
            cur.execute(sql)
            for row in cur.fetchall():
                division_id = row[0]
                division_name = unicodedata.normalize('NFD', row[1]).strip().replace('-', ' ').lower()
                division_name = re.sub(r'\s+', ' ', division_name)

                special_division[division_name] = division_id

                # if self.NORM_TINH in division_name:
                #     special_division[division_name.replace(self.NORM_TINH, '').strip()] = division_id
                # elif self.NORM_TP in division_name:
                #     special_division[division_name.replace(self.NORM_TP, '').strip()] = division_id

        except Exception as e:
            self.plogger.logger.error(str(e) + "db error!")
            raise RuntimeError(e)
            sys.exit(1)
        # finally:
        #     if cur is not None:
        #         cur.close()
        self.special_division = special_division

        # load special divison_sub
        try:
            sql = "Select subdivid, subdiv_name  \
            From sys_division_sub \
            Where subdiv_name Like '%-%' \
            ORDER BY subdiv_name"
            cur = self.conn.cursor()
            cur.execute(sql)
            for row in cur.fetchall():
                division_sub_id = row[0]
                division_sub_name = unicodedata.normalize('NFD', row[1]).replace('-', ' ').lower()
                division_sub_name = re.sub(r'\s+', ' ', division_sub_name)

                special_division_sub_div[division_sub_name] = division_sub_id

                # if self.NORM_QUAN in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_QUAN, '').strip()] = division_sub_id
                # elif self.NORM_HUYEN in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_HUYEN, '').strip()] = division_sub_id
                # elif self.NORM_TX in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_TX, '').strip()] = division_sub_id
                # elif self.NORM_THANHPHO in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_THANHPHO, '').strip()] = division_sub_id
                # elif self.NORM_PHUONG in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_PHUONG, '').strip()] = division_sub_id
                # elif self.NORM_XA in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_XA, '').strip()] = division_sub_id
                # elif self.NORM_TT in division_sub_name:
                #     special_division_sub_div[
                #         division_sub_name.replace(self.NORM_TT, '').strip()] = division_sub_id

        except Exception as e:
            raise RuntimeError(e)
            sys.exit(1)
        # finally:
        #     if cur is not None:
        #         cur.close()
        # self.special_division_sub_div = special_division_sub_div

        # re-organized code
        # prefixes = [self.NORM_QUAN, self.NORM_HUYEN, self.NORM_TX, self.NORM_THANHPHO,
        #             self.NORM_PHUONG, self.NORM_XA, self.NORM_TT]
        # try:
        #     sql = "SELECT subdivid, subdiv_name FROM sys_division_sub WHERE subdiv_name LIKE '%-%'"
        #     cur = self.conn.cursor()
        #     cur.execute(sql)
        #
        #     for row in cur.fetchall():
        #         division_sub_id = row[0]
        #         division_sub_name = unicodedata.normalize('NFD', row[1]).replace('-', ' ').lower()
        #         division_sub_name = re.sub(r'\s+', ' ', division_sub_name)
        #
        #         for prefix in prefixes:
        #             if prefix in division_sub_name:
        #                 normalized_name = division_sub_name.replace(prefix, '').strip()
        #                 special_division_sub_div[normalized_name] = division_sub_id
        #
        # except Exception as e:
        #     raise RuntimeError(e)
        #     sys.exit(1)

        # return results
        if self.special_division:
            self.special_loaded = True
            self.special_division = special_division
            self.special_division_sub_div = special_division_sub_div

        # self.conn.close()
