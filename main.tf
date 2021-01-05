# Which Cloud Provider is required?
## AWS as we have our AMI's on AWS

provider "aws" {
         region = "eu-west-1"
}

resource "aws_instance" "nodejs_instance"{
        ami = "ami-04337085e29a3125f"
        instance_type = "t2.micro"
        associate_public_ip_address = true
        tags = {
            Name = "eng74-jamie-tf-app"
        }
        key_name = "eng74-jamie-aws-key"
}
