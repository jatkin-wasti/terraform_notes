resource "aws_instance" "db_instance"{
        ami = var.db_ami
        instance_type = "t2.micro"
        associate_public_ip_address = true
        subnet_id = aws_subnet.subnet-public.id
        vpc_security_group_ids = [aws_security_group.eng74-jamie-tf-db-SG.id]
        tags = {
            Name = "eng74-jamie-tf-db"
        }
        key_name = "eng74-jamie-aws-key"
}
