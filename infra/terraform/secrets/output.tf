output "keycloak_admin_arn" {
  value = aws_secretsmanager_secret.keycloak_admin.arn
}