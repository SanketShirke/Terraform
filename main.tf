provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "devops-decoded-my-keys" {
    key_name = "devops-decoded-key"
    public_key = file("/home/ubuntu/.ssh/devops-decoded-key.pub")
    
} 

resource "aws_default_vpc" "devops-decoded-default-vpc" {

}

resource "aws_security_group" "devops-decoded-allow-ssh" {
    name = "devops-decoded-allow-ssh"
    description = "Allow ssh from inbound traffic"
    vpc_id = aws_default_vpc.devops-decoded-default-vpc.id

    ingress {
        description = "TLS from VPC"
        protocol = "TCP"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
        Name = "devops-decoded-allow-ssh"
    }
}

resource "aws_instance" "devops-decoded-instance" {
    key_name = aws_key_pair.devops-decoded-my-keys.key_name
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.devops-decoded-allow-ssh.name]
    tags = {
        Name = "Secured Instance"
    }

}
