output "keycloak_service_arn" {
  value = aws_service_discovery_service.keycloak.arn
}
output "person_service_arn" {
  value = aws_service_discovery_service.person-service.arn
}
