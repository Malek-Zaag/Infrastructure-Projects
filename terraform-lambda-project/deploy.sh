#!/bin/bash

# Deploy Lambda function using SAMs
export AWS_PROFILE=malek
sam validate
sam deploy --guided

# local invoke the function
sam local invoke LambdaFunctionFunctionmyTestFunction --event event.json
echo '{"message": "Hey, are you there?" }' | sam local invoke --event - "myTestFunction"


# Deploy the Lambda function using Terraform