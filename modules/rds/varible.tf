variable "subnet_group_name" {
  type = string
}

variable "rds_name" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}

variable "engine" {
  type = string
}

variable "rds_version" {
  type = string
}

variable "instnace_type" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "rds_sg_id" {
  type = list(string)
}