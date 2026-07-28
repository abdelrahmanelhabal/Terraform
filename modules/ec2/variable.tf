variable "public_instacne_name" {
  type = string
}

variable "public_ami" {
  type = string
}

variable "public_instance_type" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "public_sg_id" {
  type = list(string)
}


variable "public_key_name" {
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

variable "private_subnet_id" {
  type = string
}

variable "private_sg_id" {
  type = list(string)
}


variable "private_key_name" {
  type = string
}


