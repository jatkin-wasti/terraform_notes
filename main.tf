# Which Cloud Provider is required?
## AWS as we have our AMI's on AWS

provider "aws" {
         region = var.region
}

resource "aws_instance" "nodejs_instance"{
        ami = var.app_ami
        instance_type = "t2.micro"
        associate_public_ip_address = true
        tags = {
            Name = "eng74-jamie-tf-app"
        }
        key_name = "eng74-jamie-aws-key"
}

resource "aws_vpc" "vpc-terraform-name" {
      cidr_block = "18.0.0.0/16"
      instance_tenancy = "default"
      tags = {
          Name = "eng74-jamie_vpc_terraform"
    }
}

resource "aws_internet_gateway" "gw" {
      vpc_id = aws_vpc.vpc-terraform-name.id
      tags = {
          Name = "eng74-jamie-igw-terraform"
      }
}

resource "aws_subnet" "subnet-public" {
      vpc_id = aws_vpc.vpc-terraform-name.id
      cidr_block = "18.0.1.0/24"
      tags = {
          Name = "eng74-jamie-pubsubnet-terraform"
      }
}

resource "aws_default_network_acl" "default" {
      default_network_acl_id = aws_vpc.vpc-terraform-name.default_network_acl_id

      ingress {
          protocol = -1
          rule_no = 100
          action = "allow"
          cidr_block = "18.0.1.0/24"
          from_port = 0
          to_port = 0
      }

      egress {
          protocol = -1
          rule_no = 100
          action = "allow"
          cidr_block = "0.0.0.0/0"
          from_port = 0
          to_port = 0
      }
}
