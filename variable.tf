variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}

variable "alb_sg_name" {
  type = string
}

variable "bastion_host_sg_name" {
  type = string
}

variable "app_sg_name" {
  type = string
}

variable "rds_sg_name" {
  type = string
}

variable "public_instacne_name" {
  type = string
}

variable "public_ami" {
  type = string
}

variable "public_instance_type" {
  type = string
}

variable "private_instance_name" {
  type = string
}

variable "private_ami" {
  type = string
}

variable "private_instance_type" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "target_port" {
  type = string
}

variable "target_protocol" {
  type = string
}

variable "target_path" {
  type = string
}

variable "rds_name" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "rds_engine" {
  type = string
}

variable "rds_version" {
  type = string
}

variable "rds_instnace_type" {
  type = string
}

variable "rds_username" {
  type      = string
  sensitive = true
}

variable "rds_password" {
  type      = string
  sensitive = true
}

variable "key_name" {
  type = string
}