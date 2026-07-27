# ----------------------------------------- -------- #
#           Bastion Host Security Group              #
# -------------------------------------------------- #
resource "aws_security_group" "public_group" {
  name = var.bastion_host_sg_name
  vpc_id = var.vpc_id   

  ingress{
    description = "SSH"

    from_port = 22
    to_port = 22 
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }  
  tags = {
    Name = var.bastion_host_sg_name
  }
}
 
# ----------------------------------------- #
#           App Security Group              #
# ----------------------------------------- #
resource "aws_security_group" "private_group" {
  name = var.app_sg_name
  vpc_id = var.vpc_id    

  ingress{
    description = "SSH"

    from_port = 22
    to_port = 22 
    protocol = "tcp"

    security_groups = [
        aws_security_group.public_group.id 
    ]
  }  

  ingress{
    description = "HTTP"
    from_port = 8080 
    to_port = 8080
    protocol = "tcp"
    security_groups = [
        aws_security_group.alb_group.id
    ]
  }
  tags = {
    Name = var.app_sg_name
  }
}

# ----------------------------------------- #
#           ALB Security Group              #
# ----------------------------------------- #
resource "aws_security_group" "alb_group" {
  name = var.alb_sg_name
  vpc_id = var.vpc_id 

  ingress {
    description = "HTTP"
    from_port = 80 
    to_port = 80 
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.alb_sg_name 
  }
}

# ----------------------------------------- #
#           RDS Security Group              #
# ----------------------------------------- #
resource "aws_security_group" "rds_group" {
    name = var.rds_sg_name
    vpc_id = var.vpc_id 
    ingress {
        from_port = 3306 
        to_port = 3306 
        protocol = "tcp"
        security_groups = [
          aws_security_group.public_group.id , 
          aws_security_group.private_group.id 
          ] 
    }
    tags = {
      Name = var.rds_sg_name
    }
} 