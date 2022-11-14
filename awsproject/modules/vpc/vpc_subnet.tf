

/*
data "aws_availability_zones" "available" {

  filter {
    name   = "region-name"
    values = ["us-east-1"]
  }
}

resource "aws_vpc" "vpc_wp" {
  cidr_block = var.ad_vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-${var.environment}"
    environment = var.environment
    solution = var.solution
  }
}

resource "aws_internet_gateway" "gmarket-wp-gw" {
  vpc_id = aws_vpc.vpc_wp.id

  tags = {
    Name = "igw-${var.environment}"
    environment = var.environment
    solution = var.solution
  }
}

resource "aws_subnet" "wp_public_subnet" {
  vpc_id                  = aws_vpc.vpc_wp.id
 # count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = var.ad_public_subnet_cidr
 # availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${var.solution}-wp-public-subnet"
    environment = "${var.environment}"
    solution = var.solution
  }
}

resource "aws_subnet" "wp_private_subnet_1" {
  vpc_id            = aws_vpc.vpc_wp.id
  cidr_block        = var.ad_private_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
 
  tags = {
    Name        = "${var.environment}-${var.solution}-wp-private-subnet1"
    environment = "${var.environment}"
    solution = var.solution
   
  }
}

resource "aws_subnet" "wp_private_subnet_2" {
  vpc_id            = aws_vpc.vpc_wp.id
  cidr_block        = var.ad_private_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
 
  tags = {
    Name        = "${var.environment}-${var.solution}-wp-private-subnet2"
    environment = "${var.environment}"
    solution = var.solution  
  }
}

resource "aws_subnet" "wp_private_subnet_3" {
  vpc_id            = aws_vpc.vpc_wp.id
  cidr_block        = var.ad_private_subnet3_cidr
  availability_zone_id = "use1-az6"
 
  tags = {
    Name        = "${var.environment}-${var.solution}-wp-private-subnet3"
    environment = "${var.environment}"
    solution = var.solution  
  }
}

# create a custom route table to to attach igw to public subnet
resource "aws_route_table" "custom_igw" {
  vpc_id = aws_vpc.vpc_wp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gmarket-wp-gw.id
  }

  tags = {
    Name = "custom_route_with_igw"
  }
}

resource "aws_route_table_association" "wp_public_subnet_route" {
  subnet_id      = aws_subnet.wp_public_subnet.id
  route_table_id = aws_route_table.custom_igw.id
}

resource "aws_security_group" "gmarket_wp_sg" {
  name        = "${var.environment}-${var.solution}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC wp"
  vpc_id      = aws_vpc.vpc_wp.id
  depends_on  = [aws_vpc.vpc_wp]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  tags = {
    Name = "gmarket_wp_sg"
    environment = "${var.environment}"
    solution = var.solution
  }
}

resource "aws_security_group" "gmarket_nat_sg" {
  name        = "${var.environment}-${var.solution}-nat_wp-sg"
  description = "security group for NAT instance"
  vpc_id      = aws_vpc.vpc_wp.id
  depends_on  = [aws_vpc.vpc_wp]
  ingress {
    from_port = "-1"
    to_port   = "-1"
    protocol  = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  
  }
  
  tags = {
    Name = "gmarket_nat_sg"
    environment = "${var.environment}"
    solution = var.solution
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_security_group_rule" "rdp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gmarket_wp_sg.id
}

resource "aws_security_group_rule" "http_private_subnet_1" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = [var.ad_private_subnet1_cidr]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_security_group_rule" "http_private_subnet_2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = [var.ad_private_subnet2_cidr]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_security_group_rule" "http_private_subnet_3" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = [var.ad_private_subnet3_cidr]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_security_group_rule" "https_private_subnet_1" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [var.ad_private_subnet1_cidr]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_security_group_rule" "https_private_subnet_2" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [var.ad_private_subnet2_cidr]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_security_group_rule" "https_private_subnet_3" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [var.ad_private_subnet3_cidr]
  security_group_id = aws_security_group.gmarket_nat_sg.id
}

resource "aws_network_interface" "nat_instance" {
  subnet_id       = aws_subnet.wp_public_subnet.id
  security_groups = [aws_security_group.gmarket_nat_sg.id]
  source_dest_check = false

   tags = {
    Name = "gmarket_nat_nic"
    environment = "${var.environment}"
    solution = var.solution
  }

}

resource "aws_default_route_table" "ad_vpc" {
  default_route_table_id = aws_vpc.vpc_wp.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nat_instance.id
  }

  tags = {
    Name = "wp_ad_vpc"
  }
}

resource "aws_route_table_association" "nat_pvt_subnet1_route" {
  subnet_id      = aws_subnet.wp_private_subnet_1.id
  route_table_id = aws_default_route_table.ad_vpc.id
}

resource "aws_route_table_association" "nat_pvt_subnet2_route" {
  subnet_id      = aws_subnet.wp_private_subnet_2.id
  route_table_id = aws_default_route_table.ad_vpc.id
}

resource "aws_route_table_association" "nat_pvt_subnet3_route" {
  subnet_id      = aws_subnet.wp_private_subnet_3.id
  route_table_id = aws_default_route_table.ad_vpc.id
}








#k_chai@0522
#h_naga@0522


## set up vpc for development environment

resource "aws_vpc" "vpc_dev" {
  cidr_block = "172.32.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.solution}-dev"
    environment = var.environment
    solution = var.solution
  }
}

resource "aws_security_group" "gmarket_dev_sg" {
  name        = "${var.environment}-${var.solution}-dev-sg"
  description = "Default security group to allow inbound/outbound from the VPC wp"
  vpc_id      = aws_vpc.vpc_dev.id
  depends_on  = [aws_vpc.vpc_dev]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Name = "gmarket_dev_sg"
    environment = "${var.environment}"
    solution = var.solution
  }
}

resource "aws_internet_gateway" "gmarket-dev-gw" {
  vpc_id = aws_vpc.vpc_dev.id

  tags = {
    Name = "igw-${var.solution}-dev"
    environment = var.environment
    solution = var.solution
  }
}

resource "aws_subnet" "dev_public_subnet" {
  vpc_id                  = aws_vpc.vpc_dev.id
 # count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "172.32.0.0/20"
 # availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${var.solution}-dev-public-subnet"
    environment = "${var.environment}"
    solution = var.solution
  }
}

resource "aws_subnet" "dev_private_subnet_1" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "172.32.16.0/20"
  availability_zone_id = "use1-az2"
 
  tags = {
    Name        = "${var.environment}-${var.solution}-dev-private-subnet1"
    environment = "${var.environment}"
    solution = var.solution
   
  }
}

resource "aws_subnet" "dev_private_subnet_2" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "172.32.80.0/20"
  availability_zone_id = "use1-az4"
 
  tags = {
    Name        = "${var.environment}-${var.solution}-dev-private-subnet2"
    environment = "${var.environment}"
    solution = var.solution  
  }
}

resource "aws_subnet" "dev_private_subnet_3" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "172.32.64.0/20"
  availability_zone_id = "use1-az6"
 
  tags = {
    Name        = "${var.environment}-${var.solution}-dev-private-subnet3"
    environment = "${var.environment}"
    solution = var.solution  
  }
}


*/