import pytest
from address_code_func.address_parser.ADHelper import ADH


def test_load_special_mapping():
    # Create an instance of the AddressDictionary class
    adh = ADH()

    # Call the load_special_mapping function with test parameters
    adh.load_special_mapping()

    # Assert that the expected result matches the actual result
    expected_params = {'database': {'path': './s3-bucket/address_db.sqlite3', 'driver': 'sqlite3', 'timeout': 10000}}
    # new address db with divisionid changed
    expected_special_division = {'tỉnh bà rịa vũng tàu': 51,
                                 'tỉnh thừa thiên huế': 34}

    expected_special_subdiv = {'thành phố phan rang tháp chàm': 517}

    # self.assertEqual(adh.params, expected_params)
    assert adh.special_division['tỉnh bà rịa vũng tàu'] == expected_special_division['tỉnh bà rịa vũng tàu']
    assert adh.special_division_sub_div == expected_special_subdiv
