# Security Group para Ansible Master
resource "aws_security_group" "ansible_master" {
  name        = "ansible-master-sg"
  description = "Security group para Ansible Master"
  vpc_id      = var.vpc_id

  # SSH acceso desde cualquier lugar
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ansible Tower/Controller UI (opcional)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida a internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ansible-Master-SG"
  }
}

# Security Group para Terminales
resource "aws_security_group" "terminal" {
  name        = "terminal-sg"
  description = "Security group para Terminales"
  vpc_id      = var.vpc_id

  # SSH solo desde Ansible Master
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.ansible_master.id]
  }

  # Comunicación interna entre terminales
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Salida a internet via NAT Gateway
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terminal-SG"
  }
}