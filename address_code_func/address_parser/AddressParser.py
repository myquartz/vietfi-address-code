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
            "division_id": 0,
            "subdivid": 0,
            "subdiv_local_id": "",
            "subdiv_name": "",
            "l2subdiv_local_id": "",
            "l2subdiv_name": "",
            "address_line": "",
            "probability": 1.0,
            "namespace": 0,
        }

        # Init AddressDictionary if not done yet.
        self.adh = ADH(init_conn)
        
        if self.adh.conn is not None:
            self.conn = self.adh.conn
        else:
            self.conn = self.adh.connect_database(self.adh.params)

    # adh.load_special_mapping()
    def create_data(self, initial_division_id=0, initial_division_code="", initial_subdiv_local_id="", initial_l2subdiv_local_id=""):
        global data0
        data = data0.copy()
        data["division_code"] = initial_division_code
        data["division_id"] = initial_division_id
        if( initial_division_id > 0):
            cur = self.conn.cursor()
            sql = "SELECT division_name, division_cd, local_id FROM sys_division WHERE divisionid = ?"
            params = (initial_division_id,)
            row = None
            if sql and params:
                cur.execute(sql, params)
                row = cur.fetchone()
            if row:
                division_name, division_cd, local_id = row[0], row[1], row[2]
                if division_name:
                    data['division_name'] = division_name
                    data['division_code'] = division_cd
                    data['division_local_id'] = local_id
        elif initial_division_code != "":
            cur = self.conn.cursor()
            sql = "SELECT divisionid, division_name, local_id FROM sys_division WHERE division_cd = ?"
            params = (initial_division_code,)
            row = None
            if sql and params:
                cur.execute(sql, params)
                row = cur.fetchone()
            if row:
                division_id, division_name, local_id = row[0], row[1], row[2]
                if division_name:
                    data['division_name'] = division_name
                    data['division_code'] = initial_division_code
                    data['division_local_id'] = local_id
                    data['division_id'] = division_id
        data["subdiv_local_id"] = initial_subdiv_local_id
        if data["division_id"] and initial_subdiv_local_id != "":
            cur = self.conn.cursor()
            sql = "SELECT subdivid, subdiv_name FROM sys_division_sub WHERE divisionid = ? AND subdiv_cd = ?"
            params = (data["division_id"], initial_subdiv_local_id,)
            row = None
            if sql and params:
                cur.execute(sql, params)
                row = cur.fetchone()
            if row:
                subdiv_id, subdiv_name = row[0], row[1]
                if subdiv_name:
                    data['subdiv_name'] = subdiv_name
                    data['subdivid'] = subdiv_id
        data["l2subdiv_local_id"] = initial_l2subdiv_local_id
        if data["division_id"] and data["subdiv_local_id"] and initial_l2subdiv_local_id != "":
            cur = self.conn.cursor()
            sql = "SELECT subdivid, l2subdiv_name FROM sys_division_sub WHERE divisionid = ? AND subdiv_cd = ? AND l2subdiv_cd = ?"
            params = (data["division_id"], data["subdiv_local_id"], initial_l2subdiv_local_id,)
            row = None
            if sql and params:
                cur.execute(sql, params)
                row = cur.fetchone()
            if row:
                l2subdiv_name = row[0]
                if l2subdiv_name:
                    data['l2subdiv_name'] = l2subdiv_name
        return data

    @staticmethod
    def load_special_mapping():
        if not AP.adh.special_loaded:
            AP.adh.load_special_mapping()

    # 1: detecting division
    #        selected_ns_pos: the index of namespace to be detected (1,2,3,4 corresponding to bitwise 1,2,4,8,...).
    #            0 means no namespace selected
    #        temp_str: the string to be detected

    def detect_division(self, data: dict, selected_ns_pos: int, temp_str: str):
        """ Detect division component from an address text """
        cur = self.conn.cursor()

        division_id = data.get("division_id")
        if division_id is None:
            division_id = 0
        
        ns_value = 0
        if selected_ns_pos > 0: # position of the selected namespace value (1,2,4,8,...)
            ns_value = 1 << (selected_ns_pos - 1)
        
        if self.adh.pre_map.get(selected_ns_pos) is None:
            return False

        special_division = self.adh.special_division
        
        word_check = temp_str.strip()
        word_check_lower = ADH.normalize_name(word_check)
        # print("1. word_check:" + word_check)

        if word_check_lower in special_division:
            division_id = special_division[word_check_lower]
        searchRound = 2
        while searchRound > 0:
            if division_id > 0:
                sql = "SELECT divisionid, division_cd, division_name, local_id \
                        FROM sys_division WHERE divisionid = ? AND country_iso3 = ? AND (namespaceset & ? > 0 OR namespaceset = 0)"
                params = (division_id, data["country_code"], ns_value)
            elif self.adh.pre_map[selected_ns_pos].get(1) is None:
                sql = "SELECT divisionid, division_cd, division_name, local_id FROM sys_division \
                        WHERE country_iso3 = ? AND (namespaceset & ? > 0 OR namespaceset = 0) AND lower(division_name) = ?"
                params = (data["country_code"], ns_value, word_check_lower)
                searchRound = 0 # only 1 round
            elif searchRound == 2:
                sql = "SELECT divisionid, division_cd, division_name, local_id \
                                    FROM sys_division \
                                    WHERE country_iso3 = ? AND (namespaceset & ? > 0 OR namespaceset = 0) AND division_name IN (?"

                plist = [data["country_code"], ns_value, word_check]
                
                for key, value in self.adh.pre_map[selected_ns_pos][1].items():
                    if word_check_lower.startswith(key):
                        plist.append(value + ' ' + word_check[len(key):].strip())
                    else:
                        plist.append(value + ' ' + word_check)
                    sql += ",?"
                sql = sql + ")"
                params = tuple(plist)
            elif searchRound == 1:
                # Try with non-accented, lower case string
                sql = "SELECT divisionid, division_cd, division_name, local_id \
                        FROM sys_division \
                        WHERE country_iso3 = ? AND (namespaceset & ? > 0 OR namespaceset = 0) AND lower(unidecode(division_name)) IN (?"
                # cur.execute(sql, params)
                word_check = unidecode(word_check)
                word_check_lower = word_check.lower()
                plist = [data["country_code"], ns_value, word_check_lower]
                for key, value in self.adh.pre_map[selected_ns_pos][1].items():
                    if word_check_lower.startswith(key):
                        plist.append(unidecode(value).lower() + ' ' + word_check_lower[len(key):].strip())
                    else:
                        plist.append(unidecode(value).lower() + ' ' + word_check_lower)
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
                division_id, division_code, division_name, division_local_id = row[0], row[1], row[2], row[3]
                if division_name:
                    data['division_name'] = division_name
                    data['division_code'] = division_code
                    data['division_local_id'] = division_local_id
                    data['division_id'] = division_id
                    data["namespace"] = selected_ns_pos
                    return True
                break
            else:
                searchRound -= 1
                division_id = 0

        return False
    
    ##################################################################################
    # 2: detecting subdiv
    ##################################################################################
    
    def detect_subdiv(self, data: dict, selected_ns_pos: int, temp_str: str):
        # print("2. testing detect_subdiv")
        cur = self.conn.cursor()

        ns_value = 0
        if selected_ns_pos > 0: # position of the selected namespace value (1,2,4,8,...)
            ns_value = 1 << (selected_ns_pos - 1)

        special_division_sub_div = self.adh.special_division_sub_div

        division_id = data.get("division_id")
        subdiv_id = data.get("subdivid")
        if division_id is None or division_id == 0:
            return False
        if subdiv_id is None:
            subdiv_id = 0

        word_check = temp_str.strip()
        word_check_lower = ADH.normalize_name(word_check)
        if subdiv_id == 0 and word_check_lower in special_division_sub_div:
            subdiv_id = special_division_sub_div[word_check_lower]

        searchRound = 2
        while searchRound > 0:
            if subdiv_id > 0:
                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                    WHERE divisionid = ? AND subdivid = ? AND (namespaceset & ? > 0 OR namespaceset = 0)"
                params = (division_id, subdiv_id,ns_value,)
            elif self.adh.pre_map[selected_ns_pos].get(2) is None:
                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                    WHERE divisionid = ? AND l2subdiv_cd = '00000' AND (namespaceset & ? > 0 OR namespaceset = 0) \
                        AND lower(subdiv_name) = ?"
                params = (division_id, ns_value, word_check_lower,)
                searchRound = 0 # only 1 round
            elif searchRound == 2:
                # handle abbreviation of subdivision like q. h.
                # word_ext = self.adh.extend_prefix2fullname(word_check)
                # word_ext = self.adh.extend_prefix_to_fullname(word_check)
                # word_ext = self.adh.normalize_subdiv_name(word_check)
                # Using prefix map normalization.

                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd = '00000'  AND (namespaceset & ? > 0 OR namespaceset = 0) \
                        AND subdiv_name IN (?"

                plist = [division_id, ns_value, word_check, ]

                for key, value in self.adh.pre_map[selected_ns_pos][2].items():
                    if word_check_lower.startswith(key):
                        plist.append(value + ' ' + word_check[len(key):].strip())
                    else:
                        plist.append(value + ' ' + word_check)
                    sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)
            elif searchRound == 1:
                # print("not found search result ")
                # print(row)
                # search with un-accented text using unidecode
                # word_ext = unidecode(word_ext)
                word_check = unidecode(word_check)
                word_check_lower = word_check.lower()
                #word_ext = self.adh.normalize_subdiv_name_un_accented(word_check)

                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                            WHERE divisionid = ? AND l2subdiv_cd = '00000' AND (namespaceset & ? > 0 OR namespaceset = 0) \
                            AND lower(unidecode(subdiv_name)) IN (?"

                plist = [division_id, ns_value, word_check_lower, ]
                # print(plist)

                for key, value in self.adh.pre_map[selected_ns_pos][2].items():
                    if word_check_lower.startswith(key):
                        plist.append(unidecode(value).lower() + ' ' + word_check_lower[len(key):].strip())
                    else:
                        plist.append(unidecode(value).lower() + ' ' + word_check_lower)
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
                    data['subdivid'] = subdiv_id
                    data['subdiv_local_id'] = subdiv_code
                    data['subdiv_name'] = subdiv_name
                    if l2subdiv_code:
                        data['l2subdiv_local_id'] = l2subdiv_code
                    return True
                break
            else:
                searchRound -= 1
                subdiv_id = 0

        return False

    ##################################################################################
    # #3: detecting l2subdiv
    ##################################################################################

    def detect_l2subdiv(self, data: dict, selected_ns_pos: int, temp_str: str):

        ns_value = 0
        if selected_ns_pos > 0: # position of the selected namespace value (1,2,4,8,...)
            ns_value = 1 << (selected_ns_pos - 1)

        cur = self.conn.cursor()

        special_division_sub_div = self.adh.special_division_sub_div

        division_id = data.get("division_id")
        subdiv_code = data.get("subdiv_local_id")
        subdiv_id = data.get("subdivid")
        if division_id is None or division_id == 0 or subdiv_code is None or subdiv_code == '' or subdiv_code == '000':
            return False
        if subdiv_id is None:
            subdiv_id = 0

        word_check = temp_str.strip()
        word_check_lower = ADH.normalize_name(word_check)
        if subdiv_id == 0 and word_check_lower in special_division_sub_div:
            subdiv_id = special_division_sub_div[word_check_lower]

        notFound = 2
        while notFound > 0:
            if subdiv_id > 0:
                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid \
                    FROM sys_division_sub \
                    WHERE divisionid = ? AND subdivid = ? AND (namespaceset & ? > 0 OR namespaceset = 0) AND l2subdiv_cd <> '00000'"
                params = (division_id, subdiv_id, ns_value,)
            elif self.adh.pre_map[selected_ns_pos].get(3) is None:
                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd <> '00000' AND (namespaceset & ? > 0 OR namespaceset = 0) \
                        AND subdiv_cd = ? \
                        AND lower(subdiv_name) = ?"
                params = (division_id, ns_value, subdiv_code, word_check_lower,)
                notFound = 0 # only 1 round
            elif notFound == 2:
                # handle p02 cases

                # word_ext = self.adh.extend_prefix2fullname(word_check)
                # word_ext = self.adh.extend_prefix_to_fullname(word_check)
                # word_ext = self.adh.normalize_subdiv_name(word_check)

                # print("word_ext:", word_ext)
                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd <> '00000' AND (namespaceset & ? > 0 OR namespaceset = 0) \
                        AND subdiv_cd = ? \
                        AND subdiv_name IN(?"

                plist = [division_id, ns_value, subdiv_code, word_check, ]
                for key, value in self.adh.pre_map[selected_ns_pos][3].items():
                    if word_check_lower.startswith(key):
                        plist.append(value + ' ' + word_check[len(key):].strip())
                    else:
                        plist.append(value + ' ' + word_check)
                    sql = sql + ",?"
                sql = sql + ")"
                params = tuple(plist)
            elif notFound == 1:
                # searching using un-accented text
                # print("l2subdiv_code not found in search result ")
                # print(row)
                # word_ext = unidecode(word_ext)
                word_check = unidecode(word_check)
                word_check_lower = word_check.lower()
                # word_ext = self.adh.normalize_subdiv_name_un_accented(word_check)

                sql = "SELECT l2subdiv_cd, subdiv_name, subdivid FROM sys_division_sub \
                        WHERE divisionid = ? AND l2subdiv_cd <> '00000' AND (namespaceset & ? > 0 OR namespaceset = 0) \
                        AND subdiv_cd = ? \
                        AND lower(unidecode(subdiv_name)) IN(?"

                plist = [division_id, ns_value, subdiv_code, word_check_lower,]
                for key, value in self.adh.pre_map[selected_ns_pos][3].items():
                    if word_check_lower.startswith(key):
                        plist.append(unidecode(value).lower() + ' ' + word_check_lower[len(key):].strip())
                    else:
                        plist.append(unidecode(value).lower() + ' ' + word_check_lower)
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
                    data['subdivid'] = subdiv_id
                    return True
                break
            else:
                notFound -= 1
                subdiv_id = 0
        return False

    def detect_address(self, namespaces_pos: list[int], address_text: str):
        global data0

        # detect address codes from address_text
        # Step 1: normalize address_text
        # Step 2: split address text into words
        array = re.split(r'[,;\n]\s*', address_text.strip())
        # array_len = len(array) - 1

        all_namespace_set_data = {}       # result set for all namespace set

        # bitwise value for namespace (each bit represent a level of address component)
        if len(namespaces_pos) == 0:
            namespaces_pos = [0]

        division_result = {} # division detection result by id for the namespace
        subdiv_result = {}
        l2subdiv_result = {}
        tempStr = ""

        for selected_ns_pos in namespaces_pos:
            data: dict[str, Union[str, int]] = self.create_data()

            # ns_value = 0  # no selected, start from 1 for rightmost bit
            # if selected_ns_pos > 0:  # position of the selected namespace value (1,2,4,8,...)
            #    ns_value = 1 << (selected_ns_pos - 1)

            # Step main loop thru the array
            # k = array_len
            # for k in range(len(array) - 1, -1, -1):
            k = len(array)
            for tempStr in reversed(array):
                tempStr = tempStr
                # print(k, tempStr)
                # detect division for all namespaces
            
                if division_result.get(selected_ns_pos) is None:
                    if self.detect_division(data, selected_ns_pos, tempStr):
                        division_id = data.get("division_id")
                        # neu khong co division thi khong can lam gi nua
                        if division_id is None or division_id == 0:
                            break
                        else:
                            division_result[selected_ns_pos] = division_id
                            subdiv_result[selected_ns_pos] = None
                            l2subdiv_result[selected_ns_pos] = None
                            k -= 1
                    else:
                        break
                    continue

                if subdiv_result[selected_ns_pos] is None:
                    # detect subdivision                    
                    if self.detect_subdiv(data, selected_ns_pos, tempStr):
                        # print("proc 4.2:", data)
                        subdiv_code = data.get("subdiv_local_id")
                        # neu subdiv_code khong co thi khong can lam gi nua
                        if subdiv_code is None or subdiv_code == '' or subdiv_code == '000':
                            break
                        else:
                            subdiv_result[selected_ns_pos] = subdiv_code
                            l2subdiv_result[selected_ns_pos] = None
                            k -= 1
                    else:
                        break
                    continue

                if l2subdiv_result[selected_ns_pos] is None:
                    # detect l2subdivision
                    if self.detect_l2subdiv(data, selected_ns_pos, tempStr):
                        # print("proc 4.3:", data)
                        l2subdiv_code = data.get("l2subdiv_local_id")
                        # neu l2subdiv_code khong co thi khong can lam gi nua
                        if l2subdiv_code is not None and l2subdiv_code != '' and l2subdiv_code != '00000':
                            l2subdiv_result[selected_ns_pos] = l2subdiv_code
                            k -= 1
                    break
                    # continue
                if k == 0:
                    break
            
            data["address_line"] = ", ".join(array[0:k])
            all_namespace_set_data[selected_ns_pos] = data


        return all_namespace_set_data
