resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = var.private_key_path
  content         = tls_private_key.ssh.private_key_openssh
  file_permission = "0400"
}