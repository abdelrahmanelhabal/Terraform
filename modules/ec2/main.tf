# ------------------------------------------ #
#             public Ec2 Instance            #
# ------------------------------------------ #
resource "aws_instance" "public_ec2_instance" {
  ami                         = var.public_ami
  instance_type               = var.public_instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = var.public_sg_id
  key_name                    = var.public_key_name
  associate_public_ip_address = true

  tags = {
    Name = var.public_instacne_name
  }
}

# ------------------------------------------- #
#             private Ec2 Instance            #
# ------------------------------------------- #
resource "aws_instance" "private_ec2_instance" {
  ami                         = var.private_ami
  instance_type               = var.private_instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = var.private_sg_id
  key_name                    = var.private_key_name
  associate_public_ip_address = false

  tags = {
    Name = var.private_instance_name
  }
}

