output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID de la subnet pública"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID de la subnet privada"
  value       = aws_subnet.private.id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = aws_nat_gateway.main.id
}