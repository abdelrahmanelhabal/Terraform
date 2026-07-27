variable "name" {
  type = string
}

variable "alb_sg" {
  type = list(string)
}

variable "alb_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "target_port" {
  type = string 
  default = "8080"
}

variable "target_protocol" {
  type = string
  default = "HTTP"
}

variable "target_path" {
  type = string
  default = "/"
}

variable "instance_ids" {
  type = list(string)
}