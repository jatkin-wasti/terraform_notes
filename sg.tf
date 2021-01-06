resource "aws_security_group" "eng74-jamie-tf-app-SG"{
	name = "eng74-jamie-tf-app-SG"
	description = "Allow access to app"
	vpc_id = aws_vpc.vpc-terraform-name.id

	ingress {
		description = "HTTP from all"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "HTTPS from all"
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "SSH from home"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["82.25.225.127/32"]
	}

	egress {
		description = "All traffic out"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "eng74-jamie-tf-app-SG"
	}
}

resource "aws_security_group" "eng74-jamie-tf-db-SG" {
  name        = "eng74-jamie-tf-db-SG"
  description = "Allow traffic for app communication"
  vpc_id      = aws_vpc.vpc-terraform-name.id

  ingress {
    description = "Mongo from app instance"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["172.31.16.220/32"]
  }

  ingress {
    description = "SSH from local ip"
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
