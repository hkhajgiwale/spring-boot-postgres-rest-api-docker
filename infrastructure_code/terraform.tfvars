project = "docker-app"


public_subnet_cidrs = ["20.30.2.0/24"]

availability_zones = ["us-east-1a","us-east-1b"]



vpc_cidr = "20.30.0.0/16"

aws_key_name = "harsh_aws_key"

region = "us-east-1"
aws_region = "us-east-1"
ebs_root_volume_size = "20"
ebs_root_volume_type = "gp2"
delete_on_termination = "true"

ami_id = "ami-0ac019f4fcb7cb7e6"

kubernetes_master_instance_type = "t3.micro"
rest_api_demo_instance_type = "t2.micro"