variable "vpc_id" {
  type = string
}

variable "rds_sg_name" {
  type = string  
}

variable "alb_sg_name" {
  type = string
}

variable "app_sg_name" {
  type = string
}

variable "bastion_host_sg_name" {
  type = string
}