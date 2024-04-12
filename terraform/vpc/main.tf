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

#comment out the following code to prevent inbound access
resource "aws_route_table" "internet_access" {
  vpc_id = aws_vpc.comcast_take_home.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.internet_access.id
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.internet_access.id
}
