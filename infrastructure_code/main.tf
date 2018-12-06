provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket     = "terraform-code"
    key        = "tf_states/docker_app/docker_app.tfstate"
    region     = "us-east-1"
    access_key = ""
    secret_key = ""
  }
}

##VPC
resource "aws_vpc" "docker-app-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name        = "docker-app-prod-vpc"
    Description = "VPC for Docker app"
  }
}

##Public Subnets
resource "aws_subnet" "docker-app-public-subnet" {
  vpc_id                  = "${aws_vpc.docker-app-vpc.id}"
  cidr_block              = "${var.public_subnet_cidrs[count.index]}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  count                   = "${length(var.public_subnet_cidrs)}"
  map_public_ip_on_launch = true

  tags {
    Name = "docker-app-public-subnet-0"
  }
}

##Internet Gateway
resource "aws_internet_gateway" "docker-app-igw" {
  vpc_id = "${aws_vpc.docker-app-vpc.id}"

  tags {
    Name = "docker-app-igw"
  }
}

##Route table for public subnet
resource "aws_route_table" "docker-app-public-rtb" {
  vpc_id = "${aws_vpc.docker-app-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.docker-app-igw.id}"
  }
}

## Route table associations with public subnet 0
resource "aws_route_table_association" "docker-app-route-table-association-public-0" {
  subnet_id      = "${element(aws_subnet.docker-app-public-subnet.*.id,0)}"
  route_table_id = "${aws_route_table.docker-app-public-rtb.id}"
}

data "template_file" "nat_user_data" {
  template = "${file("nat_userdata.sh")}"

  vars {
    host_name = "${format("%s-nat", var.project)}"
  }
}

##NAT for private subnet
resource "aws_instance" "docker-app-nat" {
  ami                         = "ami-00a9d4a05375b2763"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.nat-sg-docker-app.id}"]
  subnet_id                   = "${element(aws_subnet.docker-app-public-subnet.*.id,0)}"
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${data.template_file.nat_user_data.rendered}"

  tags = {
    Name = "${format("%s-nat",var.project)}"
  }
}

resource "aws_instance" "rest-api-docker-demo" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.rest_api_demo_instance_type}"
  subnet_id              = "${element(aws_subnet.docker-app-public-subnet.*.id,0)}"
  vpc_security_group_ids = ["${aws_security_group.public_sg.id}"]
  user_data              = "${file("rest-api-docker-demo-startup.sh")}"
  key_name               = "${var.aws_key_name}"

  tags {
    Name = "rest-api-docker-demo"
  }
}

resource "aws_instance" "kubernetes-master" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.kubernetes_master_instance_type}"
  subnet_id              = "${element(aws_subnet.docker-app-public-subnet.*.id,0)}"
  key_name               = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.public_sg.id}"]

  root_block_device {
    delete_on_termination = "${var.delete_on_termination}"
    volume_size           = "${var.ebs_root_volume_size}"
    volume_type           = "${var.ebs_root_volume_type}"
  }

  tags {
    Name = "kubernetes-master"
  }
}

# security group for NAT
resource "aws_security_group" "nat-sg-docker-app" {
  name        = "docker-app-nat-sg-"
  description = "Security group for NAT instance of docker-app"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.docker-app-vpc.id}"

  tags {
    Name = "${var.project}-nat-sg"
  }
}

resource "aws_security_group" "public_sg" {
  name        = "public-instance-sg"
  description = "Allowing ingress to only specific ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.docker-app-vpc.id}"

  tags {
    Name = "public-sg"
  }
}
