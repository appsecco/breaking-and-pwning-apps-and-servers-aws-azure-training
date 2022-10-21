// AWS Provider for the entire setup
provider "aws" {
  # region = "${var.aws_region}"
  region = "us-east-1"
//   shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
  profile = "default"
  # access_key = "${var.access_key}"
  # secret_key = "${var.secret_key}"
}

variable "uniquename" {}

variable "bapcustom" {
    type = "map"
    default {
        "tag" = "bapaws"
        "azone" = "us-east-1b"
        "compute_target_ip" = "10.0.100.11"
    }
}


##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "cloudhackerlab-vpc" {
      tags {
        Name = "cloudhackerlab-vpc"
        key = "${var.bapcustom["tag"]}"
    }
}

data "aws_subnet" "target-subnet" {
  vpc_id = "${data.aws_vpc.cloudhackerlab-vpc.id}"
    tags {
    Name = "target-subnet"
    key = "${var.bapcustom["tag"]}"
  }
}

data "aws_security_group" "target-sg" {
  vpc_id = "${data.aws_vpc.cloudhackerlab-vpc.id}"
  tags {
    Name = "target-sg"
    key = "${var.bapcustom["tag"]}"
  }
}


resource "aws_iam_instance_profile" "ec2access" {
  name  = "ec2access"
  role = "${aws_iam_role.ec2accessrole.name}"
}

resource "aws_iam_role" "ec2accessrole" {
  name = "ec2access"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
    role       = "${aws_iam_role.ec2accessrole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_instance" "compute-target-machine" {
    ami = "ami-4f1ef332"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${data.aws_security_group.target-sg.id}"]
    subnet_id = "${data.aws_subnet.target-subnet.id}"
    private_ip = "${var.bapcustom["compute_target_ip"]}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2access.name}"
    user_data = <<-EOF
    #!/bin/bash
    sed -i '/packer/c\' /home/ubuntu/.ssh/authorized_keys
    sed -i 's/uniqueID/${var.uniquename}/g' /etc/apache2/sites-available/publicsite.conf
    service apache2 restart
    EOF

    lifecycle {
        create_before_destroy = true
    }

    tags {
      Name = "compute-target-machine"
      key = "${var.bapcustom["tag"]}"
    }
}


output "target_machine_iip" {
    value = "${aws_instance.compute-target-machine.private_ip}"
}

// Returing the attacker public ip to access
output " Your target machine internal IP address is: " {
    value = "${aws_instance.compute-target-machine.private_ip}"
}