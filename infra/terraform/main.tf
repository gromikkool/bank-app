terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
    source = "hashicorp/aws"
    version = "6.36.0"
    }
  }
}

provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}