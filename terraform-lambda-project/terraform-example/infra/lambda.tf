data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "example" {
  type        = "zip"
  source_file = "${path.module}/../hello/hello_s3.js"
  output_path = "${path.module}/../hello/hello_s3.zip"
}

data "archive_file" "example_without_s3" {
  type        = "zip"
  source_file = "${path.module}/../hello/hello.js"
  output_path = "${path.module}/../hello/hello.zip"
}

# Lambda function
resource "aws_lambda_function" "example" {
  filename      = data.archive_file.example_without_s3.output_path
  function_name = "example_lambda_function"
  role          = aws_iam_role.example.arn
  handler       = "hello.handler"
  code_sha256   = data.archive_file.example_without_s3.output_base64sha256

  runtime = "nodejs24.x"

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "production"
    Application = "example"
  }
}