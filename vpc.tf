#create a vpc code for mimi-salon
resource "aws_vpc" "mimi-salon" {
  cidr_block           = "172.120.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#create subnets for the VPC (pub-subnet 1)
resource "aws_subnet" "mimi-salon-pub1" {
  vpc_id                  = aws_vpc.mimi-salon.id
  map_public_ip_on_launch = true
  cidr_block              = "172.120.1.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}

#create subnets for the VPC (pub-subnet 2)
resource "aws_subnet" "mimi-salon-pub2" {
  vpc_id                  = aws_vpc.mimi-salon.id
  map_public_ip_on_launch = true
  cidr_block              = "172.120.2.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#create subnets for the VPC (priv-subnet 1)
resource "aws_subnet" "mimi-salon-priv1" {
  vpc_id                  = aws_vpc.mimi-salon.id
  map_public_ip_on_launch = true
  cidr_block              = "172.120.3.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#create subnets for the VPC (priv-subnet 2)
resource "aws_subnet" "mimi-salon-priv2" {
  vpc_id                  = aws_vpc.mimi-salon.id
  map_public_ip_on_launch = true
  cidr_block              = "172.120.4.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}

#internet gateway for mimi salon
resource "aws_internet_gateway" "mimi-salon-igw" {
  vpc_id = aws_vpc.mimi-salon.id
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#Elastic IP for mimi salon
resource "aws_eip" "mimi-salon-eip" {

  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}


#Nat gateway for mimi-salon
resource "aws_nat_gateway" "mimi-salon-natgw" {
  allocation_id = aws_eip.mimi-salon-eip.id
  subnet_id     = aws_subnet.mimi-salon-pub1.id
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}


#create public routetable  for mimi-salon
resource "aws_route_table" "mimi-salon-rt1" {
  vpc_id = aws_vpc.mimi-salon.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mimi-salon-igw.id
  }
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#create private routetable  for mimi-salon
resource "aws_route_table" "mimi-salon-rt2" {
  vpc_id = aws_vpc.mimi-salon.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mimi-salon-natgw.id
  }
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}

#public subnet1 association
resource "aws_route_table_association" "mimi-salon-rt-pub1" {
  subnet_id      = aws_subnet.mimi-salon-pub1.id
  route_table_id = aws_route_table.mimi-salon-rt1.id
}
#public subnet2 association
resource "aws_route_table_association" "mimi-salon-rt-pub2" {
  subnet_id      = aws_subnet.mimi-salon-pub2.id
  route_table_id = aws_route_table.mimi-salon-rt1.id
}
#private1 subnet1 association
resource "aws_route_table_association" "mimi-salon-rt-priv1" {
  subnet_id      = aws_subnet.mimi-salon-priv1.id
  route_table_id = aws_route_table.mimi-salon-rt2.id
}
#public subnet2 association
resource "aws_route_table_association" "mimi-salon-rt-priv2" {
  subnet_id      = aws_subnet.mimi-salon-priv2.id
  route_table_id = aws_route_table.mimi-salon-rt2.id
}

