#create an ec2 instance
resource "aws_instance" "mimi-salon-server" {
  ami                    = "ami-05b10e08d247fb927"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.mimi-salon-pub1.id
  vpc_security_group_ids = [aws_security_group.mimi-salon-sg.id]
  key_name               = aws_key_pair.mimi-salon-key1.key_name
  user_data              = filebase64("userdata.sh")

  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#create an EBS volume
resource "aws_ebs_volume" "mimi-salon-ebs" {
  availability_zone = "us-east-1a"
  size              = 20
  tags = {
    Name = "mimi-salon"
    env  = "Dev"
    Team = "Devops"
  }
}
#EBS volume attachment
resource "aws_volume_attachment" "mimi-salon-ebs-attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.mimi-salon-ebs.id
  instance_id = aws_instance.mimi-salon-server.id
}
