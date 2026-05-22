variable "env" {
  type = string
}

variable "name" {
  type=string #"keycloak", "person"
}

variable "db_subnet_ids" {
  type = list(string)
}

variable vpc_id {
  type = string
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "ecs_tasks_sg_id" {
  type = string
}