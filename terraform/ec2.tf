resource "aws_instance" "public_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.devops_key.key_name
  tags = {
    Name = "Public-EC2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "private_ec2" {
  key_name = aws_key_pair.devops_key.key_name
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Private Apache Server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Private-Apache-EC2"
  }
}
