resource "random_password" "keycloak_admin" {
  length  = 24
  special = true
}

resource "aws_secretsmanager_secret" "keycloak_admin" {
  name                    = "dev/keycloak/admin"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "keycloak_admin" {
  secret_id = aws_secretsmanager_secret.keycloak_admin.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.keycloak_admin.result
  })
}