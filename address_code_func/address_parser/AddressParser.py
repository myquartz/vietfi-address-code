import re
from typing import Union

from unidecode import unidecode

from .ADHelper import ADH


# result set of the address parser


class AP:
    # data structure of normalized address
    def __init__(self, init_conn=None):
        global data0
        data0 = {
            "country_code": "VNM",
            "division_name": "",
            "division_code": "",
            "division_local_id": "",
            "subdiv_local_id": "",
            "subdiv_name": "",
            "l2subdiv_local_id": "",
            "l2subdiv_name": "",
            "address_line": "",
            "probability": 1.0,
        }

        # Init AddressDictionary if not done yet.
        self.adh = ADH(init_conn)

        self.data = data0
        self.space_location = 0
        if self.adh.conn is not None:
            self.conn = self.adh.conn
        else:
            self.conn = self.adh.connect_database(self.adh.params)

    # adh.load_special_mapping()
    def reset_data(self):
        global data0
        self.data = data0
        self.space_location = 0
        return self.data

    @staticmethod
    def load_special_mapping():
        if not AP.adh.special_loaded:
            AP.adh.load_special_mapping()

    def detect_division(self, temp_str):
        """ Detect division component from an address text """
        cur = self.conn.cursor()
        division_id = 0
        data = self.data
        data["country_code"] = "VNM"
        data["division_code"] = ""
        special_division = self.adh.special_division
        
        word_check = temp_str.lower().strip()
        # print("1. word_check:" + word_check)
        
        if word_check in special_division:
            division_id = special_division[word_check]
        notFound = 2
        while notFound > 0:
            if division_id > 0:
                sql = "SELECT divisionid, division_cd, division_name, local_id \
                        FROM sys_division WHERE divisionid = ?"
                params = (division_id,)
            elif notFound == 2:
                sql = "SELECT divisionid, division_cd, division_name, local_id \
                                    FROM sys_division \
                                    WHERE country_iso3 = ? AND division_name IN (?"
            
                plist = [self.adh.country_code, word_check]
                for key, value in self.adh.pre_map.items():
                    if key[1] == 1:
                        plist.append(value + ' ' + word_check.removeprefix(key[0].lower()).strip())
                        sql += ",?"
                sql = sql + ")"
                params = tuple(plist)
            elif notFound == 1:
                # Try with non-accented string
                sql = "SELECT divisionid, division_cd, division_name, local_id \
                        FROM sys_division \
                        WHERE country_iso3 = ? AND casefold(unidecode(division_name)) IN (?"
                # cur.execute(sql, params)
                word_check = unidecode(word_check)
                plist = [self.adh.country_code, word_check]
                for key, value in self.adh.pre_map.items():
                    if key[1] == 1:
                        plist.append(unidecode(value) + ' ' + word_check.removeprefix(key[0].lower()).strip())
                        sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)

            row = None
            if sql and params:
                #print('detect_division - params', sql, params)
                #query the database
                cur.execute(sql, params)
                row = cur.fetchone()

            # print(row)
            # Found a row
            if row:
                division_id, division_iso, division_name, division_local_id = row[0], row[1], row[2], row[3]
                if division_name:
                    data['division_name'] = division_name
                    data['division_iso'] = division_iso
                    data['division_local_id'] = division_local_id
                    data['division_id'] = division_id
                break
            else:
                notFound -= 1
                division_id = 0

        return data

    def detect_subdiv(self, temp_str):
        # print("2. testing detect_subdiv")
        cur = self.conn.cursor()

        special_division_sub_div = self.adh.special_division_sub_div

        data = self.data
        division_id = data["division_id"]
        subdiv_code = data["subdiv_local_id"]
        if division_id == 0:
            return data
        
        subdiv_id = 0
        word_check = temp_str.lower().strip()
        if word_check in special_division_sub_div:
            subdiv_id = special_division_sub_div[word_check]

        notFound = 2
        while notFound > 0:
            if subdiv_id > 0:
                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid \
                    FROM sys_division_sub \
                    WHERE divisionid = ? AND subdivid = ?"
                params = (division_id, subdiv_id,)
            elif notFound == 2:
                # handle abbreviation of subdivision like q. h.
                # word_ext = self.adh.extend_prefix2fullname(word_check)
                # word_ext = self.adh.extend_prefix_to_fullname(word_check)
                word_ext = self.adh.normalize_subdiv_name(word_check)

                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd = '00000' \
                        AND subdiv_name IN (?,?"

                plist = [division_id, word_check, word_ext, ]

                for key, value in self.adh.pre_map.items():
                    if key[1] == 2:
                        plist.append(value + ' ' + word_check.removeprefix(key[0].lower()).strip())
                        sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)
            elif notFound == 1:
                # print("not found search result ")
                # print(row)
                # search with un-accented text using unidecode
                # word_ext = unidecode(word_ext)
                word_check = unidecode(word_check)
                word_ext = self.adh.normalize_subdiv_name_un_accented(word_check)

                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                            WHERE divisionid = ? AND l2subdiv_cd = '00000' \
                            AND casefold(unidecode(subdiv_name)) IN (?,?"

                plist = [division_id, word_check, word_ext, ]
                # print(plist)

                for key, value in self.adh.pre_map.items():
                    if key[1] == 2:
                        plist.append(unidecode(value) + ' ' + word_check.removeprefix(key[0]).strip())
                        sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)

            row = None
            if sql and params:
                # print('detect_subdiv - params', params)
                cur.execute(sql, params)
                row = cur.fetchone()
            
            if row:
                subdiv_code, l2subdiv_code, subdiv_name, subdiv_id = row[0], row[1], row[2], row[3]
                if subdiv_code:
                    data['subdiv_local_id'] = subdiv_code
                    data['subdiv_name'] = subdiv_name
                    if l2subdiv_code:
                        data['l2subdiv_local_id'] = l2subdiv_code
                break
            else:
                notFound -= 1
                subdiv_id = 0

        return data

    # #3: detecting l2subdiv
    def detect_l2subdiv(self, temp_str):

        cur = self.conn.cursor()

        special_division_sub_div = self.adh.special_division_sub_div

        data: dict[str, Union[str, int]] = self.data
        division_id = data["division_id"]
        subdiv_code = data["subdiv_local_id"]
        #l2subdiv_code = data["l2subdiv_local_id"]

        subdiv_id = 0
        word_check = temp_str.lower().strip()
        if word_check in special_division_sub_div:
            subdiv_id = special_division_sub_div[word_check]

        notFound = 2
        while notFound > 0:
            if subdiv_id > 0:
                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid \
                    FROM sys_division_sub \
                    WHERE divisionid = ? AND subdivid = ?"
                params = (division_id, subdiv_id,)
            elif notFound == 2:
                # handle p02 cases

                # word_ext = self.adh.extend_prefix2fullname(word_check)
                # word_ext = self.adh.extend_prefix_to_fullname(word_check)
                word_ext = self.adh.normalize_subdiv_name(word_check)

                # print("word_ext:", word_ext)
                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd <> '00000' \
                        AND subdiv_cd = ? \
                        AND subdiv_name IN(?,?"

                plist = [division_id, subdiv_code, word_check.strip(), word_ext, ]
                for key, value in self.adh.pre_map.items():
                    if key[1] == 3:
                        plist.append(value + ' ' + word_check.removeprefix(key[0].lower()).strip())
                        sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)
            elif notFound == 1:
                # searching using un-accented text
                # print("l2subdiv_code not found in search result ")
                # print(row)
                # word_ext = unidecode(word_ext)
                word_check = unidecode(word_check)
                word_ext = self.adh.normalize_subdiv_name_un_accented(word_check)

                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd <> '00000' \
                        AND subdiv_cd = ? \
                        AND casefold(unidecode(subdiv_name)) IN(?,?"

                plist = [division_id, subdiv_code, word_check.strip(), word_ext, ]
                for key, value in self.adh.pre_map.items():
                    if key[1] == 3:
                        plist.append(unidecode(key[0]) + ' ' + word_check.strip())
                        sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)

            row = None
            if sql and params:
                cur.execute(sql, params)
                row = cur.fetchone()

            if row:
                l2subdiv_code, l2subdiv_name, subdiv_id = row[0], row[1], row[2]
                if l2subdiv_code:
                    data['l2subdiv_local_id'] = l2subdiv_code
                    data['l2subdiv_name'] = l2subdiv_name
                break
            else:
                notFound -= 1
                subdiv_id = 0
        return data

    def detect_address(self, address_text: str):
        global data0
        # detect address codes from address_text
        # Step 1: normalize address_text
        # Step 2: split address text into words
        array = re.split(r'[,;\n]\s*', address_text.strip())
        array_len = len(array) - 1

        AP.reset_data(AP)  # reset data record
        data: dict[str, Union[str, int]] = self.data

        division_id = 0
        subdiv_code = None
        l2subdiv_code = None
        tempStr = ""

        # Step main loop thru the array
        # k = array_len
        # for k in range(len(array) - 1, -1, -1):
        k = len(array)
        for tempStr in reversed(array):
            tempStr = tempStr.lower().strip()
            # print(k, tempStr)
            # detect division
            if division_id == 0:
                data = self.detect_division(tempStr)
                division_id = data.get("division_id")
                # neu khong co division thi khong can lam gi nua
                if division_id is None or division_id == 0:
                    break
                else:
                    k -= 1
                continue

            if subdiv_code is None:
                # detect subdivision
                data1 = self.detect_subdiv(tempStr)
                if data1 is not None:
                    data = data1
                    # print("proc 4.2:", data)
                    subdiv_code = data.get("subdiv_local_id")
                    # neu subdiv_code khong co thi khong can lam gi nua
                    if subdiv_code is None or subdiv_code == '' or subdiv_code == '000':
                        break
                    else:
                        k -= 1
                else:
                    break
                continue

            if l2subdiv_code is None:
                # detect l2subdivision
                data1 = self.detect_l2subdiv(tempStr)
                if data1 is not None:
                    data = data1
                    # print("proc 4.3:", data)
                    l2subdiv_code = data.get("l2subdiv_local_id")
                    # neu l2subdiv_code khong co thi khong can lam gi nua
                    if l2subdiv_code is not None and l2subdiv_code != '' and l2subdiv_code != '00000':
                        k -= 1
                break
                # continue
            if k == 0:
                break
        data["address_line"] = ", ".join(array[0:k])
        return data
