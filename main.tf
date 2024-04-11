provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "sanketkey" {
    key_name = "sanket-terrakey"
    public_key = file("/home/ubuntu/.ssh/sanket-terrakey.pub")
}

resource "aws_default_vpc" "default_vpc1" {

}

resource "aws_security_group" "sanket-ssh" {
    name = "sanket-ssh"
    description = "Allow ssh inbound traffic"
    vpc_id = aws_default_vpc.default_vpc1.id
    ingress{
        description = "TLS from VPC"
        protocol = "TCP"
        from_port = 22
        to_port = 22
        cidr_blocks= ["0.0.0.0/0"]
    }
    tags = {
        Name = "sanket-ssh"
    }
}

resource "aws_instance" "sanket-instance" {
    key_name = aws_key_pair.sanketkey.key_name
    ami = var.ec2-ubuntu-ami
    instance_type = "t2.micro"
    security_groups = [aws_security_group.sanket-ssh.name]
    tags = {
        Name = "terra-auto-instance"
    }
}
