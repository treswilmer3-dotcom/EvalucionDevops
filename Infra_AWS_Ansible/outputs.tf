output "ansible_master_public_ip" {
  description = "IP pública del Ansible Master"
  value       = aws_instance.ansible_master.public_ip
}

output "ansible_master_private_ip" {
  description = "IP privada del Ansible Master"
  value       = aws_instance.ansible_master.private_ip
}

output "terminales_private_ips" {
  description = "IPs privadas de las terminales"
  value       = aws_instance.terminales[*].private_ip
}

output "terminales_ids" {
  description = "IDs de las instancias de las terminales"
  value       = aws_instance.terminales[*].id
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}