terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}
resource "aws_db_subnet_group" "rds-group" {
  name = "${var.env}-${var.name}-subnet-group"
  subnet_ids = var.db_subnet_ids
}

resource "random_password" "" {
  length = 16
  special = true
}

resource "aws_security_group" "" {
  name = "${var.env}-${var.name}-rds-sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [var.ecs_tasks_sg_id]
  }
}



resource "aws_rds_cluster" "" {
  engine = ""
}