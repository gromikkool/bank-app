
resource "aws_service_discovery_private_dns_namespace" "myapp-local" {
  name = "myapp.local"
  vpc  = var.vpc_id
}

resource "aws_service_discovery_service" "keycloak" {
  name = "keycloak"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.myapp-local.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

}
resource "aws_service_discovery_service" "person-service" {
  name = "person-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.myapp-local.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

}