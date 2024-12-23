#Referencia al modulo networking escrito en ./networking/main.tf
#En dicho archivo, encontraremos el codigo correspondiente para crear nuestra VPC, 
#Internet Gataway, Subnet Publica, Tabla de rutas y la asosiacion de la misma.
module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  us_availability_zone = var.us_availability_zone
}

#Referncia al modulo grupo de seguridad escrito en ./security-grops/main.tf
#Mediante este recurso habilitamos el trafico entrante y saliente para nuestra instancia.
module "security_group" {
  source                     = "./security-group"
  ec2_sg_name                = "SG for EC2 to enable APP(9200)"
  vpc_id                     = module.networking.dev_challenge_1_vpc_id
  public_subnet_cidr_block   = tolist(module.networking.public_subnet_cidr_block)
  ec2_sg_name_for_go_app = "SG for EC2 for enabling port 9200"
}

#Referencia al modulo ./ec2/main.tf 
#Donde encontraremos la definicion de la instancia que utilizaremos para desplegar nuestra app.
module "ec2" {
  source                   = "./ec2"
  ami_id                   = var.ec2_ami_id
  instance_type            = "t2.micro"
  tag_name                 = "Ubuntu Linux EC2"
  public_key               = var.public_key
  subnet_id                = tolist(module.networking.dev_challenge_1_public_subnets)[0]
  ec2_sg_name_for_go_app     = module.security_group.sg_ec2_for_go_app
  enable_public_ip_address = true
  user_data_install_apache = templatefile("./template/ec2_install_go_app.sh", {})
}