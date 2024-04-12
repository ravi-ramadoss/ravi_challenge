


resource "aws_lb" "web_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_1_id, var.subnet_2_id]

  access_logs {
    bucket  = var.lb_logs_bucket
    prefix  = "lb"
    enabled = true
  }

  enable_deletion_protection = false
  tags = var.common_tags
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.use_blue ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.use_blue ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
  }
}

resource "aws_lb_target_group" "blue" {
  name     = "blue-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = var.common_tags
}

resource "aws_lb_target_group" "green" {
  name     = "green-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = var.common_tags
}

