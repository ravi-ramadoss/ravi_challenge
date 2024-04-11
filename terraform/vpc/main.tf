resource "aws_vpc" "comcast_take_home" {
  cidr_block = "10.0.0.0/16"
  tags = var.common_tags
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.comcast_take_home.id
  cidr_block = "10.0.1.0/24"
  tags = var.common_tags
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.comcast_take_home.id
  cidr_block = "10.0.2.0/24"
  tags = var.common_tags
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.comcast_take_home.id
  tags = var.common_tags
}