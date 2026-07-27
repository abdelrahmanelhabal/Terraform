provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  
  vpc_name = var.vpc_name
  igw_name = var.igw_name
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr 
  private_subnet_cidr = var.private_subnet_cidr 
  availability_zone = var.availability_zone
  public_route_table_name = var.public_route_table_name 
  private_route_table_name = var.private_route_table_name 
}

module "security_groups" {
  source = "./modules/security group"
  
  vpc_id = module.vpc.vpc_id
  alb_sg_name = var.alb_sg_name
  bastion_host_sg_name = var.bastion_host_sg_name
  app_sg_name = var.app_sg_name 
  rds_sg_name = var.rds_sg_name
}

module "key_pair" {
  source = "./modules/key_pair"
  key_name = var.key_name
  private_key_path = "${path.module}/${var.key_name}.pem"
}


module "ec2_instance" {
    source = "./modules/ec2"
  
  
  public_instacne_name = var.public_instacne_name
  public_ami = var.public_ami 
  public_instance_type = var.public_instance_type
  public_sg_id = [module.security_groups.bation_host_sg_id]
  public_subnet_id = module.vpc.public_subnet_ids[0]
  public_key_name = var.key_name

  private_instance_name = var.private_instance_name
  private_ami = var.private_ami 
  private_instance_type = var.private_instance_type 
  private_sg_id =  [module.security_groups.bation_host_sg_id]
  private_subnet_id = module.vpc.private_subnet_ids[0]
  private_key_name = var.key_name
}

module "alb" {
  source = "./modules/alp"

  name = var.alb_name
  alb_sg = [module.security_groups.alb_sg_id]
  alb_subnet_ids = module.vpc.public_subnet_ids
  target_port = var.target_port
  vpc_id = module.vpc.vpc_id
  target_protocol = var.target_protocol
  target_path = var.target_path 
  instance_ids = [module.ec2_instance.private_instance_id]
}

module "rds" {
  source = "./modules/rds"
  rds_name = var.rds_name
  subnet_group_name = var.subnet_group_name
  subnet_ids = module.vpc.private_subnet_ids
  engine = var.rds_engine
  rds_version = var.rds_version
  instnace_type = var.rds_instnace_type
  username = var.rds_username
  password = var.rds_password
  rds_sg_id = [module.security_groups.rds_sg_id]
}