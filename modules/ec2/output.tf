output "public_instance_id" {
  value = aws_instance.private_ec2_instance.id 
}

output "private_instance_id" {
  value = aws_instance.public_ec2_instance.id
}