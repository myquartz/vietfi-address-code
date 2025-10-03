import pytest

from address_code_func.address_parser.ADHelper import ADH
from address_code_func.address_parser.AddressParser import AP


class TestAddressParser:
    # logger = CustomLogger("address_parser.log")
    adh = ADH()
    logger = adh.plogger
    if logger is None:
        print("Something wrong!")
        exit(99)

    def test_detect_division(self) -> object:
        self.logger.info("#1. detect_division test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data()
        assert data is not None
        assert data["country_code"] == "VNM"
        assert data["division_name"] == ""
        assert data["division_local_id"] == ""
        
        input_address = "Hồ Chí Minh"  # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP. Hồ Chí Minh"   # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "Thành phố Hồ Chí Minh"     # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP Hồ Chí Minh"    # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP.HCM"    # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP HCM"    # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "HCMC"    # OK
        assert True == addr_parser.detect_division(data, 1, input_address)
        assert ("79" == data["division_local_id"])

    def test_detect_division_2025(self) -> object:
        self.logger.info("#1. detect_division 2025 namespace test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data()
        assert data is not None
        assert data["country_code"] == "VNM"
        assert data["division_name"] == ""
        assert data["division_local_id"] == ""
        
        input_address = "Hồ Chí Minh"  # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP. Hồ Chí Minh"   # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "Thành phố Hồ Chí Minh"     # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP Hồ Chí Minh"    # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP.HCM"    # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "TP HCM"    # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])
        input_address = "HCMC"    # OK
        addr_parser.detect_division(data, 2, input_address)
        assert ("79" == data["division_local_id"])

    def test_detect_division2(self) -> object:
        self.logger.info("#2. detect_division test - run 2")

        addr_parser = AP()
        data = addr_parser.create_data()
        assert data is not None
        
        input_address = "Tỉnh Thái Bình"

        # Expected results
        # Assert that the expected result matches the actual result
        assert True == addr_parser.detect_division(data, 1, input_address)
        error_message = None
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_division()": "result"}, extra={
            "input_address": input_address,
            "parsed_address": data,
            "error_message": error_message
        })

        assert ("34" == data["division_local_id"])

        data = addr_parser.create_data()
        assert data is not None

        # 2025 namespace, Tinh Thai Binh deleted
        addr_parser.detect_division(data, 2, input_address)
        error_message = None
        assert ("" == data["division_local_id"])
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_division()": "result"}, extra={
            "input_address": input_address,
            "parsed_address": data,
            "error_message": error_message
        })

    def test_detect_division2_2025(self) -> object:
        self.logger.info("#2. detect_division 2025 test - run 2")

        addr_parser = AP()
        data = addr_parser.create_data()
        assert data is not None
        assert data["country_code"] == "VNM"
        assert data["division_name"] == ""
        assert data["division_local_id"] == ""

        input_address = "Tỉnh Bắc Ninh" # replacement of Tinh Bac Giang

        addr_parser.detect_division(data, 1, input_address)
        assert ("27" == data["division_local_id"])

        # Expected results
        # Assert that the expected result matches the actual result
        addr_parser.detect_division(data, 2, input_address)
        
        assert ("24" == data["division_local_id"])

    def test_detect_subdiv(self) -> object:
        self.logger.info("2. detect_subdiv test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data(initial_division_id=1)
        assert data is not None
        
        # origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Gia Thụy, Long Biên"
        origin_location = "Long Biên "  # OK
        assert True == addr_parser.detect_subdiv(data, 1, origin_location)
        assert ("004" == data["subdiv_local_id"])
        origin_location = "q. Long Biên "  # OK
        addr_parser.detect_subdiv(data, 1, origin_location)
        assert ("004" == data["subdiv_local_id"])
        origin_location = "Q Long Biên "  # OK


    def test_detect_subdiv2025(self) -> object:
        self.logger.info("2. detect_subdiv2025 test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data(initial_division_id=1)
        
        # origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Phường Long Biên"
        origin_location = "Phường Long Biên"  # OK
        assert True == addr_parser.detect_subdiv(data, 2, origin_location)
        assert ("00145" == data["subdiv_local_id"])

        origin_location = "Long Biên"  # OK
        data = addr_parser.create_data(initial_division_id=1)
        addr_parser.detect_subdiv(data, 2, origin_location)
        assert ("00145" == data["subdiv_local_id"])

        origin_location = "q. Long Biên "  # not ok
        data = addr_parser.create_data(initial_division_id=1)
        addr_parser.detect_subdiv(data, 2, origin_location)
        assert ("" == data["subdiv_local_id"])

        origin_location = "Q Long Biên "  # not ok
        data = addr_parser.create_data(initial_division_id=1)
        addr_parser.detect_subdiv(data, 2, origin_location)
        assert ("" == data["subdiv_local_id"])
        
    def test_detect_subdiv2025c2(self) -> object:
        self.logger.info("2. detect_subdiv2025c2 test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data(initial_division_id=4)
                
        origin_location = "Phường Thủ Đức"  # OK
        addr_parser.detect_subdiv(data, 2, origin_location)
        assert ("26824" == data["subdiv_local_id"])

    def test_detect_subdiv2(self) -> object:
        self.logger.info("2. detect_subdiv test2")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data(initial_division_id=51)
        
        origin_location = "Huyện Côn Đảo" ## , Tỉnh Ba Ria - Vung Tau"
        addr_parser.detect_subdiv(data, 1, origin_location)
        assert ("755" == data["subdiv_local_id"])

        origin_location = "H. CON DAO"  ## , Tỉnh Ba Ria - Vung Tau"
        data = addr_parser.create_data(initial_division_id=51)
        addr_parser.detect_subdiv(data, 1, origin_location)
        assert ("755" == data["subdiv_local_id"])

        origin_location = " Vũng Tàu "
        data = addr_parser.create_data(initial_division_id=51)
        addr_parser.detect_subdiv(data, 1, origin_location)
        assert ("747" == data["subdiv_local_id"])

        origin_location = " Vung tau "
        data = addr_parser.create_data(initial_division_id=51)
        addr_parser.detect_subdiv(data, 1, origin_location)
        assert ("747" == data["subdiv_local_id"])

    def test_detect_l2subdiv(self) -> object:
        # print("3. detect_l2subdiv")
        self.logger.info("3. detect_l2subdiv test")
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data(initial_division_id=1, initial_subdiv_local_id="004")
        assert data is not None
        
        origin_location = "p. Gia Thụy "
        addr_parser.detect_l2subdiv(data, 1, origin_location)
        assert ("00130" == data["l2subdiv_local_id"])
        
        origin_location = "p. Gia thuy "
        data = addr_parser.create_data(initial_division_id=1, initial_subdiv_local_id="004")
        addr_parser.detect_l2subdiv(data, 1, origin_location)

        assert ("00130" == data["l2subdiv_local_id"])

    def test_detect_l2subdiv2025(self) -> object:
        # print("3. detect_l2subdiv")
        self.logger.info("3. detect_l2subdiv2025 test")
        addr_parser = AP()

        # Test #1
        # Inputs
        data = addr_parser.create_data(initial_division_id=1, initial_subdiv_local_id="00145")
        assert data is not None
        assert data["subdiv_name"] == "Phường Long Biên"

        origin_location = "p. Gia Thụy "
        data = addr_parser.create_data(initial_division_id=1, initial_subdiv_local_id="00145")
        assert False == addr_parser.detect_l2subdiv(data, 2, origin_location)
        assert ("" == data["l2subdiv_local_id"])

        origin_location = "p. Gia thuy "
        data = addr_parser.create_data(initial_division_id=1, initial_subdiv_local_id="00145")
        assert False == addr_parser.detect_l2subdiv(data, 2, origin_location)
        assert ("" == data["l2subdiv_local_id"])

    def test_detect_address(self):
        # print("4. test_detect_address")
        self.logger.info("4. test_detect_address")
        addr_parser = AP()
        error_message = None

        origin_location = "Đô Vinh, Thành phố Phan Rang-Tháp Chàm\nNinh Thuận"
        data = addr_parser.detect_address([1], origin_location)

        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

        origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Gia Thụy, Long Biên, Hà Nội"

        data = addr_parser.detect_address([1, 2], origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

    def test_detect_address2(self):
        addr_parser = AP()

        origin_location = "13 phố Hàng Chuối\nPhạm Đình Hồ, Hai Bà trung, Ha noi"

        data = addr_parser.detect_address([0], origin_location)
        assert data is not None
        assert ("" == data[0]["division_local_id"])
        assert ("" == data[0]["subdiv_local_id"])

        data = addr_parser.detect_address([1], origin_location)
        assert data is not None
        assert ("01" == data[1]["division_local_id"])
        assert ("007" == data[1]["subdiv_local_id"])
        
        origin_location = " Phú Nhuận, Tp. Huế, Tỉnh Thừa Thiên-Huế"

        data = addr_parser.detect_address([1], origin_location)
        assert data is not None
        assert ("46" == data[1]["division_local_id"])
        assert ("474" == data[1]["subdiv_local_id"])

        origin_location = " Phường Phú Xuân, Tp. Huế"

        data = addr_parser.detect_address([2], origin_location)
        assert data is not None
        assert ("46" == data[2]["division_local_id"])
        assert ("19753" == data[2]["subdiv_local_id"])

    def test_detect_address2025(self):
        # print("4. test_detect_address")
        self.logger.info("5. test_detect_address2025")
        addr_parser = AP()
        
        origin_location = "KP1, Phường Thủ Đức, TP Hồ Chí Minh"
        data = addr_parser.detect_address([2], origin_location)
        assert ("79" == data[2]["division_local_id"])
        assert ("26824" == data[2]["subdiv_local_id"])

        origin_location = "Gia Thuỵ, Phường Long Biên, Hà Nội"
        data = addr_parser.detect_address([2], origin_location)
        assert ("01" == data[2]["division_local_id"])
        assert ("00145" == data[2]["subdiv_local_id"])

    def test_detect_address_kh(self):

        self.logger.info("6. test_detect_address khach hang")
        addr_parser = AP()
        error_message = None
        origin_location = "L50/1 Tô Ký, phường Trung Mỹ Tây, Quận 12, TP Hồ Chí Minh"

        data = addr_parser.detect_address([1,2], origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })
        assert len(data) == 2
        assert ("79" == data[1]["division_local_id"])
        assert ("761" == data[1]["subdiv_local_id"])
        assert ("26785" == data[1]["l2subdiv_local_id"])
        assert ("79" == data[2]["division_local_id"])
        assert ("" == data[2]["subdiv_local_id"])

        origin_location = "L50/1 Tô Ký, Phường Trung Mỹ Tây, TP Hồ Chí Minh"
        data = addr_parser.detect_address([1,2], origin_location)
        assert len(data) == 2
        assert ("79" == data[1]["division_local_id"])
        assert ("" == data[1]["subdiv_local_id"])
        assert ("" == data[1]["l2subdiv_local_id"])
        assert ("79" == data[2]["division_local_id"])
        assert ("26785" == data[2]["subdiv_local_id"])

    def test_detect_address_kh2(self):
        addr_parser = AP()
        origin_location = "Tân Mỹ B, Xã Chánh An, Huyện Mang Thít, Tỉnh Vĩnh Long"
        data = addr_parser.detect_address([1,2], origin_location)
        assert ("86" == data[1]["division_local_id"])
        assert ("858" == data[1]["subdiv_local_id"])
        assert ("86" == data[2]["division_local_id"])
        assert ("" == data[2]["subdiv_local_id"])

        origin_location = "Tân Mỹ B, Xã Tân An, Tỉnh Vĩnh Long"
        data = addr_parser.detect_address([1,2], origin_location)
        assert ("86" == data[1]["division_local_id"])
        assert ("" == data[1]["subdiv_local_id"])
        assert ("86" == data[2]["division_local_id"])
        assert ("29278" == data[2]["subdiv_local_id"])
        
        origin_location = "Thị trấn Rạch Gốc, Huyện Ngọc Hiển, Tỉnh Cà Mau"
        data = addr_parser.detect_address([1,2], origin_location)
        assert ("96" == data[1]["division_local_id"])
        assert ("973" == data[1]["subdiv_local_id"])
        assert ("32244" == data[1]["l2subdiv_local_id"])
        assert ("96" == data[2]["division_local_id"])
        assert ("" == data[2]["subdiv_local_id"])

        origin_location = "Huyện Côn đảo, Tỉnh Ba Ria - Vung Tau"

        data = addr_parser.detect_address([1,2], origin_location)
        assert ("77" == data[1]["division_local_id"])
        assert ("755" == data[1]["subdiv_local_id"])
        assert ("00000" == data[1]["l2subdiv_local_id"])
        assert ("" == data[2]["division_local_id"])
        assert ("" == data[2]["subdiv_local_id"])
        assert ("" == data[2]["l2subdiv_local_id"])

        origin_location = "Đặc khu Côn Đảo, TP Hồ Chí Minh"
        data = addr_parser.detect_address([1,2], origin_location)
        assert ("79" == data[1]["division_local_id"])
        assert ("" == data[1]["subdiv_local_id"])
        assert ("" == data[1]["l2subdiv_local_id"])
        assert ("79" == data[2]["division_local_id"])
        assert ("26732" == data[2]["subdiv_local_id"])
        assert ("00000" == data[2]["l2subdiv_local_id"])
