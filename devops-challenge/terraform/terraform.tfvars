#access_key = "AKIATQHMU6XXXXXXXXXX"
#secret_key = "aBS5TQuLG92nKNvnDo9Jjx4h2uT6ToXXXXXXXXXX"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-challenge-us-west-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
us_availability_zone = ["us-west-2a", "us-west-2b"]

ec2_user_data_install_app = "./template/ec2_install_go_app.sh"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQMPDOahrsbUcRlbj/HCxA4fkrdYVAmr+g+9R/jH/2WankSaGqTtVGZ3/bKkRyeNoRFxiLafFwc5d850jeHkGyxNNzT8Mqhtv7P2l5dIqeKFN7XszUYFDB/+cp0lOuffmcm46Ln88UisJUHQUEhrdg/f5Mk3iCztKMHRGxMqfEL7R021D2WrcBoNfHzdvM7nKALQgxckkvKQYXWbhKQK/M1dToMtmioUJBFuKw3LwEWlB4hWDyIZ5opec+n/KuPJcEB6+bVGoc+kC0dOQtCxCypJReDZjPHMb8SqXXn/nVsJUmBUnaVis2hNJXiT2avueBSUobJmfrEmxxxxxxxxxx xa00087@xa00087-desk"
ec2_ami_id     = "ami-0e2c8caa4b6378d8c"