resource "aws_security_group" "eng74-jamie-tf-db-SG" {
  name        = "eng74-jamie-tf-db-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-07e47e9d90d2076da"

  ingress {
    description = "TLS from VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["172.31.16.220/32"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["82.25.225.127/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng74-jamie-tf-db-SG"
  }
}
