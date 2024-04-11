

resource "aws_launch_configuration" "blue" {
  name_prefix   = "blue-lc-"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [var.ec2_security_group_id]

}

resource "aws_launch_configuration" "green" {
  name_prefix   = "green-lc-"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [var.ec2_security_group_id]
}

resource "aws_autoscaling_group" "blue" {
  launch_configuration = aws_launch_configuration.blue.id
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [var.subnet_1_id, var.subnet_2_id]
  target_group_arns    = [var.blue_target_group_arn]
}

resource "aws_autoscaling_group" "green" {
  launch_configuration = aws_launch_configuration.green.id
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [var.subnet_1_id, var.subnet_2_id]
  target_group_arns    = [var.green_target_group_arn]
}