resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Allow inbound traffic from the load balancer to the application"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.0.2.0/24"]
  }
  tags = var.common_tags
}

resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh"
  description = "Allow inbound SSH traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["71.255.106.225/32"]
  }

  tags = var.common_tags
}