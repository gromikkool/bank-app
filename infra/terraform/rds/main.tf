resource "aws_db_subnet_group" "rds-group" {
  name = "${var.env}-${var.db_name}-subnet-group"
  subnet_ids = var.db_subnet_ids
}

resource "random_password" "rds-password" {
  length = 16
  special = true
}

resource "aws_security_group" "rds-sg" {
  name = "${var.env}-${var.db_name}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [var.ecs_tasks_sg_id]
  }
}

resource "aws_db_instance" "main-db" {
  engine = "postgres"
  engine_version = "15"
  db_name = var.db_name
  username = var.username
  identifier = "dev-${var.db_name}-db"
  password = random_password.rds-password.result
  instance_class = var.instance_class
  db_subnet_group_name = aws_db_subnet_group.rds-group.name
  allocated_storage = var.allocated_storage
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  publicly_accessible = false
  skip_final_snapshot = true
}

resource "aws_secretsmanager_secret" "rds-secret" {
  name = "${var.env}/${var.db_name}/db"
}
resource "aws_secretsmanager_secret_version" "rds-secret-version" {
  secret_id = aws_secretsmanager_secret.rds-secret.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.rds-password.result
    host = aws_db_instance.main-db.address
    port = 5432
    database = var.db_name
  })
}
