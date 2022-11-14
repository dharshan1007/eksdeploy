data "aws_vpc" "default" {
  default = true
} 

data "aws_subnet" "default_public_subnet" {
  id = var.default_public_subnet_id
}

module "iam" {
  source = "./modules/iam"
  solution = var.solution
  environment = var.environment
}

module "security_groups" {
  source = "./modules/security_group"
  solution = var.solution
  environment = var.environment
  default_vpc_id = var.default_vpc_id
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  solution = var.solution
  environment = var.environment
  default_public_subnet_id = var.default_public_subnet_id
  jenkins_sg_id = "${module.security_groups.jenkins_sg_id}"
  dev_iam_instance_profile = "${module.iam.dev_iam_instance_profile}"
}

module "eks" {
  source = "./modules/eks"
  solution = var.solution
  environment = var.environment
  eks_vpc_cidr = var.eks_vpc_cidr
  db_password = var.db_password

}

module "ecr" {
  source = "./modules/ecr"
  solution = var.solution
  environment = var.environment
}

