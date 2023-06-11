# VietFi-Address-Code

## Software Design

1. Please see [Design (Vietnamese)](Design.vi_VN.md) for more information.

# Development

This project contains source code and supporting files for a serverless application that you can deploy with the SAM CLI. It includes the following files and folders.

- address_code_func - Code for the application's Lambda function.
- events - Invocation events that you can use to invoke the function.
- tests - Unit tests for the application code. 
- template.yaml - A template that defines the application's AWS resources.

The application uses several AWS resources, including Lambda functions and an API Gateway API. These resources are defined in the `template.yaml` file in this project. You can update the template to add AWS resources through the same deployment process that updates your application code.

## Deploy

To use the SAM CLI, you need the following tools.

* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
* [Python 3.9 installed](https://www.python.org/downloads/)
* Docker - [Install Docker community edition](https://hub.docker.com/search/?type=edition&offering=community)

To build and deploy your application for the first time, run the following in your shell:

```bash
sam build --use-container
sam deploy --guided
```

You can find your API Gateway Endpoint URL in the output values displayed after deployment.

```bash
aws s3 cp s3-bucket/* s3://vietfi-api-data/
```

> Note: Function needs data file uploaded to Bucket, change bucket name `vietfi-api-data` as your S3 bucket name.
> After grant S3 Bucket for public access of index.html, now you can access to https://vietfi-api-data.s3.ap-southeast-1.amazonaws.com/index.html for demostration.


## Use the SAM CLI to build and test locally

Build your application with the `sam build --use-container` command.

```bash
$ sam build --use-container
```

Run functions locally and invoke them with the `sam local invoke` command.

```bash
$ sam local invoke AddressCodeFunction -n test-env.json --event events/event.json
```

The SAM CLI can also emulate your application's API. Use the `sam local start-api` to run the API locally on port 3000 for testing.

```bash
$ sam local start-api --profile default -n test-env.json
# Other termninal
$ curl http://localhost:3000/countries
```

## Tests

Tests are defined in the `tests` folder in this project. Use PIP to install the test dependencies and run tests.

```bash
$ pip3.9 install -r tests/requirements.txt --user
# unit test
$ python3.9 -m pytest tests/unit -v
# or running in debug mode with port
$ python3.9 -m debugpy --wait-for-client --listen 5678 -m pytest tests/unit
# integration test, requiring deploying the stack first.
# Create the env variable AWS_SAM_STACK_NAME with the name of the stack we are testing
$ AWS_SAM_STACK_NAME=vietfi-address-code python -m pytest tests/integration -v
```

## Cleanup

To delete the sample application that you created, use the AWS CLI. Assuming you used your project name for the stack name, you can run the following:

```bash
aws cloudformation delete-stack --stack-name vietfi-address-code
```

## Resources

See the [AWS SAM developer guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) for an introduction to SAM specification, the SAM CLI, and serverless application concepts.
