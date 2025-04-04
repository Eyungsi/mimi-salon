#!/bin/bash
user_data = <<-EOF
yum update -y
groupadd docker
useradd John -aG docker
yum install git unzip wget httpd -y
systemctl start httpd
systemctl enable httpd
cd /opt
 wget https://github.com/kserge2001/web-consulting/archive/refs/heads/dev.zip
unzip dev.zip
cp -r /opt/web-consulting-dev/* /var/www/html
EOF