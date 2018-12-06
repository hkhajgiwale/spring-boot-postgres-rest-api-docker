variable "project" {}

variable "public_subnet_cidrs" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {}
variable "aws_key_name" {}
variable "region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "ebs_root_volume_size" {}
variable "ebs_root_volume_type" {}
variable "delete_on_termination" {}
variable "ami_id" {}
variable "kubernetes_master_instance_type" {}
variable "rest_api_demo_instance_type" {}
