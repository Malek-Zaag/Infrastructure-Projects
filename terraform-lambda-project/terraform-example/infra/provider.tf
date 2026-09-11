terraform {
  required_version = ">= 1.14.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.45.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.8.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
