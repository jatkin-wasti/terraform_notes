resource "aws_instance" "db_instance"{
        ami = "ami-0ce081d2daeaa8021"
        instance_type = "t2.micro"
        associate_public_ip_address = true
        tags = {
            Name = "eng74-jamie-tf-db"
        }
        key_name = "eng74-jamie-aws-key"
}
