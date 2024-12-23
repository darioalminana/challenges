variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "enable_public_ip_address" {}
variable "ec2_user_data_install_app" {}
variable "ec2_sg_name_for_go_app" {}

output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /home/ubuntu/keys/aws_ec2_terraform ubuntu@", aws_instance.dev_challenge_1_ec2.public_ip)
}

output "dev_challenge_1_ec2_instance_id" {
  value = aws_instance.dev_challenge_1_ec2.id
}

resource "aws_instance" "dev_challenge_1_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = "aws_key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.ec2_sg_name_for_go_app]
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.ec2_user_data_install_app

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "dev_challenge_1_public_key" {
  key_name   = "aws_key"
  public_key = var.public_key
}