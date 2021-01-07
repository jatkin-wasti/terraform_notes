resource "aws_instance" "db_instance"{
        ami = var.db_ami
        instance_type = "t2.micro"
        associate_public_ip_address = true
        subnet_id = aws_subnet.subnet-private.id
        vpc_security_group_ids = [aws_security_group.eng74-jamie-tf-db-SG.id]
        tags = {
            Name = "eng74-jamie-tf-db"
        }
        key_name = "eng74-jamie-aws-key"
}

resource "aws_subnet" "subnet-private" {
      vpc_id = aws_vpc.vpc-terraform.id
      cidr_block = "18.0.2.0/24"
      tags = {
          Name = "eng74-jamie-priv-subnet-terraform"
      }
}

resource "aws_network_acl" "private_nacl" {
      vpc_id = aws_vpc.vpc-terraform.id
      subnet_ids = [aws_subnet.subnet-private.id]

      ingress {
          protocol = "tcp"
          rule_no = 100
          action = "allow"
          cidr_block = "18.0.1.0/24"
          from_port = 27017
          to_port = 27017
      }

      ingress {
          protocol = "tcp"
          rule_no = 110
          action = "allow"
          cidr_block = "82.25.225.127/32"
          from_port = 22
          to_port = 22
      }

      egress {
          protocol = "tcp"
          rule_no = 100
          action = "allow"
          cidr_block = "18.0.1.0/24"
          from_port = 80
          to_port = 80
      }

      egress {
          protocol = "tcp"
          rule_no = 110
          action = "allow"
          cidr_block = "18.0.1.0/24"
          from_port = 443
          to_port = 443
      }

      egress {
          protocol = "tcp"
          rule_no = 120
          action = "allow"
          cidr_block = "18.0.1.0/24"
          from_port = 1024
          to_port = 65535
      }

      tags = {
          Name = "eng74-jamie-terraform-nacl-private"
      }
}
