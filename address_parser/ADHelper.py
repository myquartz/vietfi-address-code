# Address Helper Classes
import logging
import os.path
import sys
import pathlib
import sqlite3
import json
import yaml
import re
from typing import Dict
import unicodedata


class CustomLogger(logging.Logger):
    """
    Custom Logger supporting UTF8 and indented JSON format
    """
    def __init__(self, name, level=logging.DEBUG):
        super().__init__(name, level)

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
    # setup address prefix normalized constants
    NORM_TP = "TP. ".lower()
    NORM_TINH = "Tỉnh ".lower()
    NORM_QUAN = "Quận ".lower()
    NORM_HUYEN = "Huyện ".lower()
    NORM_TX = "Thị xã ".lower()
    NORM_THANHPHO = "Thành phố ".lower()
    NORM_PHUONG = "Phường ".lower()
    NORM_XA = "Xã ".lower()
    NORM_TT = "Thị trấn ".lower()

    prefix_mapping = {
        "tp.": NORM_TP,
        "tp ": NORM_TP,
        "tx.": NORM_TX,
        "tt.": NORM_TT,
        "tt ": NORM_TT,
        "q.": NORM_QUAN,
        "q ": NORM_QUAN,
        "h.": NORM_HUYEN,
        "p.": NORM_PHUONG,
        "x.": NORM_XA
    }

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

    def __init__(self):
        # Load the parameters from the YAML file
        print("__init__ ADH")
        with open("./parameters.yaml", "r") as f:
            self.params = yaml.safe_load(f)

        logfile = self.params["logs"]["path"]
        self.plogger = CustomLogger(logfile)
        if self.plogger is None:
            print("Something wrong!")
            exit(98)

        self.plogger.info("Starting new address parsing session")

        self.conn, self.cur = self.connect_database(self.params)

        self.load_special_mapping()

    # def __del__(self):
    #     self.conn.close()

    def connect_database(self, params):
        # Connect to the address database in sqlite3

        dbfile = params["database"]["path"]
        if os.path.isfile(dbfile):
            try:
                conn = sqlite3.connect(dbfile)
                cur = conn.cursor()
                if conn and cur:
                    # print("Database connection successful")
                    return conn, cur
                else:
                    print("Failed to connect to database")
                    self.plogger.error("Failed to connect to database")
                    sys.exit()

            except sqlite3.Error as e:
                # print("Database connection error: ", e)
                # self.plogger.logger.error("Failed to connect to database")
                self.plogger.error("Database connection error: \n" + str(e))
                # , extra={
                #     "input_address": "none",
                #     "parsed_address": "none",
                #     "error_message": str(e)
                # })
                sys.exit()
        else:
            self.plogger.error(dbfile + " does not exist!")
            sys.exit()
        return conn, cur

    def get_extended_prefix(self, word_check):
        """extend prefix abbreviation into full prefix"""

        if re.match(r"^[qQ]\d+.*", word_check):
            return self.NORM_QUAN + word_check[1:].strip()
        elif re.match(r"^[pP]\d+.*", word_check):
            return self.NORM_PHUONG + word_check[1:].strip()

        for prefix, normalized_prefix in self.prefix_mapping.items():
            if word_check.lower().startswith(prefix):
                return normalized_prefix + word_check[len(prefix):].strip()

        return None

    def load_special_mapping(self):
        special_division: Dict[str, int] = {}
        special_division_sub_div: Dict[str, int] = {}
        if self.special_loaded:
            return
        try:
            sql = "Select divisionid, division_name From sys_division WHERE division_name LIKE '%-%' ORDER BY division_name"
            cur = self.conn.cursor()
            cur.execute(sql)
            for row in cur.fetchall():
                division_id = row[0]
                division_name = unicodedata.normalize('NFD', row[1]).strip().replace('-', ' ').lower()
                division_name = re.sub(r'\s+', ' ', division_name)

                special_division[division_name] = division_id

                if self.NORM_TINH in division_name:
                    special_division[division_name.replace(self.NORM_TINH, '').strip()] = division_id
                elif self.NORM_TP in division_name:
                    special_division[division_name.replace(self.NORM_TP, '').strip()] = division_id

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
            sql = "Select subdivid, subdiv_name  From sys_division_sub Where subdiv_name Like '%-%' ORDER BY subdiv_name"
            cur = self.conn.cursor()
            cur.execute(sql)
            for row in cur.fetchall():
                division_sub_id = row[0]
                division_sub_name = unicodedata.normalize('NFD', row[1]).replace('-', ' ').lower()
                division_sub_name = re.sub(r'\s+', ' ', division_sub_name)

                special_division_sub_div[division_sub_name] = division_sub_id

                if self.NORM_QUAN in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_QUAN, '').strip()] = division_sub_id
                elif self.NORM_HUYEN in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_HUYEN, '').strip()] = division_sub_id
                elif self.NORM_TX in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_TX, '').strip()] = division_sub_id
                elif self.NORM_THANHPHO in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_THANHPHO, '').strip()] = division_sub_id
                elif self.NORM_PHUONG in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_PHUONG, '').strip()] = division_sub_id
                elif self.NORM_XA in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_XA, '').strip()] = division_sub_id
                elif self.NORM_TT in division_sub_name:
                    special_division_sub_div[
                        division_sub_name.replace(self.NORM_TT, '').strip()] = division_sub_id

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
