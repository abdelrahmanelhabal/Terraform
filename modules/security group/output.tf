output "bation_host_sg_id" {
  value = aws_security_group.public_group.id 
}

output "app_sg_id" {
  value = aws_security_group.private_group.id 
}

output "alb_sg_id" {
  value = aws_security_group.alb_group.id 
}

output "rds_sg_id" {
  value = aws_security_group.rds_group.id 
}