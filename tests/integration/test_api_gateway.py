import os
from urllib import response

import boto3
import pytest
import requests

"""
Make sure env variable AWS_SAM_STACK_NAME exists with the name of the stack we are going to test. 
"""


class TestApiGateway:

    @pytest.fixture()
    def api_gateway_url(self):
        """ Get the API Gateway URL from Cloudformation Stack outputs """
        stack_name = os.environ.get("AWS_SAM_STACK_NAME")

        if stack_name is None:
            raise ValueError('Please set the AWS_SAM_STACK_NAME environment variable to the name of your stack')

        client = boto3.client("cloudformation")

        try:
            response = client.describe_stacks(StackName=stack_name)
        except Exception as e:
            raise Exception(
                f"Cannot find stack {stack_name} \n" f'Please make sure a stack with the name "{stack_name}" exists'
            ) from e

        stacks = response["Stacks"]
        stack_outputs = stacks[0]["Outputs"]
        api_outputs = [output for output in stack_outputs if output["OutputKey"] == "AddressApi"]

        if not api_outputs:
            raise KeyError(f"AddressApi not found in stack {stack_name}")

        return api_outputs[0]["OutputValue"]  # Extract url from stack outputs

    def test_api_gateway1(self, api_gateway_url):
        """ Call the API Gateway endpoint and check the response """
        response = requests.get(api_gateway_url+"/countries")

        assert response.status_code == 200
        ret = response.json()
        # ret is array of objects
        assert isinstance(ret, list)
        assert len(ret) > 0
        # each object has code and name
        assert "code" in ret[0]
        assert "name" in ret[0]
        vnm = [c for c in ret if c['code'] == 'VNM']
        assert len(vnm) == 1
        # lookup VNM country, which has 2 namespaces: before2025 and 2025
        assert vnm[0]["namespaces"] == ['before2025', '2025']

    def test_api_gateway2(self, api_gateway_url):
        """ Call the API Gateway endpoint and check the response """
        response = requests.get(api_gateway_url+"/countries/VNM")

        assert response.status_code == 200
        ret = response.json()
        # lookup VNM country, which has 2 namespaces: before2025 and 2025
        assert ret["namespaces"] == ['before2025', '2025']

    def test_api_gateway3(self, api_gateway_url):
        """ Call the API Gateway endpoint and check the response """
        response = requests.get(api_gateway_url+"/countries/VNM/divisions", params={"namespace": "before2025"})

        assert response.status_code == 200
        ret = response.json()
        assert isinstance(ret, list)
        assert len(ret) > 0        
        assert "division_code" in ret[0]
        assert "local_id" in ret[0]
        assert "name" in ret[0]
        hanoi = [c for c in ret if c['division_code'] == 'VN-HN']
        assert len(hanoi) == 1
        assert hanoi[0]['local_id'] == '01'
    
    def test_api_gateway4(self, api_gateway_url):
        """ Call the API Gateway endpoint and check the response """
        response = requests.get(api_gateway_url+"/countries/VNM/divisions/VN-HN/subdivisions", params={"namespace": "before2025"})

        assert response.status_code == 200
        ret = response.json()
        assert isinstance(ret, list)
        assert len(ret) > 0        
        assert "division_code" in ret[0]
        assert "local_id" in ret[0]
        assert "name" in ret[0]
        not000 = [c for c in ret if c['local_id'] != '000']
        assert len(not000) >= 1
        assert len(not000[0]['local_id']) == 3
        not3len = [c for c in ret if len(c['local_id']) != 3]
        assert len(not3len) == 0

    def test_api_gateway5(self, api_gateway_url):
        """ Call the API Gateway endpoint and check the response """
        response = requests.get(api_gateway_url+"/countries/VNM/divisions/VN-HN/subdivisions", params={"namespace": "2025"})

        assert response.status_code == 200
        ret = response.json()
        assert isinstance(ret, list)
        assert len(ret) > 0        
        assert "division_code" in ret[0]
        assert "local_id" in ret[0]
        assert "name" in ret[0]
        not000 = [c for c in ret if c['local_id'] != '000']
        assert len(not000) >= 1
        assert len(not000[0]['local_id']) == 5
