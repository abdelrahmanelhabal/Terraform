variable "vpc_name" {
  type = string 
}

variable "vpc_cidr" {
  type = string 
}

variable "igw_name" {
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