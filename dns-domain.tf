#creating a dns record
resource "aws_route53_record" "mimi-salon-dns" {
  zone_id = "Z056635211G6YQMLXKGJ2"
  name    = "mimi-salon"
  type    = "A"
  ttl     = 300

  records = [aws_instance.mimi-salon-server.public_ip]
}
