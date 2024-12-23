variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "public_subnet_cidr_block" {}
variable "ec2_sg_name_for_go_app" {}

output "sg_ec2_for_go_app" {
  value = aws_security_group.ec2_sg_app.id

}

#Creacion del security group que permite que el trafico externo ingrese por puerto 9200
#a instacia que aloja nuesta aplicacion y permite el trafico saliente sin restricciones.
resource "aws_security_group" "ec2_sg_app" {
  name        = var.ec2_sg_name
  description = "Enable the Port 9200(app)"
  vpc_id      = var.vpc_id

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
  }

  #Outgoing request
  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Groups to allow APP(9200)"
  }
}