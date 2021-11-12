
# public cloud provider
terraform {
  required_providers {
      aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# configure the aws provider region
provider "aws" {
  region = "eu-west-2"
}

# create a vpc
#resource "aws_vpc" "jenkins" {
#  cidr_block = "10.0.0.0/16"
#}
resource "aws_vpc" "jenkins-vpc" {
  cidr_block            = var.vpc_cidr
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "jenkins-vpc"
  }
}


# chose operating system for jenkins instance
# data "aws_ami" "ubuntu" {
#   most_recent = true
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
#   }
#   filter {
#       name = "virtualization-type"
#       values = ["hvm"]
#   }  
#   owners = ["099720109477"]
# }

# create instance and determine size of the server
resource "aws_instance" "jenkins" {
  ami             = "ami-0194c3e07668a7e36"
  instance_type   = "t2.xlarge"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  security_groups = [aws_security_group.jenkins.name]
  key_name        = "jenkinskey"
  user_data = "${file("user-data-jenkins.sh")}"

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/jenkins_infra")
  }

  tags = {
    "Name"      = "Jenkins_Server"
    "Terraform" = "true"
  }
}
# set open ingress ports rules 
variable "ingressrules" {
  type    = list(number)
  default = [80, 443, 22, 8080]
}

# launch security group of the instance
resource "aws_security_group" "jenkins" {
  name        = "Jenkins - Allow web traffic"
  description = "Allow ssh and standard http/https ports inbound and everything outbound"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" = "true"
  }
}

# launch iam role for the instance so that it can connect and restore backup data from s3 bucket

resource "aws_iam_role_policy" "s3-full-policy" {
  name = "s3-full-policy"
  role = aws_iam_role.s3_role.name
  policy = "${file("s3-full-policy.json")}"
}

resource "aws_iam_role" "s3_role" {
  name = "s3_role"
  assume_role_policy = "${file("ec2-assume-policy.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = "${aws_iam_role.s3_role.name}"
}