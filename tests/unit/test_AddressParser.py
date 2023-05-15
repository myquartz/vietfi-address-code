import unittest

from address_parser.ADHelper import ADH
from address_parser.AddressParser import AP


class AddressParserTest(unittest.TestCase):
    # logger = CustomLogger("address_parser.log")
    adh = ADH()
    logger = adh.plogger
    if logger is None:
        print("Something wrong!")
        exit(99)

    def test_detect_division(self) -> object:
        self.logger.info("1. detect_division test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        data = {
            "country_code": "VNM",
            "division_name": "",
            "division_code": ""
        }
        # origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Gia Thụy, Long Biên, Hà Nội"
        input_address = "Ninh Thuận"

        # Expected results
        # Assert that the expected result matches the actual result
        data = addr_parser.detect_division(input_address)
        error_message = None
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_division()": "result"}, extra={
            "input_address": input_address,
            "parsed_address": data,
            "error_message": error_message
        })

        self.assertEqual("58", addr_parser.data["division_code"])

    def test_detect_subdiv(self) -> object:
        self.logger.info("2. detect_subdiv test")
        # Create an instance of the AddressParser class
        addr_parser = AP()

        # Test #1
        # Inputs
        AP.data = {
            "country_code": "VNM",
            "division_name": "TP. Hà Nội",
            "division_code": "01",
            "division_id": 18,
            "subdiv_code": "",
            "subdiv_name": "",
            "l2subdiv_code": "",
            "l2subdiv_name": "",
        }
        origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Gia Thụy, Long Biên, Hà Nội"
        origin_location = "Hà Nội"

        recent_location = "Tổ 7\nYên Sở, Hoàng Mai\nHà Nội"

        # Expected results
        # Assert that the expected result matches the actual result
        origin_location = "q. Long Biên"
        error_message = None
        data = addr_parser.detect_subdiv(origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_subdivision()": "result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

        self.assertEqual("004", addr_parser.data["subdiv_code"])

    def test_detect_l2subdiv(self) -> object:
        # print("3. detect_l2subdiv")
        self.logger.info("3. detect_l2subdiv test")
        addr_parser = AP()

        # Test #1
        # Inputs
        AP.data = {
            "country_code": "VNM",
            "division_name": "TP. Hà Nội",
            "division_code": "01",
            "division_id": 18,
            "subdiv_code": "004",
            "subdiv_name": "Quận Long Biên",
            "l2subdiv_code": "",
            "l2subdiv_name": "",
        }
        origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Gia Thụy, Long Biên, Hà Nội"
        # Expected results
        # Assert that the expected result matches the actual result
        origin_location = "Gia Thụy"
        error_message = None

        data = addr_parser.detect_l2subdiv(origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_l2subdivision()": "result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

        self.assertEqual("004", addr_parser.data["subdiv_code"])

    def test_detect_address(self):
        # print("4. test_detect_address")
        self.logger.info("4. test_detect_address")
        addr_parser = AP()
        AP.reset_data(addr_parser)
        error_message = None

        origin_location = "Đô Vinh, Thành phố Phan Rang-Tháp Chàm\nNinh Thuận"
        data = addr_parser.detect_address(origin_location)

        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

        AP.reset_data(addr_parser)
        origin_location = "Số 18/564/55/14\nNguyễn Văn Cừ, Gia Thụy, Long Biên, Hà Nội"

        data = addr_parser.detect_address(origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

        AP.reset_data(addr_parser)
        origin_location = "13 phố Hàng Chuối\nPhạm Đình Hồ, Hai Bà Trưng, Hà Nội"

        data = addr_parser.detect_address(origin_location)
        data = addr_parser.detect_address(origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })

        AP.reset_data(addr_parser)
        origin_location = " Phú Nhuận, Tp. Huế, Tỉnh Thừa Thiên-Huế"

        data = addr_parser.detect_address(origin_location)
        data = addr_parser.detect_address(origin_location)
        # Log the input address, parsed address, and possible parsing error
        self.logger.info({"detect_address()": "test result"}, extra={
            "input_address": origin_location,
            "parsed_address": data,
            "error_message": error_message
        })


class MyTestSuite(unittest.TestSuite):
    def run(self, result, debug=False):
        # Selectively include or exclude specific test cases or test methods
        # based on your criteria
        self._tests = [self._tests[1]]  # Run only the second test

        # Call the parent run() method to execute the selected tests
        super().run(result, debug=debug)


if __name__ == '__main__':
    unittest.main()
    # suite = MyTestSuite()
    #
    # # Add test cases or test methods to the suite
    # suite.addTest(MyTestSuite('test_detect_division'))
    # # suite.addTest(MyTestSuite('test_detect_subdiv'))
    # # suite.addTest(MyTestSuite('test_detect_l2subdiv'))
    # # suite.addTest(MyTestSuite('test_detect_address'))

    # Run the selected tests
    # runner = unittest.TextTestRunner()
    # runner.run(suite)
