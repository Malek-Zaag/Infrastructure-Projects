resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  region               = "us-east-1"
  enable_dns_support   = true
  enable_dns_hostnames = true

}



