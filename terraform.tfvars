vpc_name = "vpc" 
igw_name = "igw"
vpc_cidr = "10.0.0.0/16" 
public_subnet_cidr = ["10.0.1.0/24" , "10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24" , "10.0.4.0/24"]
availability_zone = ["us-east-1a" , "us-east-1b"]
public_route_table_name = "public_rt"
private_route_table_name = "private_rt"


alb_sg_name = "alb_sg"
bastion_host_sg_name = "bastion_host_sg"
app_sg_name = "app_sg" 
rds_sg_name = "rds_sg"

key_name = "my-key"


public_instacne_name = "public-1"
public_ami =  "ami-0b6d9d3d33ba97d99"
public_instance_type = "t3.micro"
private_instance_name = "private-1" 
private_ami = "ami-0b6d9d3d33ba97d99"
private_instance_type = "t3.micro"


alb_name = "app-alb"
target_port = "8080"
target_protocol = "HTTP"
target_path = "/products"

rds_name = "app_rds"
subnet_group_name = "sg_rds"
rds_engine = "mysql"
rds_version = "8.0"
rds_instnace_type = "db.t4g.micro"
rds_username = "admin"
rds_password = "abdo11223344"