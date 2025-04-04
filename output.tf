output "aws_instance_id" {
  value = aws_instance.mimi-salon-server.associate_public_ip_address
}
output "public_ip" {
  value = aws_subnet.mimi-salon-pub1.availability_zone_id
}
output "key_name" {
  value = aws_key_pair.mimi-salon-key1.key_name
}
output "aws_eip" {
  value = aws_eip.mimi-salon-eip.address
}
output "aws_volume_attachment" {
  value = aws_ebs_volume.mimi-salon-ebs.size
}
output "aws_route53_record" {
  value = aws_route53_record.mimi-salon-dns.name
}
