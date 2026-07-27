output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subents[*].id 
}


output "private_subnet_ids" {
  value = aws_subnet.private_subents[*].id 
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id 
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway[*].id 
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.public.id
}

