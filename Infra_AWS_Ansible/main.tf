terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Módulo VPC
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone  = var.availability_zone
  vpc_name          = var.vpc_name
}

# Módulo Security Groups
module "security_groups" {
  source = "./modules/security_groups"
  
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
}

# Ansible Master (pública)
resource "aws_instance" "ansible_master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [module.security_groups.ansible_master_sg_id]
  
  associate_public_ip_address = true
  
  tags = {
    Name        = "Ansible-Master"
    Environment = "Laboratorio"
    Role        = "Master"
  }
}

# Terminales (privadas)
resource "aws_instance" "terminales" {
  count                  = 4
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [module.security_groups.terminal_sg_id]
  
  tags = {
    Name        = "Terminal-${count.index + 1}"
    Environment = "Laboratorio"
    Role        = "Terminal"
  }
}