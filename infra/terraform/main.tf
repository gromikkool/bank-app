terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket = "bank-app-terraform"
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
  secret_key = ""
  region     = "us-east-1"
}

resource "aws_security_group" "ecs_tasks" {
  name   = "${local.env}-ecs-tasks-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    self = true

    security_groups = [module.alb.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  env = "bank_app_terr"
}

module "vpc" {
  source = "./vpc"
  env    = local.env
}

module "alb" {
  source = "./alb"

  env    = local.env
  vpc_id = module.vpc.vpc_id
}

module "keycload-db" {
  source          = "./rds"
  env             = local.env
  db_name            = "keycloak"
  username = "keycloak"
  db_subnet_ids   = module.vpc.db_subnet_ids
  vpc_id          = module.vpc.vpc_id
  ecs_tasks_sg_id = aws_security_group.ecs_tasks.id
}

module "person-db" {
  source          = "./rds"
  env             = local.env
  db_name         = "person"
  username        = "person_admin"
  db_subnet_ids   = module.vpc.db_subnet_ids
  vpc_id          = module.vpc.vpc_id
  ecs_tasks_sg_id = aws_security_group.ecs_tasks.id
}

module "cloud-mao" {
  source = "./cloud-map"
  vpc_id = module.vpc.vpc_id
}