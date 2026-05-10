terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket = "bank-app-test-bucket"
    region = "us-east-1"
    key = "dev/terraform.tfstate"
    encrypt = true
    use_lockfile = true
  }

  required_providers {
    aws = {
    source = "hashicorp/aws"
    version = "6.36.0"
    }
  }
}

provider "aws" {
  access_key = ""
  secret_key = ""  // podumat'
  region = "us-east-1"
}