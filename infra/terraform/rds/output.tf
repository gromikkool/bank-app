#
# output "endpoint" {
#   value = aws_db_instance.main-db.address
# }
#
# output "database_name" {
#   value = aws_db_instance.main-db.db_name
# }
#
# output "secret_arn" {
#   value = aws_secretsmanager_secret.rds-secret.arn
# }
# #
# output "secret_username_arn" {
#   value = "${aws_secretsmanager_secret.rds-secret.arn}:username::"
# }
#
# output "secret_password_arn" {
#   value = "${aws_secretsmanager_secret.rds-secret.arn}:password::"
# }