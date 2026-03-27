output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.lambda.invoke_url
}

output "name" {
  value = aws_s3_bucket.lambda_bucket.bucket
}
