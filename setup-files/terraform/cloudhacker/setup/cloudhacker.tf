// AWS Provider for the entire setup
provider "aws" {
  # region = "${var.aws_region}"
  region = "us-east-1"
  # shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
  profile = "default"
  # access_key = "${var.access_key}"
  # secret_key = "${var.secret_key}"
}

// variable "uniquename" {}

variable "bapcustom" {
    type = "map"
    default {
        "tag" = "bapaws"
        "azone" = "us-east-1b"
        "azonedb" = "us-east-1a"
    }
}


// Creating new vpc
resource "aws_vpc" "cloudhackerlab-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
       Name = "cloudhackerlab-vpc"
       key = "${var.bapcustom["tag"]}"
    }
}


// Creating attacker (public) subnet
resource "aws_subnet" "attacker-subnet" {
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    cidr_block ="10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.bapcustom["azone"]}"
    tags {
        Name = "attacker-subnet"
        key = "${var.bapcustom["tag"]}"      
    }
}


// Creating target (private) subnet
resource "aws_subnet" "target-subnet" {
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    cidr_block ="10.0.100.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.bapcustom["azone"]}"
    tags {
        Name = "target-subnet"
        key = "${var.bapcustom["tag"]}"
    }
}

// Creating db (private) subnet
resource "aws_subnet" "db-subnet" {
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    cidr_block ="10.0.200.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.bapcustom["azonedb"]}"
    tags {
        Name = "db-subnet"
        key = "${var.bapcustom["tag"]}"
    }
}

// Creating internet gateway for vpc
resource "aws_internet_gateway" "attacker-igw" {
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    tags {
        Name = "attacker-igw"
        key = "${var.bapcustom["tag"]}"
    }
}


// Creating subnet route table for attacker
resource "aws_route_table" "attacker-route" {
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.attacker-igw.id}"
    }
    tags {
        Name = "attacker-route"
        key = "${var.bapcustom["tag"]}"
    }
}


// Associating attacker subnet in route table
resource "aws_route_table_association" "attacker-associate-subnet" {
    subnet_id = "${aws_subnet.attacker-subnet.id}"
    route_table_id = "${aws_route_table.attacker-route.id}"
}


// Creating elastic ip for attacker machine
resource "aws_eip" "attacker-eip" {
    tags {
        Name = "attacker-eip"
        key = "${var.bapcustom["tag"]}"
    }
}


// Associating elastic ip to the attacker machine
resource "aws_eip_association" "attacker-eip-associate" {
  instance_id   = "${aws_instance.attacker-machine.id}"
  allocation_id = "${aws_eip.attacker-eip.id}"
}


// Uploading the ssh key pair to AWS
resource "aws_key_pair" "cloudhackerlabkey" {
    key_name = "cloudhackerlabkey"
    public_key = "${file("/home/student/.ssh/id_rsa.pub")}"
}


// Creating attacker machine
resource "aws_instance" "attacker-machine" {
    ami = "ami-04580aa96a68a006c"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.attacker-sg.id}"]
    subnet_id = "${aws_subnet.attacker-subnet.id}"
    key_name = "${aws_key_pair.cloudhackerlabkey.key_name}"
    user_data = <<-EOF
    #!/bin/bash
    sed -i '/packer/c\' /home/ubuntu/.ssh/authorized_keys
    mkdir -p /home/cloudhacker/.ssh
    cp /home/ubuntu/.ssh/authorized_keys /home/cloudhacker/.ssh/authorized_keys
    chown cloudhacker:cloudhacker -R /home/cloudhacker/.ssh
    EOF

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name = "attacker-machine"
        key = "${var.bapcustom["tag"]}"
    }
    
    provisioner "file" {
        source = "/home/student/.aws"
        destination = "/home/cloudhacker/.aws"
    }
    connection {
            type = "ssh"
            user = "cloudhacker"
            private_key = "${file("~/.ssh/id_rsa")}"
    }

    provisioner "local-exec" {
        command = "echo export cloudhackerip=${aws_eip.attacker-eip.public_ip} >> /home/student/.bash_profile"
    }
}


// Creating attacker security group
resource "aws_security_group" "attacker-sg" {
    name = "security_group_for_attacker"
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name = "attacker-sg"
        key = "${var.bapcustom["tag"]}"
    }
}


// Allowing all incoming connections from target subnet 
resource "aws_security_group_rule" "all" {
    security_group_id = "${aws_security_group.attacker-sg.id}"
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.100.0/24"]
}


// Creating target security group
resource "aws_security_group" "target-sg" {
    name = "security_group_for_target"
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name = "target-sg"
        key = "${var.bapcustom["tag"]}"
    }
}

// Creating db security group
resource "aws_security_group" "db-sg" {
    name = "security_group_for_db"
    vpc_id = "${aws_vpc.cloudhackerlab-vpc.id}"
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name = "db-sg"
        key = "${var.bapcustom["tag"]}"
    }
}

output "cloudhackerlab_vpc_id" {
    value = "${aws_vpc.cloudhackerlab-vpc.id}"
}

output "attacker_subnet_id" {
    value = "${aws_subnet.attacker-subnet.id}"
}

output "target_subnet_id" {
    value = "${aws_subnet.target-subnet.id}"
}

output "db_subnet_id" {
    value = "${aws_subnet.db-subnet.id}"
}

output "attacker_igw_id" {
    value = "${aws_internet_gateway.attacker-igw.id}"
}

output "attacker_route_id" {
    value = "${aws_route_table.attacker-route.id}"
}

output "attacker_eip_id" {
    value = "${aws_eip.attacker-eip.id}"
}

output "attacker_eip_public_ip" {
    value = "${aws_eip.attacker-eip.public_ip}"
}

output "attacker_machine_id" {
    value = "${aws_instance.attacker-machine.id}"
}

output "cloudlabhacker_key_name" {
    value = "${aws_key_pair.cloudhackerlabkey.key_name}"
}

output "attacker_sg_id" {
    value = "${aws_security_group.attacker-sg.id}"
}

output "target_sg_id" {
    value = "${aws_security_group.target-sg.id}"
}

output "db_sg_id" {
    value = "${aws_security_group.db-sg.id}"
}

output "attacker_machine_iip" {
    value = "${aws_instance.attacker-machine.private_ip}"
}

// Returing the attacker public ip to access
output " Your cloudhacker machine IP address is: " {
    value = "${aws_eip.attacker-eip.public_ip}"
}
