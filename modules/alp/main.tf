# ----------------------------------------------- #
#             Application Load Balance            #
# ----------------------------------------------- #
resource "aws_lb" "alb" {
  name = var.name 
  load_balancer_type = "application"
  internal = false
  security_groups = var.alb_sg
  subnets = var.alb_subnet_ids
}

# ----------------------------------- #
#             Target group            #
# ----------------------------------- #
resource "aws_lb_target_group" "app" {
  name = "${var.name}-tg" 
  port = var.target_port  
  protocol = var.target_protocol 
  vpc_id = var.vpc_id 

  health_check {
    path = var.target_path
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}

# ------------------------------------------ #
#             Attach EC2 Instances           #
# ------------------------------------------ #
resource "aws_lb_target_group_attachment" "app" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.instance_ids[count.index]
  port             = var.target_port
}

# ------------------------------- #
#             Listener            #
# ------------------------------- #
resource "aws_lb_listener" "Listener" {
  load_balancer_arn = aws_lb.alb.arn 
  port = 80 
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}