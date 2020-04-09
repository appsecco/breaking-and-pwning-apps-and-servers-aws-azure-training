// AWS Provider for the entire setup
provider "aws" {
  # region = "${var.aws_region}"
  region = "us-east-1"
//   shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
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
        "db_target_ip" = "10.0.100.21"
        "rds_db_username" = "rdsroot"
        "rds_db_password" = "QaoiPsDOffensive!1"
        "rds_db_name" = "awscloudsecappconnect"
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

data "aws_subnet" "db-subnet" {
  vpc_id = "${data.aws_vpc.cloudhackerlab-vpc.id}"
    tags {
    Name = "db-subnet"
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

data "aws_security_group" "db-sg" {
  vpc_id = "${data.aws_vpc.cloudhackerlab-vpc.id}"
  tags {
    Name = "db-sg"
    key = "${var.bapcustom["tag"]}"
  }
}

resource "aws_db_subnet_group" "rds-subnet-grp" {
  name       = "rds-subnet-grp"
  subnet_ids = ["${data.aws_subnet.target-subnet.id}", "${data.aws_subnet.db-subnet.id}"]

  tags {
    Name = "rds-subnet-grp"
    key = "${var.bapcustom["tag"]}"
  }
}


resource "aws_db_instance" "rds-mysql" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.6.37"
  instance_class       = "db.t2.micro"
  username             = "${var.bapcustom["rds_db_username"]}"
  password             = "${var.bapcustom["rds_db_password"]}"
  identifier           = "${var.bapcustom["rds_db_name"]}"
  db_subnet_group_name = "${aws_db_subnet_group.rds-subnet-grp.id}"
  // parameter_group_name = "default.mysql5.6"
  availability_zone    = "${var.bapcustom["azone"]}"
  allow_major_version_upgrade = "false"
  // auto_minor_version_upgrade = "false"
  multi_az             = "false"
  // identifier_prefix    = "${var.uniquename}"
  port                 = 3306
  publicly_accessible  = "false"
  // security_group_names = ""
  vpc_security_group_ids = ["${data.aws_security_group.target-sg.id}"]
  skip_final_snapshot  = "true"
  tags {
      Name = "rds-mysql"
      key = "${var.bapcustom["tag"]}"
  }
}


resource "aws_instance" "db-target-machine" {
    ami = "ami-7e1bf603"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${data.aws_security_group.target-sg.id}"]
    subnet_id = "${data.aws_subnet.target-subnet.id}"
    private_ip = "${var.bapcustom["db_target_ip"]}"
    key_name = "cloudhackerlabkey"
    user_data = <<-EOF
    #!/bin/bash
    sed -i '/packer/c\' /home/ubuntu/.ssh/authorized_keys
    rdsendpoint="${element(split(":", aws_db_instance.rds-mysql.endpoint), 0)}"
    sed -i 's/RDS-ENDPOINT-HERE/${element(split(":", aws_db_instance.rds-mysql.endpoint), 0)}/g' /var/www/private/dbconfig.php
    mysql -u ${var.bapcustom["rds_db_username"]} -pQaoiPsDOffensive\!1 -h ${element(split(":", aws_db_instance.rds-mysql.endpoint), 0)} < /var/www/private/sqlapp.sql
    service apache2 restart
    EOF

    lifecycle {
        create_before_destroy = true
    }

    tags {
      Name = "db-target-machine"
      key = "${var.bapcustom["tag"]}"
    }
}


output "rds_target_endpoint" {
    value = "${aws_db_instance.rds-mysql.endpoint}"
}

output "rds_target_id" {
    value = "${aws_db_instance.rds-mysql.id}"
}

output "db_target_machine_iip" {
    value = "${aws_instance.db-target-machine.private_ip}"
}

// Returing the attacker public ip to access
output " Your cloud-db machine internal IP address is: " {
    value = "${aws_instance.db-target-machine.private_ip}"
}

// Returing the attacker public ip to access
output " Your RDS MySQL instance endpoint is: " {
    value = "${aws_db_instance.rds-mysql.endpoint}"
}