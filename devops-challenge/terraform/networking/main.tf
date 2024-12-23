variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "us_availability_zone" {}

output "dev_challenge_1_vpc_id" {
  value = aws_vpc.dev_challenge_1_vpc_us_west_2.id
}

output "dev_challenge_1_public_subnets" {
  value = aws_subnet.dev_challenge_1_public_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.dev_challenge_1_public_subnets.*.cidr_block
}

# Setup VPC creamos este recurso bajo el nombre dev_challenge_1_vpc_us_west_2.
resource "aws_vpc" "dev_challenge_1_vpc_us_west_2" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Setup public subnet creamos 2 redes publicas en nuestra VPC.
resource "aws_subnet" "dev_challenge_1_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.dev_challenge_1_vpc_us_west_2.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "dev-challenge-public-subnet-${count.index + 1}"
  }
}

# Setup Internet Gateway, recursp necesario para dar acceso a interner a nuestra red.
resource "aws_internet_gateway" "dev_challenge_1_public_internet_gateway" {
  vpc_id = aws_vpc.dev_challenge_1_vpc_us_west_2.id
  tags = {
    Name = "dev-challenge-1-igw"
  }
}

# Public Route Table, enrutamiento para que nuestra red use el GW creado anteriormente.
resource "aws_route_table" "dev_challenge_1_public_route_table" {
  vpc_id = aws_vpc.dev_challenge_1_vpc_us_west_2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_challenge_1_public_internet_gateway.id
  }
  tags = {
    Name = "dev-challenge-1-public-rt"
  }
}

# Public Route Table and Public Subnet Association, Asociacion de nuestra red con la tabla de enrutamiento.
resource "aws_route_table_association" "dev_challenge_1_public_rt_subnet_association" {
  count          = length(aws_subnet.dev_challenge_1_public_subnets)
  subnet_id      = aws_subnet.dev_challenge_1_public_subnets[count.index].id
  route_table_id = aws_route_table.dev_challenge_1_public_route_table.id
}