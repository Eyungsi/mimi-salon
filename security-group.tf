#create security groups for mimi-salon
resource "aws_security_group" "mimi-salon-sg" {
  name        = "mimi-salon"
  description = "Allow ssh ,HTTP on 22,80 and 8080"
  vpc_id      = aws_vpc.mimi-salon.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "Allow HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["69.250.208.198/32"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
