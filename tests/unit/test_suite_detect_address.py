import pytest
from address_code_func.address_parser.AddressParser import AP
from unidecode import unidecode
import re


def normalize_address(address):

    # Define the mapping dictionary for normalization
    mapping = {
        r'^q\.?\s*(\d+)$': r'quan \1',  # Pattern: q. <number>
        r'^quan\s*(\d+)$': r'quan \1'  # Pattern: quan <number>
    }

    # Apply normalization patterns iteratively
    for pattern, replacement in mapping.items():
        address = re.sub(pattern, replacement, address, flags=re.IGNORECASE)

    return address.strip()

    # Example usage


# def check_address_06():
#     """
#     normalize 'Q2', 'Q.2', 'Q 2', 'Q 02', 'Quan 02' into 'Quan 2'
#     """
#     address = 'Q.02'
#     normalized_address = normalize_address(address)
#     print(normalized_address)  # Output: Quan 2


class TestDetectAddress:

    def test_address_12(self):
        address_parser = AP()

        adt = "Số 1 đường Nguyễn Trãi, phường không xác định, quận 5, thành phố sai"
        data = address_parser.detect_address(adt)
        print('input data', adt)
        print('parsed data', data)
        assert (data["division_local_id"] == "")  # add assertion here

    def test_address_11(self):
        address_parser = AP()

        adt = "Số 1 đường Nguyễn Trãi, phường không xác định, quận 5, thành phố Hồ Chí Minh"
        data = address_parser.detect_address(adt)
        print('input data', adt)
        print('parsed data', data)
        assert (data["address_line"] == "Số 1 đường Nguyễn Trãi, phường không xác định")  # add assertion here

    def test_address_10(self):
        address_parser = AP()

        adt = "Số 1 đường Nguyễn Trãi, phường 2, quận 5, thành phố Hồ Chí Minh"
        adt_uni = unidecode(adt)
        data = address_parser.detect_address(adt_uni)
        print('input data', adt)
        print('parsed data', data)
        assert (data["division_local_id"] == "79")  # add assertion here

    def test_address_09(self):
        address_parser = AP()

        adt = "Số 1 đường Nguyễn Trãi, phường 2, quận 5, thành phố Hồ Chí Minh"
        adt_uni = unidecode(adt)
        data = address_parser.detect_address(adt_uni)
        print('input data', adt)
        print('parsed data', data)
        assert (data["division_local_id"] == "79")  # add assertion here

    def test_address_08(self):
        address_parser = AP()

        adt = "Số 1 đường Nguyễn Trãi, phường 02, quận 5, thành phố Hồ Chí Minh"
        adt_uni = unidecode(adt)
        data = address_parser.detect_address(adt_uni)
        print(data)
        assert (data["division_local_id"] == "79")  # add assertion here
    
    def test_address_01(self):
        address_parser = AP()

        adt = "Hồ Chí Minh"      ## tp hcm
        adt_uni = unidecode(adt)
        data = address_parser.detect_division(adt_uni)
        print(adt_uni)
        assert (data["division_local_id"] == "79")  # add assertion here

    def test_address_02(self):
        address_parser = AP()

        adt = "tp Hồ Chí Minh"      ## tp hcm
        adt_uni = unidecode(adt)
        data = address_parser.detect_division(adt_uni)
        print(adt_uni)
        assert (data["division_local_id"] == "79")  # add assertion here

    def test_address_03(self):
        address_parser = AP()

        adt = "thành phố Hồ Chí Minh"      ## tp hcm
        data = address_parser.detect_division(adt)
        print(adt)
        assert (data["division_local_id"] == "79")  # add assertion here

    def test_address_04(self):
        address_parser = AP()

        adt = "tỉnh Thái Bình"      ## tp hcm
        adt_uni = unidecode(adt)
        data = address_parser.detect_division(adt_uni)
        print(adt_uni)
        assert (data["division_local_id"] == "34")  # add assertion here

    def test_address_05(self):
        address_parser = AP()

        adt = "thành phố Hồ Chí Minh"      ## tp hcm
        adt_uni = unidecode(adt)
        data = address_parser.detect_division(adt_uni)
        print(adt_uni)
        assert (data["division_local_id"] == "79")  # add assertion here

    def test_address_07(self):
        address_parser = AP()

        adt = "Vũ Thư, Thái Bình"
        data = address_parser.detect_address(adt)
        print(data)
        assert (data["division_local_id"] == "34")  # add assertion here



#if __name__ == '__main__':
#    unittest.main()
