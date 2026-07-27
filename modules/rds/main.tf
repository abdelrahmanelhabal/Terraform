# --------------------------------------- #
#             RDS Subnet group            #
# --------------------------------------- #
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

# -------------------------- #
#             RDS            #
# -------------------------- #
resource "aws_db_instance" "rds" {
  
  engine = var.engine
  engine_version = var.rds_version 
  
  instance_class = var.instnace_type 
  allocated_storage = 10 
  username = var.username
  password = var.password 
  
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  vpc_security_group_ids = var.rds_sg_id

  skip_final_snapshot = true
  tags = {
    Name = var.rds_name 
  }
}
