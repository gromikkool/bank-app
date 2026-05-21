#
# //Security group
# resource "aws_security_group" "bank_app_security" {
#   name = "allow_tls"
#   vpc_id = aws_vpc.bank_app.id
#
#   tags = {
#     Name = "allow tls"
#   }
# }
#
# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   ip_protocol       = "tcp"
#   from_port = 22
#   to_port = 22
#   cidr_ipv4 = "80.68.225.245/32"
#   security_group_id = aws_security_group.bank_app_security.id
# }
#
# resource "aws_vpc_security_group_ingress_rule" "allow_http" {
#   ip_protocol       = "tcp"
#   from_port = 80
#   to_port = 80
#   cidr_ipv4 = "0.0.0.0/0"
#   security_group_id = aws_security_group.bank_app_security.id
# }
#
# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   ip_protocol       = "-1"
#   cidr_ipv4 = "0.0.0.0/0"
#   security_group_id = aws_security_group.bank_app_security.id
# }
#
# resource "aws_key_pair" "deployer" {
#   key_name   = "my-aws-key"
#   public_key = file("my-aws-key.pub")
# }
#
# resource "aws_instance" "bank_server" {
#   ami = "ami-0ed094fb1304fd857"
#   instance_type = "t3.micro"
#
#   availability_zone = "us-east-1a"
#   key_name = aws_key_pair.deployer.key_name
#
#   subnet_id = aws_subnet.bank_app_public_subnet.id
#   vpc_security_group_ids = [aws_security_group.bank_app_security.id]
#
#   user_data = file("userdata.sh")
#   user_data_replace_on_change = true
#
#   tags = {
#     Name = "BankApp-Server"
#   }
# }