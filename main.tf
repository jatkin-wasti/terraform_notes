# Which Cloud Provider is required?
## AWS as we have our AMI's on AWS

provider "aws" {
         region = var.region
}

resource "aws_instance" "nodejs_instance"{
        ami = var.app_ami
        instance_type = "t2.micro"
        associate_public_ip_address = true
        subnet_id = aws_subnet.subnet-public.id
        security_groups = ["eng74-jamie-tf-app-SG"]
        tags = {
            Name = "eng74-jamie-tf-app"
        }
        key_name = "eng74-jamie-aws-key"
}

resource "aws_vpc" "vpc_terraform" {
      cidr_block = "18.0.0.0/16"
      instance_tenancy = "default"
      tags = {
          Name = "eng74-jamie_vpc_terraform"
    }
}

resource "aws_internet_gateway" "gw" {
      vpc_id = aws_vpc.vpc_terraform.id
      tags = {
          Name = "eng74-jamie-igw-terraform"
      }
}

resource "aws_subnet" "subnet-public" {
      vpc_id = aws_vpc.vpc_terraform.id
      cidr_block = "18.0.1.0/24"
      tags = {
          Name = "eng74-jamie-pub-subnet-terraform"
      }
}

resource "aws_network_acl" "public_nacl" {
      vpc_id = aws_vpc.vpc_terraform.id
      subnet_ids = [aws_subnet.subnet-public.id]

      ingress {
          protocol = "tcp"
          rule_no = 100
          action = "allow"
          cidr_block = "0.0.0.0/0"
          from_port = 80
          to_port = 80
      }

      ingress {
          protocol = "tcp"
          rule_no = 110
          action = "allow"
          cidr_block = "0.0.0.0/0"
          from_port = 443
          to_port = 443
      }

      ingress {
          protocol = "tcp"
          rule_no = 120
          action = "allow"
          cidr_block = "0.0.0.0/0"
          from_port = 1024
          to_port = 65535
      }

      ingress {
          protocol = "tcp"
          rule_no = 130
          action = "allow"
          cidr_block = "82.25.225.127/32"
          from_port = 22
          to_port = 22
      }

      egress {
          protocol = "all"
          rule_no = 100
          action = "allow"
          cidr_block = "0.0.0.0/0"
          from_port = 0
          to_port = 0
      }
      tags = {
          Name = "eng74-jamie-terraform-nacl"
      }
}

resource "aws_route_table" "route_table_public" {
      vpc_id = aws_vpc.vpc_terraform.id

      route {
          cidr_block = "0.0.0.0/0"
          gateway_id = aws_internet_gateway.gw.id
      }
      tags = {
          Name = "eng74-jamie-terraform-route-table"
      }
}

resource "aws_route_table_association" "route_public_association" {
      route_table_id = aws_route_table.route_table_public.id
      subnet_id = aws_subnet.subnet-public.id
}
