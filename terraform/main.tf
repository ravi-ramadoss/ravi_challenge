variable "use_blue" {
  description = "A boolean that determines whether to use the blue target group"
  type        = bool
  default     = true
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "comcast_take_home" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.comcast_take_home.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.comcast_take_home.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Allow inbound traffic from the load balancer to the application"
  vpc_id      = aws_vpc.comcast_take_home.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "blue" {
  name     = "blue-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.comcast_take_home.id
}

resource "aws_lb_target_group" "green" {
  name     = "green-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.comcast_take_home.id
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "raviramadoss.me"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "web_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = var.use_blue ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
  }
}
resource "aws_launch_configuration" "blue" {
  name_prefix   = "blue-lc-"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "ravi-ramadoss"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "green" {
  name_prefix   = "green-lc-"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "ravi-ramadoss"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "blue" {
  launch_configuration = aws_launch_configuration.blue.id
  min_size             = 2
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = ["subnet_id1", "subnet_id2"]
  target_group_arns    = [aws_lb_target_group.blue.arn]
}

resource "aws_autoscaling_group" "green" {
  launch_configuration = aws_launch_configuration.green.id
  min_size             = 2
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = ["subnet_id1", "subnet_id2"]
  target_group_arns    = [aws_lb_target_group.green.arn]
}