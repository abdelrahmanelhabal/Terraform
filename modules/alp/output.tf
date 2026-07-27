output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_arn" {
  value = aws_lb.alb.arn 
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn 
}