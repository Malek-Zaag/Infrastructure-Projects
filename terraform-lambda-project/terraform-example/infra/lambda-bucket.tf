resource "random_pet" "bucket_name" {
  length    = 3
  separator = "-"
  prefix    = "lambda-bucket"
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = random_pet.bucket_name.id
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.lambda_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "test_object" {
  bucket  = aws_s3_bucket.lambda_bucket.bucket
  key     = "test.txt"
  content = "This is a test object for the Lambda function."
}

resource "aws_iam_role" "s3_lambda_exec" {
  name = "s3-lambda"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "s3_lambda_policy" {
  role       = aws_iam_role.s3_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "test_s3_bucket_access" {
  name = "TestS3BucketAccess"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${aws_s3_bucket.lambda_bucket.id}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_lambda_test_s3_bucket_access" {
  role       = aws_iam_role.s3_lambda_exec.name
  policy_arn = aws_iam_policy.test_s3_bucket_access.arn
}

resource "aws_lambda_function" "s3" {
  function_name = "another_lambda_function"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_s3.key

  runtime = "nodejs24.x"
  handler = "hello_s3.handler"

  source_code_hash = data.archive_file.example.output_base64sha256
  role             = aws_iam_role.s3_lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "s3" {
  name = "/aws/lambda/${aws_lambda_function.s3.function_name}"

  retention_in_days = 14
}

resource "aws_s3_object" "lambda_s3" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello_s3.zip"
  source = data.archive_file.example.output_path

  source_hash = filemd5(data.archive_file.example.output_path)
}