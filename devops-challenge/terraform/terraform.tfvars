#access_key = ""
#secret_key = ""

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-challenge-us-west-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
us_availability_zone = ["us-west-2a", "us-west-2b"]

ec2_user_data_install_app = "./template/ec2_install_go_app.sh"

public_key = ""
ec2_ami_id     = "ami-0e2c8caa4b6378d8c"