import re
from typing import Union
from address_parser.ADHelper import ADH


class AP:
    # data structure of normalized address
    # result set of the address parser
    data0 = {
        "country_code": "VNM",
        "division_name": "",
        "division_code": "",
        "division_id": 0,
        "subdiv_code": "",
        "subdiv_name": "",
        "l2subdiv_code": "",
        "l2subdiv_name": "",
        "address_line": "",
    }
    data = data0
    space_location = 0

    # Init AddressDictionary if not done yet.
    adh = ADH()

    # adh.load_special_mapping()
    def reset_data(self):
        self.data0 = {
            "country_code": "VNM",
            "division_name": "",
            "division_code": "",
            "division_id": 0,
            "subdiv_code": "",
            "subdiv_name": "",
            "l2subdiv_code": "",
            "l2subdiv_name": "",
            "address_line": "",
        }
        self.data = self.data0
        return self.data

    @staticmethod
    def load_special_mapping():
        if not AP.adh.special_loaded:
            AP.adh.load_special_mapping()

    def detect_division(self, temp_str):
        """ Detect division component from an address text """
        if self.adh.conn is not None:
            conn = self.adh.conn
            cur = conn.cursor()
        else:
            conn, cur = self.adh.connect_database(self.adh.params)

        division_id = 0
        data = self.data
        data["country_code"] = "VNM"

        space_location = AP.space_location
        match_one = False
        special_division = self.adh.special_division

        while temp_str and space_location >= 0 and not division_id:
            temp_location = space_location
            match_one = False
            word_check = temp_str[temp_location:].strip().lower() if space_location > 0 else temp_str.lower()
            # print("1. word_check:" + word_check)
            if division_id == 0:
                if word_check in special_division:
                    division_id = special_division[word_check]
                    cur.execute(
                        "SELECT divisionid, division_name, gso_code FROM sys_division WHERE divisionid = ?",
                        (division_id,))
                    row = cur.fetchone()
                    if row is not None:
                        division_name = row[1]
                        division_code = row[2]
                        if division_name:
                            data['division_name'] = division_name
                        if division_code:
                            data['division_code'] = division_code
                else:
                    # print("2. else check division with prefixes")
                    cur.execute(
                        "SELECT divisionid, division_name, gso_code \
                        FROM sys_division JOIN sys_country USING(countryid) \
                        WHERE iso3 = 'VNM' AND lower(division_name) IN (?,?,?)",
                        (word_check, ADH.NORM_TP + word_check, ADH.NORM_TINH + word_check))
                    row = cur.fetchone()
                    # print(row)
                    if row is not None:
                        division_id = row[0]
                        division_name, division_code = row[1], row[2]
                        if division_name:
                            data['division_name'] = division_name
                            data['division_code'] = division_code
                            data['division_id'] = division_id
                if division_id > 0:
                    # print("3. if divisionID > 0")
                    temp_lc = temp_str.lower()
                    backpos = temp_lc.find(ADH.NORM_TP + word_check)
                    if backpos >= 0:
                        temp_location = backpos - 1
                        print("found " + ADH.NORM_TP + word_check + " at pos:" + temp_location)
                    if backpos < 0:
                        backpos = temp_lc.find(ADH.NORM_TINH + word_check)
                        if backpos >= 0:
                            temp_location = backpos - 1
                            # print("found " + ADC.NORM_TINH + word_check + " at pos:" + temp_location)
                    match_one = True
                    data["division_id"] = division_id
                    return data
        return data

    def detect_subdiv(self, temp_str):
        # print("2. testing detect_subdiv")
        # conn, cur = ADH.connect_database(adh.params)
        if self.adh.conn is not None:
            conn = self.adh.conn
            cur = conn.cursor()
        else:
            conn, cur = self.adh.connect_database(self.adh.params)

        special_division_sub_div = self.adh.special_division_sub_div

        data = self.data
        division_code = data["division_code"]
        division_id = data["division_id"]
        subdiv_code = data["subdiv_code"]

        space_location = 0
        temp_location = 0
        match_one = False

        word_check = temp_str[temp_location:].strip().lower() if space_location > 0 else temp_str.lower()

        if word_check and not subdiv_code and (division_id > 0):
            if word_check in special_division_sub_div:
                subdiv_id = special_division_sub_div[word_check]
                sql = "SELECT subdiv_cd, l2subdiv_cd, subdiv_name \
                        FROM sys_division_sub \
                        WHERE divisionid = ? AND subdivid = ?"
                params = (division_id, subdiv_id,)
                cur.execute(sql, params)
                row = cur.fetchone()
                if row is not None:
                    subdiv_code = row[0]
                    l2subdiv_code = row[1]
                    if subdiv_code:
                        data['subdiv_code'] = subdiv_code
                    if l2subdiv_code:
                        data['l2subdiv_code'] = l2subdiv_code
                    subdiv_name = row[2]
                    if subdiv_name:
                        data['subdiv_name'] = subdiv_name
            else:
                # handle abbreviation of subdivision like q. h.
                word_ext = self.adh.get_extended_prefix(word_check)
                sql = (
                    "SELECT subdiv_cd, subdiv_name FROM sys_division_sub \
                     WHERE divisionid = ? AND subdiv_name IN(?,?,?,?,?,?) \
                     AND l2subdiv_cd IS NULL")

                params = (
                    division_id, word_check, word_ext,
                    ADH.NORM_QUAN + word_check,
                    ADH.NORM_HUYEN + word_check,
                    ADH.NORM_TX + word_check,
                    ADH.NORM_THANHPHO + word_check,
                )

                cur.execute(sql, params)
                row = cur.fetchone()
                # print(row)
                if row is not None:
                    subdiv_code = row[0]
                    if subdiv_code is not None:
                        data["subdiv_code"] = subdiv_code
                    n = row[1]
                    if n is not None:
                        data["subdiv_name"] = n
                else:
                    print("not found search result ")
                    print(row)

        return data

    # #3: detecting l2subdiv
    def detect_l2subdiv(self, temp_str):

        if self.adh.conn is not None:
            conn = self.adh.conn
            cur = conn.cursor()
        else:
            conn, cur = self.adh.connect_database(self.adh.params)

        special_division_sub_div = self.adh.special_division_sub_div

        data: dict[str, Union[str, int]] = self.data
        division_code = data["division_code"]
        division_id = data["division_id"]
        subdiv_code = data["subdiv_code"]
        subdiv_name = data["subdiv_name"]
        l2subdiv_code = data["l2subdiv_code"]

        space_location = 0
        temp_location = 0
        match_one = False

        word_check = temp_str[temp_location:].strip().lower() if space_location > 0 else temp_str.lower()

        if word_check and not l2subdiv_code \
                and subdiv_code and (division_id > 0):
            if word_check in special_division_sub_div:
                subdiv_id = special_division_sub_div[word_check]
                sql = "SELECT l2subdiv_cd, subdiv_name \
                        FROM sys_division_sub \
                        WHERE divisionid = ? AND subdivid = ?"
                params = (division_id, subdiv_id,)
                cur.execute(sql, params)
                row = cur.fetchone()
                if row is not None:
                    l2subdiv_code = row[0]
                    l2subdiv_name = row[1]
                    if l2subdiv_code:
                        data['l2subdiv_code'] = l2subdiv_code
                    if l2subdiv_name:
                        data['l2subdiv_name'] = l2subdiv_name
                return data
            else:
                # print("3.2 subdiv_code not found in special subdiv")
                word_ext = self.adh.get_extended_prefix(word_check)
                sql = (
                    "SELECT l2subdiv_cd, subdiv_name FROM sys_division_sub \
                     WHERE divisionid = ? AND subdiv_name IN(?,?,?,?,?) \
                     AND subdiv_cd = ? \
                     AND l2subdiv_cd IS NOT NULL")

                params = (
                    division_id, word_check, word_ext,
                    ADH.NORM_PHUONG + word_check,
                    ADH.NORM_XA + word_check,
                    ADH.NORM_TT + word_check,
                    subdiv_code,
                )

                # print("3.3. searching l2subdiv in the db")
                cur.execute(sql, params)
                row = cur.fetchone()
                # print(row)
                if row is not None:
                    l2subdiv_code = row[0]
                    if l2subdiv_code is not None:
                        data["l2subdiv_code"] = l2subdiv_code
                    l2subdiv_name = row[1]
                    if l2subdiv_name is not None:
                        data["l2subdiv_name"] = l2subdiv_name
                else:
                    print("l2subdiv_code not found in search result ")
                    print(row)

            return data

    def detect_address(self, address_text: str):

        # detect address codes from address_text
        # Step 1: normalize address_text
        # Step 2: split address text into words
        array = re.split(r'[,;\n]', address_text.lower().strip())
        array_len = len(array) - 1

        AP.reset_data(AP)  # reset data record
        data: dict[str, Union[str, int]] = self.data

        AP.data = AP.data0
        data["address_line"] = array[0]

        division_id = 0
        subdiv_code = None
        l2subdiv_code = None
        tempStr = ""

        # Step main loop thru the array
        # k = array_len
        # for k in range(len(array) - 1, -1, -1):
        for tempStr in reversed(array):
            tempStr = tempStr.strip()
            # print(k, tempStr)
            # detect division
            if division_id == 0:
                data = self.detect_division(tempStr)
                division_id = data.get("division_id")
                continue

            if subdiv_code is None:
                # detect subdivision
                data1 = self.detect_subdiv(tempStr)
                if data1 is not None:
                    data = data1
                    # print("proc 4.2:", data)
                    subdiv_code = data.get("subdiv_code")
                continue

            if l2subdiv_code is None:
                # detect l2subdivision
                data1 = self.detect_l2subdiv(tempStr)
                if data1 is not None:
                    data = data1
                    # print("proc 4.3:", data)
                    l2subdiv_code = data.get("l2subdiv_code")
                # continue
        return data
