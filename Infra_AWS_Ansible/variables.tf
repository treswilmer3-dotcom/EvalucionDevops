variable "aws_region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block para la subnet pública"
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block para la subnet privada"
  type        = string
  default     = "10.10.2.0/24"
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "vpc-pruebas-laboratorio"
}

variable "ami_id" {
  description = "AMI ID para las instancias"
  type        = string
  default     = "ami-0c1fe732b5494dc14"
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "c7i-flex.large"
}

variable "key_name" {
  description = "Nombre del KeyPair"
  type        = string
  default     = "pruebasvale5"
}