# Laboratorio Ansible - Infraestructura AWS

## Arquitectura

### Red (VPC)
- **Nombre**: vpc-pruebas-laboratorio
- **CIDR**: 10.10.0.0/16
- **Public Subnet**: 10.10.1.0/24 (Ansible Master + NAT + IGW)
- **Private Subnet**: 10.10.2.0/24 (4 Terminales sin IP pública)

### Instancias
- **Ansible Master**: 1 instancia (pública)
- **Terminales**: 4 instancias (privadas)
- **AMI**: ami-0c1fe732b5494dc14 (Amazon Linux 2023)
- **Tipo**: c7i-flex.large
- **KeyPair**: pruebasvale5

### Routing
- **Public Route Table**: 0.0.0.0/0 → Internet Gateway
- **Private Route Table**: 0.0.0.0/0 → NAT Gateway

## Despliegue

### 1. Inicializar Terraform
```bash
cd Infra_AWS_Ansible
terraform init
```

### 2. Plan de despliegue
```bash
terraform plan
```

### 3. Aplicar infraestructura
```bash
terraform apply
```

## Post-despliegue

1. **Conectar al Ansible Master**:
   ```bash
   ssh -i pruebasvale5.pem ec2-user@<IP_PUBLICA_MASTER>
   ```

2. **Instalar Ansible**:
   ```bash
   sudo yum update -y
   sudo yum install -y ansible
   ```

3. **Configurar inventario**:
   ```bash
   sudo mkdir -p /etc/ansible
   sudo cp inventory.ini /etc/ansible/hosts
   ```

4. **Probar conexión**:
   ```bash
   ansible all -m ping
   ```

## Estructura de archivos

```
├── Infra_AWS_Ansible/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   └── modules/
│       ├── vpc/
│       └── security_groups/
└── Ansible/
    ├── inventory.ini
    ├── playbooks/
    └── roles/
```
