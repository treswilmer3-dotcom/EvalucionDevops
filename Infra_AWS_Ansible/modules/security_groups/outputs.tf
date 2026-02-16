output "ansible_master_sg_id" {
  description = "ID del Security Group de Ansible Master"
  value       = aws_security_group.ansible_master.id
}

output "terminal_sg_id" {
  description = "ID del Security Group de Terminales"
  value       = aws_security_group.terminal.id
}