import pytest
from address_code_func.address_parser.ADHelper import ADH


def test_load_special_mapping():
    # Create an instance of the AddressDictionary class
    adh = ADH()

    # Call the load_special_mapping function with test parameters
    adh.load_special_mapping()

    # Assert that the expected result matches the actual result
    expected_params = {'database': {'path': './s3-bucket/country_div_sub.sqlite3', 'driver': 'sqlite3', 'timeout': 10000}}
    expected_special_division = {'tỉnh bà rịa vũng tàu': 2,
                                 'tỉnh thừa thiên huế': 50}

    expected_special_subdiv = {'thành phố phan rang tháp chàm': 10812}

    # self.assertEqual(adh.params, expected_params)
    assert adh.special_division == expected_special_division
    assert adh.special_division_sub_div == expected_special_subdiv
