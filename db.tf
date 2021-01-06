resource "aws_instance" "db_instance"{
        ami = var.db_ami
        instance_type = "t2.micro"
        associate_public_ip_address = true
        subnet_id = aws_subnet.subnet-public.id
        security_groups = ["eng74-jamie-tf-db-SG"]
        tags = {
            Name = "eng74-jamie-tf-db"
        }
        key_name = "eng74-jamie-aws-key"
}
