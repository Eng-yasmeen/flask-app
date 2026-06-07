resource "aws_eip" "public_eip" {
  domain = "vpc"

  tags = {
    Name = "Public-EC2-EIP"
  }
}

resource "aws_eip_association" "public_eip_assoc" {
  instance_id   = aws_instance.public_ec2.id
  allocation_id = aws_eip.public_eip.id
}
