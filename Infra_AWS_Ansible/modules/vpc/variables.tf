variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block para la subnet pública"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block para la subnet privada"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}