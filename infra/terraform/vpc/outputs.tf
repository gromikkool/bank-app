output "vpc_id" {
  value = aws_vpc.bank-app-terr-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.bank-public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.bank-private[*].id
}

output "db_subnet_ids" {
  value = aws_subnet.bank-db[*].id
}