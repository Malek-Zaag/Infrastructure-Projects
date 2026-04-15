terraform {
  required_version = ">= 1.14.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
